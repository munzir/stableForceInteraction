clear all 
load kanesAndLagrange_03_27_15.mat

% creating a new f with symbolic variables for torques in it
% tau_imu = -tau_l - tau_r (sum of reaction of torques applied to wheels)
syms tau_imu tau_w tau_torso real
syms tau_1l tau_2l tau_3l tau_4l tau_5l tau_6l tau_7l real
syms tau_1r tau_2r tau_3r tau_4r tau_5r tau_6r tau_7r  real

tauVec = [tau_imu tau_w tau_torso ...
    tau_1l tau_2l tau_3l tau_4l tau_5l tau_6l tau_7l ... 
    tau_1r tau_2r tau_3r tau_4r tau_5r tau_6r tau_7r]';
key = keys(f);
for i=1:length(key)
    if(isequal(key{i}, '0')); continue; end
    frame = f(key{i});
    frame.tau = tauVec(frame.o);
    f(key{i}) = frame;
end

% Finding the contribution of body motor torques to kane's RHS
dq = dqVec(f);
a = sym(zeros(length(dq),1));
aa = sym(zeros(length(dq),length(dq)));
for i=1:length(key)
    
    % if key is '0' leave it
    if(isequal(key{i}, '0')); continue; end
    
    % Collect relevant info of current frame and previous frame
    frame = f(key{i});
    e = frame.e;
    tau = frame.tau;
    w = angVel(f, key{i}, sym([0 0 0]'));
    R = Rot(f, key{i}, frame.a);
    wlast = angVel(f, frame.a, sym([0 0 0]'));
    
    % Calculate the contribution
    for j=1:length(dq)
        aa(j,frame.o) = tau*e'*diff(w,dq(j)) + (-R*tau*e)'*diff(wlast,dq(j));
        a(j) = a(j) + aa(j,frame.o);
    end
end

% Contribution of forces/torques on the end-effector

syms Flx Fly Flz Frx Fry Frz Tlx Tly Tlz Trx Try Trz real
Fl = [Flx Fly Flz]'; Tl = [Tlx Tly Tlz]'; % expressed in frame 10l
Fr = [Frx Fry Frz]'; Tr = [Trx Try Trz]'; % expressed in frame 10r

b1 = sym(zeros(length(dq),1));
b2 = sym(zeros(length(dq),1));
v = linVel(f, '10l', sym([0 0 0]'));
w = angVel(f, '10l', sym([0 0 0]'));
for i=1:length(dq)
    b1(i) = b1(i) + Fl'*diff(v, dq(i));
    b2(i) = b2(i) + Tl'*diff(w, dq(i));
end

b3 = sym(zeros(length(dq),1));
b4 = sym(zeros(length(dq),1));
v = linVel(f, '10r', sym([0 0 0]'));
w = angVel(f, '10r', sym([0 0 0]'));
for i=1:length(dq)
    b3(i) = b3(i) + Fr'*diff(v, dq(i));
    b4(i) = b4(i) + Tr'*diff(w, dq(i));
end

% Contributions from the forces of gravity

syms g real
c = sym(zeros(length(dq),1));

for i=1:length(key)
    
    % if key is '0' leave it
    if(isequal(key{i}, '0')); continue; end
    
    % Get necessary info
    w = angVel(f, key{i}, sym([0 0 0]'));
    v = linVel(f, key{i}, [sym([0 0 0]') sym([0 0 0]')]);
    m = mass(f, key{i});
    S = mCOM(f, key{i})/m;
    T = Tf(f, '0', key{i});

    % Calculate contribution
    vG = v + cross(w, S);
    ROT = T(1:3,1:3);
    mg = m*ROT*[0 0 -g]';
    for j=1:length(dq)
        c(j)= c(j) + mg'*diff(vG, dq(j));
    end
end