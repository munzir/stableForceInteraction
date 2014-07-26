/**
 * @file 03-compliantPositionControl.cpp
 * @author Munzir Zafar
 * @date Dec 2, 2013
 * @brief This file controls the position of the 4th joint of the right arm compliantly 
 */

#include <unistd.h>

#include <Eigen/Dense>
#include <iostream>

#include <dynamics/SkeletonDynamics.h>
#include <kinematics/BodyNode.h>
#include <robotics/parser/dart_parser/DartLoader.h>
#include <simulation/World.h>

#include "sensors.hpp"

using namespace Eigen;
using namespace std;
using namespace dynamics;

#define VELOCITY SOMATIC__MOTOR_PARAM__MOTOR_VELOCITY
#define POSITION SOMATIC__MOTOR_PARAM__MOTOR_POSITION
#define CURRENT SOMATIC__MOTOR_PARAM__MOTOR_CURRENT

/* ********************************************************************************************** */
somatic_d_t daemon_cx;
somatic_motor_t rlwaM7;

simulation::World* world;			///< the world representation in dart
SkeletonDynamics* robot;			///< the robot representation in dart

vector <int> rlwaM7_id;

/* ********************************************************************************************** */
// Estimated Paameters
double MY = -0.3250;
double MZ =  0.0059;
double XX =  0.4366;
double Fc1 = 3.2836;
double Fv1 = 11.4147;
double Fc2 = -3.5268;
double Fv2 = 5.0376;
double g = 9.8;
double Fc = 0.5*(Fc1 - Fc2);
double r = 0.47; // distance in meters of the FT sensor to the joint

// Control Gains
double Kp = 24.0;
double Kd = 0.0;
double Ki = 1.0;
double Km = 81.5/4.0; // Torque per Ampere of the motor  r*F/I = Km => F = I*Km/r => I = r*F/Km
double KComply = 3.0; // Desired inertia (torque per unit angular accleration (Nm-s^2/rad)) of the impedence controller

// Global variables for the algo
double qref = 0.0;
bool dynComp = false;
Eigen::Matrix<double, 3, 3> R;
FT * fts;

/* ********************************************************************************************* */
/// Change gains through keyboard input
void *kbhit(void *) {
	char input;
	while(true) { 
		input=cin.get(); 
		if(input=='a') { Kp += 0.1; cout << "Kp = " << Kp << endl; }
		else if(input=='s') { Kp -= 0.1; cout << "Kp = " << Kp << endl; }
		else if(input=='A') { Kp += 0.5; cout << "Kp = " << Kp << endl; }
		else if(input=='S') { Kp -= 0.5; cout << "Kp = " << Kp << endl; }
		else if(input=='q') { Ki += 0.1; cout << "Ki = " << Ki << endl; }
		else if(input=='w') { Ki -= 0.1; cout << "Ki = " << Ki << endl; }
		else if(input=='Q') { Ki += 0.5; cout << "Ki = " << Ki << endl; }
		else if(input=='W') { Ki -= 0.5; cout << "Ki = " << Ki << endl; }
		else if(input=='z') { Kd += 0.1; cout << "Kd = " << Kd << endl; }
		else if(input=='x') { Kd -= 0.1; cout << "Kd = " << Kd << endl; }
		else if(input=='Z') { Kd += 0.5; cout << "Kd = " << Kd << endl; }
		else if(input=='X') { Kd -= 0.5; cout << "Kd = " << Kd << endl; }
		else if(input=='o') { KComply += 0.01; cout << "KComply = " << KComply << endl; }
		else if(input=='p') { KComply -= 0.01; cout << "KComply = " << KComply << endl; }
		else if(input=='d') { dynComp = true; cout << "Dynamic Compensation: ON" << Kd << endl; }
		else if(input=='D') { dynComp = false; cout << "Dynamic Compensation: OFF" << Kd << endl; }
		else if(input=='t') { 
			cout << "\n\n" << R(0,0) << "\t" << R(0,1) << "\t" << R(0,2) << endl; 
			cout << R(1,0) << "\t" << R(1,1) << "\t" << R(1,2) << endl; 
			cout << R(2,0) << "\t" << R(2,1) << "\t" << R(2,2) << "\n\n\n"; 
		}
		else if(input >= '0' & input <= '9') { qref = -2*M_PI/3.0 + (input-'0')*(4.0*M_PI/3.0/9.0); cout << "qref = " << qref << endl;}
	}
}

