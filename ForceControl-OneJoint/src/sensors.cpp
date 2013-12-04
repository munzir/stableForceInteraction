/*
 * Copyright (c) 2011, Georgia Tech Research Corporation
 * All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without modification, are permitted
 * provided that the following conditions are met:
 *
 *     * Redistributions of source code must retain the above copyright notice, this list of
 *       conditions and the following disclaimer.
 *     * Redistributions in binary form must reproduce the above copyright notice, this list of
 *       conditions and the following disclaimer in the documentation and/or other materials
 *       provided with the distribution.
 *     * Neither the name of the Georgia Tech Research Corporation nor the names of its
 *       contributors may be used to endorse or promote products derived from this software without
 *       specific prior written permission.
 *
 * THIS SOFTWARE IS PROVIDED BY GEORGIA TECH RESEARCH CORPORATION ''AS IS'' AND ANY EXPRESS OR
 * IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND
 * FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL GEORGIA TECH RESEARCH
 * CORPORATION BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
 * DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF
 * USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
 * WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN
 * ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 *
 */

/**
 * @file sensors.cpp
 * @author Can Erdogan
 * @date July 24, 2013
 * @brief The source file for the sensor class and helper functions associated with Krang.
 */

#include "sensors.hpp"
#include <vector>

using namespace std;
using namespace Eigen;


/* ******************************************************************************************** */
FT::FT (GripperType type, somatic_d_t* daemon_cx_, dynamics::SkeletonDynamics* r_, Side side_) {

	// Sanity check the input and set the local bariables
	assert((r_ != NULL) && "Can not initialize the f/t sensors without robot kinematics");
	robot = r_;
	daemon_cx = daemon_cx_;
	side = side_;

	// Open the data channel
	chan = new ach_channel_t();
	somatic_d_channel_open(daemon_cx, chan, (side == LEFT) ? "llwa_ft" : "rlwa_ft", NULL);

	// Set the gripper mass and center of mass based on the type: the com for ext, schunk and robotiq
	// are 0.026, 0.0683, 0.065 (?)
	gripperMass = 0.169;			//< f/t extension mass (will be there regardless of type)
	if(type == GRIPPER_TYPE_ROBOTIQ) {
		gripperMass += 2.3;
		gripperCoM = Vector3d(0.0, 0.0, 0.09);
	}
	else if (type == GRIPPER_TYPE_SCHUNK) {
		gripperMass += 1.6;
		gripperCoM = Vector3d(0.0, -0.000, 0.091);
	}
	else gripperCoM = Vector3d(0.0, -0.000, 0.013);

	// Average one second's worth of FT readings and average to get a good initial reading
	double time_ft_av_start = aa_tm_timespec2sec(aa_tm_now());
	int num_data = 0;
	Vector6d data = Vector6d::Zero(), temp;
	while((num_data < 100) || (aa_tm_timespec2sec(aa_tm_now()) - time_ft_av_start < 1.0)) {
		num_data++;
		bool gotReading = false;
		while(!gotReading) gotReading = getRaw(temp);
		data += temp;
	}
	data /= (double)num_data;

	// Compute the offset between what the reading should be and what it is assuming no external
	// forces
	error(data, offset, false);	
}

/* ******************************************************************************************** */
void FT::error(const Vector6d& reading, Vector6d& error, bool inWorldFrame, Vector6d* errorInSensorFrame) {

	// Get the point transform wrench due to moving the affected position from com to sensor origin
	// The transform is an identity with the bottom left a skew symmetric of the point translation
	Matrix<double, 6, 6> pTcom_sensor = MatrixXd::Identity(6,6); 
	pTcom_sensor.bottomLeftCorner<3,3>() << 0.0, -gripperCoM(2), gripperCoM(1), gripperCoM(2), 
		0.0, -gripperCoM(0), -gripperCoM(1), gripperCoM(0), 0.0;

	// Get the rotation between the world frame and the sensor frame. 
	const char* nodeName = (side == LEFT) ? "lGripper" : "rGripper";
	Matrix<double, 3, 3> R = robot->getNode(nodeName)->getWorldTransform().topLeftCorner<3,3>().transpose();

	// Create the wrench with computed rotation to change the frame from the world to the sensor
	Matrix<double, 6, 6> pSsensor_world = MatrixXd::Identity(6,6); 
	pSsensor_world.topLeftCorner<3,3>() = R;
	pSsensor_world.bottomRightCorner<3,3>() = R;

	// Get the weight vector (note that we use the world frame for gravity so towards -y)
	Vector6d weightVector_in_world;
	weightVector_in_world << 0.0, 0.0, -gripperMass * 9.81, 0.0, 0.0, 0.0;

	// Compute what the force and torque should be without any external values by multiplying the 
	// position and rotation transforms with the expected effect of the gravity 
	Vector6d expectedFT = pTcom_sensor * pSsensor_world * weightVector_in_world;

	// Compute the difference between the actual and expected f/t values
	error = expectedFT - reading;
	if(errorInSensorFrame) *errorInSensorFrame = error;
	if(inWorldFrame) error = pSsensor_world.transpose() * error;	
}

/* ******************************************************************************************** */
void FT::updateExternal () {

	// Attempt to get the current reading. If failed, return the last value
	Vector6d raw;
	if(!getRaw(raw)) return;

	// Supplement raw with the offset
	Vector6d ideal = raw + offset;

	// Otherwise, compute the external reading as the difference between expected reading due to
	// gripper weight and the current ideal reading, in the world frame
	error(ideal, lastExternal, true, &lastExternalInSensorFrame);
}

/* ******************************************************************************************** */
bool FT::getRaw (Vector6d& raw) {

	// Check if there is anything to read
	// TODO Remove aa_tm_future
	int result;
	size_t numBytes = 0;
	struct timespec abstimeout = aa_tm_future(aa_tm_sec2timespec(.001));
	uint8_t* buffer = (uint8_t*) somatic_d_get(daemon_cx, chan, &numBytes, &abstimeout, ACH_O_LAST, 
																						 &result);

	// Return if there is nothing to read
	if(numBytes == 0) return false;

	// Read the message with the base struct to check its type
	Somatic__BaseMsg* msg = somatic__base_msg__unpack(&(daemon_cx->pballoc), numBytes, buffer);
	if((msg->meta == NULL) || !msg->meta->has_type) return false;
	if(msg->meta->type != SOMATIC__MSG_TYPE__FORCE_MOMENT) return false;

	// Read the force-torque message and write it into the vector
	Somatic__ForceMoment* ftMessage = somatic__force_moment__unpack(&(daemon_cx->pballoc), 
																																	numBytes, buffer);
	for(size_t i = 0; i < 3; i++) raw(i) = ftMessage->force->data[i]; 
	for(size_t i = 0; i < 3; i++) raw(i+3) = ftMessage->moment->data[i]; 
	return true;
} // end of namespace
