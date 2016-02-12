function [K, KK, KK2, KK3, KK4] = kanesRHS_(f)

dq = dqVec(f);
KK2 = sym(zeros(length(dq), length(dq)-3)); % Stores the contribution of each joint torque (nRows=ndqs, nCols=nTorques)
KK3 = sym(zeros(length(dq), 4)); % Stores the contribution of 1. Fel 2. tae_el 3. Fer 4. tau_er
KK4 = sym(zeros(length(dq), length(dq)-2)); % Stores the contribution of each link weight (nRows=ndqs, nCols=nLinks)
KK = sym(zeros(length(dq),4)); % Store contribution sums of 1. wheel torques 2. joint torques 3. End Eff F/T 4. Weights
K = sym(zeros(length(dq),1));  % Store the sum of all contributions

%% Wheel/Joint Torques

syms tau_L tau_R L R real
syms tau_w tau_torso real
syms tau_1l tau_2l tau_3l tau_4l tau_5l tau_6l tau_7l real
syms tau_1r tau_2r tau_3r tau_4r tau_5r tau_6r tau_7r  real

KK(:,1) = [(tau_L+tau_R)/R; (tau_R-tau_L)*L/(2*R); -(tau_L+tau_R); ...
    0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 0];
KK(:,2) = [0; 0; 0; ...
    tau_w; tau_torso; ...
    tau_1l; tau_2l; tau_3l; tau_4l; tau_5l; tau_6l; tau_7l; ...
    tau_1r; tau_2r; tau_3r; tau_4r; tau_5r; tau_6r; tau_7r];

%% Contribution of forces/torques on the end-effector

syms Flx Fly Flz Frx Fry Frz Tlx Tly Tlz Trx Try Trz real
Fl = [Flx Fly Flz]'; Tl = [Tlx Tly Tlz]'; % expressed in frame 10l
Fr = [Frx Fry Frz]'; Tr = [Trx Try Trz]'; % expressed in frame 10r

% for dq = dx
T = Tf(f, '10l', '0'); ROT = T(1:3,1:3);
KK3(1, 1) = (ROT*Fl)'*[1; 0; 0];
KK3(1, 2) = 0;
T = Tf(f, '10r', '0'); ROT = T(1:3,1:3);
KK3(1, 3) = (ROT*Fr)'*[1; 0; 0];
KK3(1, 4) = 0;

% for dq != dx
key = keys(f);
for i=1:length(key)
    o = f(key{i}).o; e = f(key{i}).e;
    
    if(isBefore(f, key{i}, '10l') || isequal(key{i},'10l'))
        T = Tf(f, '10l', key{i}); ROT = T(1:3,1:3); rOO = T(1:3,4);
        KK3(o, 1) = (cross(rOO, ROT*Fl))'*e;
        KK3(o, 2) = (ROT*Tl)'*e;
    end
    
    if(isBefore(f, key{i}, '10r') || isequal(key{i},'10r'))
        T = Tf(f, '10r', key{i}); ROT = T(1:3,1:3); rOO = T(1:3,4);
        KK3(o, 1) = (cross(rOO, ROT*Fr))'*e;
        KK3(o, 2) = (ROT*Tr)'*e;
    end
end

for i=1:length(KK); 
    KK(i, 3) = KK3(i, 1) + KK3(i, 2) + KK3(i, 3) + KK3(i, 4);
end

%% Contribution of link weights
syms g real
key = keys(f);

% for dq = dx
KK4(1,1:19) = zeros(1,1:19);

% for dq != dx
for i=1:length(key) % for every equation
    o = f(key{i}).o; e = f(key{i}).e;
    KK4(o,1:2) = zeros(1,1:2); % no body weight corresponding to dx and dpsi
    
    T = Tf(f, '0', key{i}); ROT = T(1:3, 1:3);
    gVec = ROT*[0 0 -g]';
    
    for j=1:length(key) % for every body
        
        % Do nothing for frame 0
        if(isequal(key{j}, '0')); continue; end
        
        % Do nothing if the frame corresponding to this equation neither
        % precedes nor equals the frame corresponding to this body
        if(~isBefore(f, key{i}, key{j}) && ~isequal(key{i},key{j})); 
            continue; 
        end
        
        % Calculate the contribution of the weight of this body
        m = mass(f, key{j});
        mS = mCOM(f, key{j});
        T = Tf(f, key{j}, key{i});
        ROT = T(1:3, 1:3);
        mrOG = m*T(1:3, 4) + ROT*mS;
        KK4(o, f(key{j}).o) = (cross(mrOG, gVec))'*e;
        
        % Accumulating the contributions 
        KK(o, 4) = KK(o, 4) + KK4(o, f(key{j}).o);
    end
end

%% Total
for j=1:length(dq)
    K(j) = KK(j, 1) + KK(j, 2) + KK(j, 3) + KK(j, 4);
end