/* ********************************************************************************************* */
static void initArm (somatic_d_t& daemon_cx, somatic_motor_t& arm, const char* armName) {	

	// Get the channel names
	char cmd_name [16], state_name [16];
	sprintf(cmd_name, "%s-cmd", armName);
	sprintf(state_name, "%s-state", armName);

	// Initialize the arm with the daemon context, channel names and # of motors
	somatic_motor_init(&daemon_cx, &arm, 1, cmd_name, state_name);
	usleep(1e5);

	// Set the min/max values for valid and limits values
	double** limits [] = {
		&arm.pos_valid_min, &arm.vel_valid_min, 
		&arm.pos_limit_min, &arm.pos_limit_min, 
		&arm.pos_valid_max, &arm.vel_valid_max, 
		&arm.pos_limit_max, &arm.pos_limit_max};
	for(size_t i = 0; i < 4; i++) aa_fset(*limits[i], -1024.1, 1);
	for(size_t i = 4; i < 8; i++) aa_fset(*limits[i], 1024.1, 1);
	
	// Update and reset them
	somatic_motor_update(&daemon_cx, &arm);
	somatic_motor_cmd(&daemon_cx, &arm, SOMATIC__MOTOR_PARAM__MOTOR_RESET, NULL, 1, NULL);
	usleep(1e5);

}

/* ******************************************************************************************** */
void updateKinematics () {

	int left_arm_ids_a [7] = {11, 13, 15, 17, 19, 21, 23}; 
	int right_arm_ids_a [7] = {12, 14, 16, 18, 20, 22, 24}; 
	int imuWaist_ids_a [2] = {5, 8};
	vector <int> left_arm_ids (left_arm_ids_a, left_arm_ids_a + 7);						
	vector <int> right_arm_ids (right_arm_ids_a, right_arm_ids_a + 7);	
	vector <int> imuWaist_ids (imuWaist_ids_a, imuWaist_ids_a + 2);		

	// unify the id vectors so we only have to make a single call
	// TODO: move this to an outside variable and initialize in the
	// the init function
	std::vector<int> all_ids;
	all_ids.insert(all_ids.end(), imuWaist_ids.begin(), imuWaist_ids.end());
	all_ids.insert(all_ids.end(), left_arm_ids.begin(), left_arm_ids.end());
	all_ids.insert(all_ids.end(), right_arm_ids.begin(), right_arm_ids.end());
	
	// a spot to unify the config vectors for same
	Eigen::VectorXd all_vals(all_ids.size());
	double imu = -107.0*M_PI/180.0, waist_val = 150.0*M_PI/180.0;
	Vector2d imuWaist_vals (-imu + M_PI_2, waist_val);
	for(int i = 0; i < imuWaist_vals.size(); i++) all_vals[i] = imuWaist_vals[i];

	// Update the arms state
	Eigen::Matrix <double, 7, 1> larm_vals, rarm_vals; 
	larm_vals << 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0;
	for(int i = 0; i < larm_vals.size(); i++) all_vals[imuWaist_ids.size() + i] = larm_vals[i];
	rarm_vals <<  0.877, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0;
	for(int i = 0; i < rarm_vals.size(); i++) all_vals[imuWaist_ids.size() + left_arm_ids.size() + i] = rarm_vals[i];

	robot->setConfig(all_ids, all_vals);
}

