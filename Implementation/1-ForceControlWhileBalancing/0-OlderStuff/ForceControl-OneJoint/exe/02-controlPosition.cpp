/**
 * @file 02-controlPosition.cpp
 * @author Munzir Zafar
 * @date Dec 1, 2013
 * @brief This file controls the position for one joint (m7) of the right arm 
 */

#include <unistd.h>

#include <Eigen/Dense>
#include "motion.h"
#include <iostream>

using namespace Eigen;
using namespace std;

#define VELOCITY SOMATIC__MOTOR_PARAM__MOTOR_VELOCITY
#define POSITION SOMATIC__MOTOR_PARAM__MOTOR_POSITION
#define CURRENT SOMATIC__MOTOR_PARAM__MOTOR_CURRENT

/* ********************************************************************************************** */
somatic_d_t daemon_cx;
somatic_motor_t rlwaM7;

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
double Kp = 24.0;
double Kd = 0.0;
double Ki = 1.0;

// Global variables for the algo
double qref = 0.0;
bool dynComp = false;

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
		else if(input=='d') { dynComp = true; cout << "Dynamic Compensation: ON" << Kd << endl; }
		else if(input=='D') { dynComp = false; cout << "Dynamic Compensation: OFF" << Kd << endl; }
		else if(input >= '0' & input <= '9') { qref = -2*M_PI/3.0 + (input-'0')*(4.0*M_PI/3.0/9.0); cout << "qref = " << qref << endl;}
	}
}

/* ********************************************************************************************* */
/// Continuously process the joystick data and sets commands to the modules
void run() {

	// Send a message; set the event code and the priority
	somatic_d_event(&daemon_cx, SOMATIC__EVENT__PRIORITIES__NOTICE, 
			SOMATIC__EVENT__CODES__PROC_RUNNING, NULL, NULL);

	// Unless an interrupt or terminate message is received, process the new message
	struct timespec t_prev = aa_tm_now(), t_now ;
	double time, dt;
	double sumError = 0.0;

	while(!somatic_sig_received) {

		// Update sensors and timer
		somatic_motor_update(&daemon_cx, &rlwaM7);
		t_now = aa_tm_now();						
		dt = (double)aa_tm_timespec2sec(aa_tm_sub(t_now, t_prev));	
		t_prev = t_now;
		time += dt;

		// Control Law
		double q = rlwaM7.pos[0], dq = rlwaM7.vel[0];
		double error = qref - q; if(abs(error) < 0.3) sumError += error;
		double w = Kp*error - Kd*dq + Ki*sumError;
		double u = XX*w + (dynComp? g*MY*cos(q) + g*MZ*sin(q) + ((abs(dq) > 0.5 & abs(error) > 0.1 ) ? ( dq > 0.0 ? (Fc1 + Fv1*dq) : (Fc2 + Fv2*dq) ) : 0.0) : 0.0);
		//cout << "u (" << u << ") = XX*w (" << XX*w << ") + g*MY*cos(q) (" << g*MY*cos(q) << ") + g*MZ*sin(q) (" << g*MZ*sin(q) << ") + Friction (" << ((abs(dq) > 0.5 & abs(qref-q) > 0.1 ) ? ( dq > 0.0 ? (Fc1 + Fv1*dq) : (Fc2 + Fv2*dq)  ) : 0) <<  ") --- sumError: " << sumError << endl; 
		u = min(max(u, -14.0), 14.0);
		somatic_motor_cmd(&daemon_cx, &rlwaM7, CURRENT, &u, 1, NULL);
		cout << "q-qref = " << -error << "    \r";

		// Free buffers allocated during this cycle
		aa_mem_region_release(&daemon_cx.memreg);	
		usleep(1e4);
	}

	// Send the stoppig event
	somatic_d_event(&daemon_cx, SOMATIC__EVENT__PRIORITIES__NOTICE,
					 SOMATIC__EVENT__CODES__PROC_STOPPING, NULL, NULL);
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
/* ********************************************************************************************* */
void init () {
	
	// Initialize this daemon (program!)
	somatic_d_opts_t dopt;
	memset(&dopt, 0, sizeof(dopt)); // zero initialize
	dopt.ident = "02-controlPosition";
	somatic_d_init( &daemon_cx, &dopt );

	// Initialize the arms and the torso module
	initArm(daemon_cx, rlwaM7, "rlwa-m7");

	// Create a thread to wait for user input to begin balancing
	pthread_t kbhitThread;
	pthread_create(&kbhitThread, NULL, &kbhit, NULL);

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

	init();
	run();
	destroy();

	return 0;
}
