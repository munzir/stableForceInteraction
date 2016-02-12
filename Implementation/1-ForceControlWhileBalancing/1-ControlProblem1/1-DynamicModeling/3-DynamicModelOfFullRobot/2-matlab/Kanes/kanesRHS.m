function [K, KK, KK2, KK3, KK4] = kanesRHS(f)

dq = dqVec(f);
KK2 = sym(zeros(length(dq), length(dq)-3)); % Stores the contribution of each joint torque (nRows=ndqs, nCols=nTorques)
KK3 = sym(zeros(length(dq), 4)); % Stores the contribution of 1. Fel 2. tae_el 3. Fer 4. tau_er
KK4 = sym(zeros(length(dq), length(dq)-2)); % Stores the contribution of each link weight (nRows=ndqs, nCols=nLinks)
KK = sym(zeros(length(dq),4)); % Store contribution sums of 1. wheel torques 2. joint torques 3. End Eff F/T 4. Weights
K = sym(zeros(length(dq),1));  % Store the sum of all contributions

% Wheel Torques

syms tau_L tau_R L R real
i0 = [1 0 0]'; j0 = [0 1 0]'; k0 = [0 0 1]';
w0 = f('0').angVel;
v0 = f('0').linVel;
theta_L = v0(1)/R - w0(3)*L/(2*R); 
theta_R = v0(1)/R + w0(3)*L/(2*R); 
wL = w0 + theta_L*j0; 
wR = w0 + theta_R*j0;
w1 = simplify(Rot(f, '1', '0') * angVel(f, '1'));
Tau_L = tau_L*j0;
Tau_R = tau_R*j0;
Tau_imu = -(tau_L + tau_R)*j0;

for i=1:length(dq)
    KK(i, 1) = Tau_L'*diff(wL, dq(i)) + Tau_R'*diff(wR, dq(i)) ...
        + Tau_imu'*diff(w1, dq(i));
end

% Joint Torques
syms tau_w tau_torso real
syms tau_1l tau_2l tau_3l tau_4l tau_5l tau_6l tau_7l real
syms tau_1r tau_2r tau_3r tau_4r tau_5r tau_6r tau_7r  real
keysTau = {'2', '3', '4l', '5l', '6l', '7l', '8l', ...
    '9l', '10l', '4r', '5r', '6r', '7r', '8r', '9r', '10r'};
aTau = [tau_w tau_torso tau_1l tau_2l tau_3l tau_4l tau_5l tau_6l tau_7l...
    tau_1r tau_2r tau_3r tau_4r tau_5r tau_6r tau_7r]';
for i=1:length(dq)-3; keySet{i} = keysTau{i}; cTau{i} = aTau(i); end
mTau = containers.Map( keySet, cTau );

keysTau = keys(mTau);
for i=1:length(keysTau)
    key = keysTau{i};
    tau = mTau(key);
    frame = f(key);
    e = frame.e;
    w = angVel(f, key);
    R = Rot(f, key, frame.a);
    wlast = angVel(f, frame.a);
    
    % Calculate the contribution
    for j=1:length(dq)
        KK2(j, i) = tau*e'*diff(w,dq(j)) + (-R*tau*e)'*diff(wlast,dq(j));
        KK(j, 2) = KK(j, 2) + KK2(j, i);
    end
end

% Contribution of forces/torques on the end-effector

syms Flx Fly Flz Frx Fry Frz Tlx Tly Tlz Trx Try Trz real
Fl = [Flx Fly Flz]'; Tl = [Tlx Tly Tlz]'; % expressed in frame 10l
Fr = [Frx Fry Frz]'; Tr = [Trx Try Trz]'; % expressed in frame 10r
veL = linVel(f, '10l');
weL = angVel(f, '10l');
veR = linVel(f, '10r');
weR = angVel(f, '10r');

for i=1:length(dq)
    KK3(i, 1) = KK3(i, 1) + Fl'*diff(veL, dq(i));
    KK3(i, 2) = KK3(i, 2) + Tl'*diff(weL, dq(i));
    KK3(i, 3) = KK3(i, 3) + Fr'*diff(veR, dq(i));
    KK3(i, 4) = KK3(i, 4) + Tr'*diff(weR, dq(i));
    KK(i, 3) = KK3(i, 1) + KK3(i, 2) + KK3(i, 3) + KK3(i, 4);
end

% Contribution of link weights
syms g real
key = keys(f);
for i=1:length(key)
    
    % if key is '0' leave it
    if(isequal(key{i}, '0')); continue; end
    
    % Get necessary info
    w = angVel(f, key{i});
    v = linVel(f, key{i});
    m = mass(f, key{i});
    S = mCOM(f, key{i})/m;
    T = Tf(f, '0', key{i});

    % Calculate contribution
    vG = v + cross(w, S);
    ROT = T(1:3,1:3);
    mg = m*ROT*[0 0 -g]';
    for j=1:length(dq)
        KK4(j, i) =  mg'*diff(vG, dq(j));
        KK(j, 4) = KK(j, 4) + KK4(j, i);
    end
end 

for j=1:length(dq)
    K(j) = KK(j, 1) + KK(j, 2) + KK(j, 3) + KK(j, 4);
end