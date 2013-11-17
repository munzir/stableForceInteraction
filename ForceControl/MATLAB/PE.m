load KE

Tf_0from1 = simplify(inv(Tf_1from0));
Tf_1from2 = simplify(inv(Tf_2from1)); Tf_0from2 = Tf_0from1*Tf_1from2;
Tf_2from3 = simplify(inv(Tf_3from2)); Tf_0from3 = Tf_0from2*Tf_2from3;
Tf_3from4 = simplify(inv(Tf_4from3)); Tf_0from4 = Tf_0from3*Tf_3from4;
Tf_4from5 = simplify(inv(Tf_5from4)); Tf_0from5 = Tf_0from4*Tf_4from5;
Tf_5from6 = simplify(inv(Tf_6from5)); Tf_0from6 = Tf_0from5*Tf_5from6;
Tf_6from7 = simplify(inv(Tf_7from6)); Tf_0from7 = Tf_0from6*Tf_6from7;

g = [-9.8; 0; 0]; % Assuming that frame 0, which is parallel to frame 1
% when q1 is zero, is aligned such that its x-axis is vertically upwards
U1 = -[g' 0]*Tf_0from1*[MS1; m1];
U2 = -[g' 0]*Tf_0from2*[MS2; m2];
U3 = -[g' 0]*Tf_0from3*[MS3; m3];
U4 = -[g' 0]*Tf_0from4*[MS4; m4];
U5 = -[g' 0]*Tf_0from5*[MS5; m5];
U6 = -[g' 0]*Tf_0from6*[MS6; m6];
U7 = -[g' 0]*Tf_0from7*[MS7; m7];

U = U1 + U2 + U3 + U4 + U5 + U6 + U7;

Q(1) = diff(U, q1);
Q(2) = diff(U, q2);
Q(3) = diff(U, q3);
Q(4) = diff(U, q4);
Q(5) = diff(U, q5);
Q(6) = diff(U, q6);
Q(7) = diff(U, q7);

Q=Q';



