syms Frx Fry Frz Flx Fly Flz mB g dx dpsi dphi MXb MYb MZb real 
syms Erx Ery Erz Elx Ely Elz tau_l tau_r R L qimu real
syms Trx Try Trz Tlx Tly Tlz real

dq = [dx dpsi dphi]';
a = sym(zeros(3,1)); b = sym(zeros(3,1)); 
c = sym(zeros(3,1)); d = sym(zeros(3,1)); 

% Forces at point O
i0 = [1 0 0]'; j0 = [0 1 0]'; k0 = [0 0 1]';
Fr = [Frx Fry Frz]'; Fl = [Flx Fly Flz]';
Fg = mB*[0 0 -g]';
v0 = [dx 0 0]';

for i=1:3
    a(i) = (Fr + Fl + Fg)'*diff(v0, dq(i));
end

% Torques at point O
i1=[0 -1 0]'; j1=[sin(qimu) 0 cos(qimu)]'; k1=[-cos(qimu) 0 sin(qimu)]';
rOG = (MXb*i1 + MYb*j1 + MZb*k1)/mB;
Er = [Erx Ery Erz]'; El = [Elx Ely Elz]';
wB = [0 -dphi dpsi]';
Tau_r = [0 tau_r 0]'; % this applies to the wheel. sign to be reversed for point O becuse it is on the body
Tau_l = [0 tau_l 0]'; % this applies to the wheel. sign to be reversed for point O becuse it is on the body
Tr = [Trx Try Trz]';
Tl = [Tlx Tly Tlz]';

for i=1:3
    b(i) = (cross(rOG,Fg) + cross(Er,Fr) + cross(El,Fl) ...
       - Tau_r - Tau_l + Tl + Tr)'*diff(wB,dq(i));
end

% Torques at point R

wR = dpsi*k0 + (dx/R + (L*dpsi)/(2*R))*j0;

for i=1:3
    c(i) = Tau_r'*diff(wR,dq(i));
end

% Torques at point L
wL = dpsi*k0 + (dx/R - (L*dpsi)/(2*R))*j0;

for i=1:3
    d(i) = Tau_l'*diff(wL,dq(i));
end