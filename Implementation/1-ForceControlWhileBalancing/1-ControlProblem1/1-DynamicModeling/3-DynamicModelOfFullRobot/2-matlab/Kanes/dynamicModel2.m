nEqs = 19;
f = getKrangFrames(nEqs-1);
KKw_ = kanesLHSWheels_(f);
[KKTree_, KHist_] = kanesLHSTree_(f);
[AA_, CC_] = getAC(f, KKw_ + KKTree_);
[K_, KK_, KK2_, KK3_, KK4_] = kanesRHS_(f);
