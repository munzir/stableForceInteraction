function [K, Q, KHist] = kanesLHS(f, varargin)

syms g real

if nargin == 1
    w0 = sym([0 0 0]');
    v0 = sym([0 0 0]');
    alpha0 = sym([0 0 0]');
    a0 = sym([0 0 0]');
    dq=dqVec(f);
    K=sym(zeros(length(dq),1));
elseif nargin > 1
    w0 = varargin{1}(:,1);
    v0 = varargin{1}(:,2);
    alpha0 = varargin{1}(:,3);
    a0 = varargin{1}(:,4);
    dqBody = dqVec(f);
    dq=[varargin{2}; dqBody];
    K=[varargin{3}; sym(zeros(length(dqBody),1))];
end

key = keys(f);
KHist=sym(zeros(length(dq),length(dq)));
Q=sym(zeros(length(dq),1));
for i=1:length(key)

    % Do nothing for frame 0
    if(isequal(key{i}, '0')); continue; end
    
    % Kinematics and Inertials Params
    w=angVel(f, key{i}, w0);
    alpha=angAcc(f, key{i}, [w0 alpha0]);
    v=linVel(f, key{i}, [w0 v0]);
    a=linAcc(f, key{i}, [w0 alpha0 v0 a0]);
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
    
    % Gravity terms
    T = Tf(f, '0', key{i});
    ROT = T(1:3,1:3);
    mg = m*ROT*[0 0 -g]';
    for j=1:length(Q)
        disp(['kanesQ: i=', num2str(i), ', j=', num2str(j)]);
        Q(j)=Q(j)-mg'*diff(vG, dq(j));
    end
end