/* ********************************************************************************************* */
void run() {

	// Send a message; set the event code and the priority
	somatic_d_event(&daemon_cx, SOMATIC__EVENT__PRIORITIES__NOTICE, 
			SOMATIC__EVENT__CODES__PROC_RUNNING, NULL, NULL);

	// Unless an interrupt or terminate message is received, process the new message
	struct timespec t_prev = aa_tm_now(), t_now ;
	double time, dt;
	double sumError = 0.0;
	int c = 0;
	double qRef_f = 0.0;
	VectorXd qVectorXd (1);

	while(!somatic_sig_received) {

		// Update timer		
		t_now = aa_tm_now();						
		dt = (double)aa_tm_timespec2sec(aa_tm_sub(t_now, t_prev));	
		t_prev = t_now;
		time += dt;

		// Position Update 
		somatic_motor_update(&daemon_cx, &rlwaM7);
		double q = rlwaM7.pos[0], dq = rlwaM7.vel[0];
		qVectorXd << q;
		robot->setConfig(rlwaM7_id, qVectorXd);

		// Force Sensing 
		fts->updateExternal();
		double f;
		Matrix<double, 3, 1> F = fts->lastExternal.topLeftCorner<3,1>();
		R = robot->getNode("rGripper")->getWorldTransform().topLeftCorner<3,3>().transpose();
		F = R*F;
		if(F.topLeftCorner<3,1>().norm() > 7.0) f = F(1); else f = 0.0;

		// Control position compliantly
		double error = qref - q; 
		if(abs(error) < 0.3 && abs(f) < 10.0) sumError += error;
		double w = Kp*error - Kd*dq + Ki*sumError;
		double u = XX*w + (1/Km)*KComply*f*r + (dynComp? g*MY*cos(q) + g*MZ*sin(q) + ((abs(dq) > 0.5 
				& abs(error) > 1.1 ) ? ( dq > 0.0 ? (Fc1 + Fv1*dq) : (Fc2 + Fv2*dq) ) : 0.0) : 0.0);
		u = min(max(u, -14.0), 14.0);
		somatic_motor_cmd(&daemon_cx, &rlwaM7, CURRENT, &u, 1, NULL);
		cout << "f = " << f << "       q-qref = " << -error << "    Ki*sumError = " << Ki*sumError << "     \r";

		// Free buffers allocated during this cycle
		aa_mem_region_release(&daemon_cx.memreg);	
		usleep(1e4); 
	}

	// Send the stoppig event
	somatic_d_event(&daemon_cx, SOMATIC__EVENT__PRIORITIES__NOTICE,
					 SOMATIC__EVENT__CODES__PROC_STOPPING, NULL, NULL);
}


/* ********************************************************************************************* */
void init () {
	
	// Initialize this daemon (program!)
	somatic_d_opts_t dopt;
	memset(&dopt, 0, sizeof(dopt)); // zero initialize
	dopt.ident = "03-compliantPositionControl";
	somatic_d_init( &daemon_cx, &dopt );

	// Initialize the arms and the torso module
	initArm(daemon_cx, rlwaM7, "rlwa-m7");

	// Create a thread to wait for user input to begin balancing
	pthread_t kbhitThread;
	pthread_create(&kbhitThread, NULL, &kbhit, NULL);

	// Initializing the robot with the fixed pose we are working with
	updateKinematics();
	
	// Initialize the force torque sensor
	somatic_motor_update(&daemon_cx, &rlwaM7);
	VectorXd qVectorXd (1);
	qVectorXd << rlwaM7.pos[0];
	rlwaM7_id.push_back(18);
	robot->setConfig(rlwaM7_id, qVectorXd);
	fts = new FT(FT::GRIPPER_TYPE_ROBOTIQ, &daemon_cx, robot, FT::RIGHT);

}

/* ********************************************************************************************* */
void destroy() {

	// Halt the Schunk modules
	somatic_motor_cmd(&daemon_cx, &rlwaM7, SOMATIC__MOTOR_PARAM__MOTOR_HALT, NULL, 1, NULL);

	// Destroy the daemon resources
	somatic_d_destroy(&daemon_cx);
}

/* ********************************************************************************************* */
int main() {
	
	// Load the world and the robot
	DartLoader dl;
	world = dl.parseWorld("/home/munzir/Documents/Software/project/krang/experiments/common/scenes/01-World-Robot.urdf");
	assert((world != NULL) && "Could not find the world");
	robot = world->getSkeleton(0);

	init();
	run();
	destroy();

	return 0;
}
