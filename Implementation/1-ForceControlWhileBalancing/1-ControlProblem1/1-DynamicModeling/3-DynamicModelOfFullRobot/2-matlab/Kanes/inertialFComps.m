function [m,aG,vG,dH]=inertialFComps(f, key, varargin) 

if(nargin == 2)
    w0 = [0;0;0];
    alpha0 = [0;0;0];
    v0= [0;0;0];
    a0 = [0;0;0];
else
    w0 = varargin{1}(:,1);
    alpha0 = varargin{1}(:,2);
    v0 = varargin{1}(:,3);
    a0 = varargin{1}(:,4);
end

w=angVel(f, key, w0);
alpha=angAcc(f, key, [w0 alpha0]);
v=linVel(f, key, [w0 v0]);
a=linAcc(f, key, [w0 alpha0 v0 a0]);
J=inertiaMat(f, key);
m=mass(f, key);
mS=mCOM(f, key);
S=mS/m;
    
% Inertial Forces and Torques
vG = v + cross(w, S);
aG = a + cross(alpha, S) + cross(w, cross(w, S));
dH = J*alpha + cross(w, J*w);
 
 