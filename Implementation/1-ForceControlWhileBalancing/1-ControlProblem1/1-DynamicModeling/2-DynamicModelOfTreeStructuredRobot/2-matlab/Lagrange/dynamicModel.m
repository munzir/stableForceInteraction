% author: Munzir Zafar
% date: Aug 2, 2014
% brief: Finding the dynamic model of krang 

f = getKrangFrames(17);
E = totalKE(f);
U = totalPE(f);
A = findA(f, E);
C = findC(f, A);
Q = findQ(f, U);