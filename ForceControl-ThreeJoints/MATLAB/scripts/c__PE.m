load KE

Tf_0from1 = simplify(inv(Tf_1from0));
Tf_1from2 = simplify(inv(Tf_2from1)); Tf_0from2 = Tf_0from1*Tf_1from2;
Tf_2from3 = simplify(inv(Tf_3from2)); Tf_0from3 = Tf_0from2*Tf_2from3;

g = [-9.8; 0; 0]; % Assuming that frame 0, which is parallel to frame 1
% when q1 is zero, is aligned such that its x-axis is vertically upwards
U1 = -[g' 0]*Tf_0from1*[MS1; m1];
U2 = -[g' 0]*Tf_0from2*[MS2; m2];
U3 = -[g' 0]*Tf_0from3*[MS3; m3];

U = U1 + U2 + U3;

Q(1) = diff(U, q1);
Q(2) = diff(U, q2);
Q(3) = diff(U, q3);

Q=Q';