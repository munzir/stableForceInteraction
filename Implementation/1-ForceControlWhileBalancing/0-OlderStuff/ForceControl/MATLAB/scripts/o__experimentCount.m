function [total, totals] = experimentCount(inc)

rotMin = -180; rotMax = 180;
bendMin = -120; bendMax = 120;

r = length(rotMin:inc:rotMax);
b = length(bendMin:inc:bendMax);

%% A: Experiment 1, 4 using a rotating joint
lockedR = 3;
lockedB = 3;
numComb = 4;
numExp  = 2;
totals(1) = numComb*numExp*(r^lockedR)*(b^lockedB);
%% B: Experiment 1, 4 using a bending joint
lockedR = 4;
lockedB = 2;
numComb = 3;
numExp  = 2;
totals(2) = numComb*numExp*(r^lockedR)*(b^lockedB);
%% C: Experiment 2, 3 using two rotating joints
lockedR = 2;
lockedB = 3;
numComb = 6;
numExp  = 2;
totals(3) = numComb*numExp*(r^lockedR)*(b^lockedB);
%% D: Experiment 2, 3 using two bending joints
lockedR = 4;
lockedB = 1;
numComb = 3;
numExp  = 2;
totals(4) = numComb*numExp*(r^lockedR)*(b^lockedB);
%% E: Experiment 2, 3 using a rotating joint and a bending joint
lockedR = 3;
lockedB = 2;
numComb = 12;
numExp  = 2;
totals(5) = numComb*numExp*(r^lockedR)*(b^lockedB);

%% Total number of experiments
total = sum(totals);