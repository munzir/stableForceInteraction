function [K, KHist] = kanesLHSTree_(f)

dq = dqVec(f);
K = sym(zeros(length(dq), 1));
KHist=sym(zeros(length(dq),length(dq)));
key = keys(f);

% For dq(1) = dx
for i = 1:length(key)
    % Do nothing for frame 0
    if(isequal(key{i}, '0')); continue; end
    
    % Kinematics and Inertials Params
    w=angVel(f, key{i});
    alpha=angAcc(f, key{i});
    a=linAcc(f, key{i});
    m=mass(f, key{i});
    mS=mCOM(f, key{i});
    S=mS/m;
    maG = m*(a + cross(alpha, S) + cross(w, cross(w, S)));
    T = Tf(f, key{i}, '0');
    ROT = T(1:3,1:3);
    KHist(1, f(key{i}).o) = (ROT*maG)'*[1; 0; 0];
    K(1) = K(1) + KHist(1, f(key{i}).o);
end

% dq != dx
for i=1:length(key) % signifies each equation
    for j=1:length(key) % signifies each body
        
        % Do nothing for frame 0
        if(isequal(key{j}, '0')); continue; end
        
        % Do nothing if the frame corresponding to this equation neither
        % precedes nor equals the frame corresponding to this body
        if(~isBefore(f, key{i}, key{j}) && ~isequal(key{i},key{j})); 
            continue; 
        end
        
        % Kinematics and Inertials Params
        w=angVel(f, key{j});
        alpha=angAcc(f, key{j});
        v=linVel(f, key{j});
        a=linAcc(f, key{j});
        J=inertiaMat(f, key{j});
        m=mass(f, key{j});
        mS=mCOM(f, key{j});
        S=mS/m;
        T = Tf(f, key{j}, key{i});
        ROT = T(1:3,1:3);
        rOO = T(1:3,4);
        
        maG = ROT*m*(a + cross(alpha, S) + cross(w, cross(w, S)));
        dHnew = ROT*(cross(mS, a) + J*alpha + cross(w, J*w));

        disp(['kanesF: i=', num2str(i), ', j=', num2str(j), ', key=', key{i}]);
        KHist(f(key{i}).o, f(key{j}).o) = (cross(rOO, maG) + dHnew)'*f(key{i}).e;
        K(f(key{i}).o) = K(f(key{i}).o) + KHist(f(key{i}).o, f(key{j}).o);
    end
end