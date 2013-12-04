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
 * @file sensors.hpp
 * @author Can Erdogan, Saul Reynolds-Haertle
 * @date July 24, 2013
 * @brief The header file for the sensor class and helper functions associated with Krang.
 */

#pragma once

#include <Eigen/Dense>

#include <somatic.h>
#include <somatic/daemon.h>
#include <somatic.pb-c.h>
#include <somatic/motor.h>
#include <dynamics/SkeletonDynamics.h>
#include <kinematics/BodyNode.h>
#include <simulation/World.h>

typedef Eigen::Matrix<double, 6, 1> Vector6d;

/* ******************************************************************************************** */
class FT {
public:

	/// Indicates which type of gripper is after the f/t sensor which affects the mass and com
	enum GripperType { GRIPPER_TYPE_ROBOTIQ = 0, GRIPPER_TYPE_SCHUNK, GRIPPER_TYPE_NONE };
	enum Side {LEFT = 0, RIGHT};

	/// The constructor. The type of the gripper after f/t affects the readings, robot + side are
	/// used to estimate the frame of the f/t in the robot base frame.
	FT (GripperType type, somatic_d_t* daemon_cx, dynamics::SkeletonDynamics* robot, Side side);
	bool getRaw(Vector6d& raw);  					///< Gets the latest raw reading from the f/t channel
	void updateExternal();								///< Updates estimate for the external input 

	/// Computes the error between ideal and expected readings assuming no external forces
	/// This is used in the beginning to compute an offset when we "know" we have no external forces
	/// and also to estimate the external forces. Note that the output is in sensor frame!
  void error(const Vector6d& reading, Vector6d& error, bool inWorldFrame, Vector6d* errorInSensorFrame = NULL);	

public:
	// Variables to compensate for the weight of the gripper

	/// The offset from the raw readings for the ideal readings. An ideal reading still has the
	/// weight of the gripper and any other external weights in it.
	Vector6d offset;	
	Vector6d lastExternal;			///< The last estimate for the external force/torque input
	Vector6d lastExternalInSensorFrame;			///< The last estimate for the external force/torque input
	double gripperMass;					///< The mass of the objects after the f/t sensor
	Eigen::Vector3d gripperCoM;				///< The center of mass of the objects after the f/t sensor

public:
	// Variables to determine the kinematics that affect the compensation and the data channel

	Side side;															///< Indices the left or the right f/t sensor
	dynamics::SkeletonDynamics* robot;			///< The kinematics of the robot
	somatic_d_t* daemon_cx;
	ach_channel_t* chan;										///< The data channel
};

