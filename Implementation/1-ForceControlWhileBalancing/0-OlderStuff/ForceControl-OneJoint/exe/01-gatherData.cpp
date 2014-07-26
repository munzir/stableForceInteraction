/**
 * @file 01-gatherData.cpp
 * @author Munzir Zafar
 * @date Nov 27, 2013
 * @brief This file runs the fourth jont of the right arm through a trajectory and measures data
 * to estimate the dynamic parameters of the arm.
 */

#include <Eigen/Dense>
#include "initModules.h"
#include "motion.h"
#include <iostream>

using namespace Eigen;
using namespace std;

#define VELOCITY SOMATIC__MOTOR_PARAM__MOTOR_VELOCITY
#define POSITION SOMATIC__MOTOR_PARAM__MOTOR_POSITION

/* ********************************************************************************************** */
somatic_d_t daemon_cx;
somatic_motor_t llwa, rlwa;


/* ********************************************************************************************* */
/// Continuously process the joystick data and sets commands to the modules
void run() {

	// Send a message; set the event code and the priority
	somatic_d_event(&daemon_cx, SOMATIC__EVENT__PRIORITIES__NOTICE, 
			SOMATIC__EVENT__CODES__PROC_RUNNING, NULL, NULL);

	// Unless an interrupt or terminate message is received, process the new message
	struct timespec t_prev = aa_tm_now(), t_now ;
	double time, dt;
	int mstate = 0;
	double dist;
	bool quit = false;
	double dqMin = 15*M_PI/180.0, ddqMax = 1.6581, qBang, dqLim;
	double qA[7] = {0.876, 0.0, 0.0, -M_PI_2, 0.0, 0.0, 0.0 };
	double qB[7] = {0.876, 0.0, 0.0, M_PI_2, 0.0, 0.0, 0.0 };
	double qInit[7];
	double dq[7] = {0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0};
	Matrix <double, 4, 1> logState;
	vector <Matrix <double, 4, 1>> log;
	int cycles =2, cycle = 0;

	while(!somatic_sig_received) {

		// Update sensora and timer
		somatic_motor_update(&daemon_cx, &rlwa);
		t_now = aa_tm_now();						
		dt = (double)aa_tm_timespec2sec(aa_tm_sub(t_now, t_prev));	
		t_prev = t_now;
		time += dt;

		// Log data
		logState << time, rlwa.pos[3], rlwa.vel[3], rlwa.cur[3];
		log.push_back(logState);

		switch(mstate) {

			// Start with qA
			case 0:
				dist = 0.0;
				for(int i = 0; i < 7; i++) {
					qInit[i] = rlwa.pos[i];
					dist += pow(qInit[i] - qA[i], 2.0);
				}
				if(dist > 0.02) {
					cout << "Robot pose not set!" << endl;
					quit = true;
				} else mstate = 1;
				break;

			// inc speed by ddqMax till qMin. Note qBang.
			case 1:
				if(rlwa.vel[3] >= dqMin & dq[3] == dqMin) {
					mstate = 2;
					qBang = rlwa.pos[3] - qA[3];
					//cout <<  "qBang = " << qBang << endl;
				}
				dq[3] = min(rlwa.vel[3] + ddqMax*dt, dqMin);
				somatic_motor_cmd(&daemon_cx, &rlwa, VELOCITY, dq, 7, NULL);
				break;

			// keep steady at dqMin util qB-qBang
			case 2:
				if(rlwa.pos[3] >= qB[3]-qBang) mstate = 3;
				dq[3] = dqMin;
				somatic_motor_cmd(&daemon_cx, &rlwa, VELOCITY, dq, 7, NULL);
				break;

			// decrease speed till -dqMin 
			case 3:
				if(rlwa.vel[3] <= -dqMin && dq[3] == -dqMin) mstate = 4;
				dq[3] = max(rlwa.vel[3] - ddqMax*dt, -dqMin);
				somatic_motor_cmd(&daemon_cx, &rlwa, VELOCITY, dq, 7, NULL);
				break;

			// stay at -dqMin until qA+qBang
			case 4:
				if(rlwa.pos[3] <= qA[3]+qBang) mstate = 5;
				dq[3] = -dqMin;
				somatic_motor_cmd(&daemon_cx, &rlwa, VELOCITY, dq, 7, NULL);
				break;

			// increase speed till qMin, go to mstate 2 if more cycles left
			case 5:
				dqLim = cycle >= cycles-1 ? 0.0 : dqMin;
				if(rlwa.vel[3] >= dqLim && dq[3] == dqLim) { 
					mstate = 2;
					quit = (++cycle >= cycles);
				}
				dq[3] = min(rlwa.vel[3] + ddqMax*dt, dqLim);
				somatic_motor_cmd(&daemon_cx, &rlwa, VELOCITY, dq, 7, NULL);
				break;

		}

		// Quit
		if(quit) break;

		// Free buffers allocated during this cycle
		aa_mem_region_release(&daemon_cx.memreg);	
		usleep(1e4);
	}

	// Print log
	for(int i = 0; i < log.size(); i++)
		cout << log[i](0) << ", " << log[i](1) << ", " << log[i](2) << ", " << log[i](3) << endl; 

	// Send the stoppig event
	somatic_d_event(&daemon_cx, SOMATIC__EVENT__PRIORITIES__NOTICE,
					 SOMATIC__EVENT__CODES__PROC_STOPPING, NULL, NULL);
}

/* ********************************************************************************************* */
void init () {
	
	// Initialize this daemon (program!)
	somatic_d_opts_t dopt;
	memset(&dopt, 0, sizeof(dopt)); // zero initialize
	dopt.ident = "01-gatherData";
	somatic_d_init( &daemon_cx, &dopt );

	// Initialize the arms and the torso module
	initArm(daemon_cx, rlwa, "rlwa");

}

/* ********************************************************************************************* */
void destroy() {

	// Halt the Schunk modules
	somatic_motor_cmd(&daemon_cx, &rlwa, SOMATIC__MOTOR_PARAM__MOTOR_HALT, NULL, 7, NULL);

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
