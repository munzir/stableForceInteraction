function [K, KHist] = kanesLHSTree(f)

syms g real

dq = dqVec(f);
K = sym(zeros(length(dq), 1));
KHist=sym(zeros(length(dq),length(dq)));

key = keys(f);
for i=1:length(key)

    % Do nothing for frame 0
    if(isequal(key{i}, '0')); continue; end
    
    % Kinematics and Inertials Params
    w=angVel(f, key{i});
    alpha=angAcc(f, key{i});
    v=linVel(f, key{i});
    a=linAcc(f, key{i});
    J=inertiaMat(f, key{i});
    m=mass(f, key{i});
    mS=mCOM(f, key{i});
    S=mS/m;
    
    % Inertial Forces and Torques
    vG = v + cross(w, S);
    maG = m*(a + cross(alpha, S) + cross(w, cross(w, S)));
    dHnew = cross(mS, a) + J*alpha + cross(w, J*w);
    
    % Kanes LHS contributions
    for j=1:length(dq)
        disp(['kanesF: i=', num2str(i), ', j=', num2str(j), ', key=', key{i}]);
        KHist(j,f(key{i}).o) = maG'*diff(v, dq(j)) + dHnew'*diff(w, dq(j));
        K(j) = K(j) + KHist(j,f(key{i}).o);
    end
end