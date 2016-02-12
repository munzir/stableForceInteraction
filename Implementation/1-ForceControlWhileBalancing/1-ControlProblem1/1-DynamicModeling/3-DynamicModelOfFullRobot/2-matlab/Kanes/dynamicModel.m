nEqs = 19;
f = getKrangFrames(nEqs-1);
KKw = kanesLHSWheels(f);
[KKTree, KHist] = kanesLHSTree(f);
[AA, CC] = getAC(f, KKw + KKTree);
[K, KK, KK2, KK3, KK4] = kanesRHS(f);
