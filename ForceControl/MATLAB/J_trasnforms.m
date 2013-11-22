load PE

skew = @(v) [0 -v(3) v(2); v(3) 0 -v(1); -v(2) v(1) 0];

TF_1from0 = [Tf_1from0(1:3,1:3) -Tf_1from0(1:3,1:3)*skew(Tf_0from1(1:3,4)); zeros(3) Tf_1from0(1:3,1:3)];
TF_2from1 = [Tf_2from1(1:3,1:3) -Tf_2from1(1:3,1:3)*skew(Tf_1from2(1:3,4)); zeros(3) Tf_2from1(1:3,1:3)];
TF_3from2 = [Tf_3from2(1:3,1:3) -Tf_3from2(1:3,1:3)*skew(Tf_2from3(1:3,4)); zeros(3) Tf_3from2(1:3,1:3)];
TF_4from3 = [Tf_4from3(1:3,1:3) -Tf_4from3(1:3,1:3)*skew(Tf_3from4(1:3,4)); zeros(3) Tf_4from3(1:3,1:3)];
TF_5from4 = [Tf_5from4(1:3,1:3) -Tf_5from4(1:3,1:3)*skew(Tf_4from5(1:3,4)); zeros(3) Tf_5from4(1:3,1:3)];
TF_6from5 = [Tf_6from5(1:3,1:3) -Tf_6from5(1:3,1:3)*skew(Tf_5from6(1:3,4)); zeros(3) Tf_6from5(1:3,1:3)];
TF_7from6 = [Tf_7from6(1:3,1:3) -Tf_7from6(1:3,1:3)*skew(Tf_6from7(1:3,4)); zeros(3) Tf_7from6(1:3,1:3)];

JJ1 = [m1*eye(3) -skew(MS1); skew(MS1) J1];
JJ2 = [m2*eye(3) -skew(MS2); skew(MS2) J2];
JJ3 = [m3*eye(3) -skew(MS3); skew(MS3) J3];
JJ4 = [m4*eye(3) -skew(MS4); skew(MS4) J4];
JJ5 = [m5*eye(3) -skew(MS5); skew(MS5) J5];
JJ6 = [m6*eye(3) -skew(MS6); skew(MS6) J6];
JJ7 = [m7*eye(3) -skew(MS7); skew(MS7) J7];

JJ1_in0 = simplify(TF_1from0'*JJ1*TF_1from0);
JJ2_in1 = simplify(TF_2from1'*JJ2*TF_2from1);
JJ3_in2 = simplify(TF_3from2'*JJ3*TF_3from2);
JJ4_in3 = simplify(TF_4from3'*JJ4*TF_4from3);
JJ5_in4 = simplify(TF_5from4'*JJ5*TF_5from4);
JJ6_in5 = simplify(TF_6from5'*JJ6*TF_6from5);
JJ7_in6 = simplify(TF_7from6'*JJ7*TF_7from6);

lambda_0from1 = findLambda(JJ1_in0,JJ1);
lambda_1from2 = findLambda(JJ2_in1,JJ2);
lambda_2from3 = findLambda(JJ3_in2,JJ3);
lambda_3from4 = findLambda(JJ4_in3,JJ4);
lambda_4from5 = findLambda(JJ5_in4,JJ5);
lambda_5from6 = findLambda(JJ6_in5,JJ6);
lambda_6from7 = findLambda(JJ7_in6,JJ7);

% Find all h
h1 = simplify(findh(E1+U1,JJ1));
h2 = simplify(findh(E2+U2,JJ2));
h3 = simplify(findh(E3+U3,JJ3));
h4 = simplify(findh(E4+U4,JJ4));
h5 = simplify(findh(E5+U5,JJ5));
h6 = simplify(findh(E6+U6,JJ6));
h7 = simplify(findh(E7+U7,JJ7));

% Verfiy the equation h_{j} = h_{j-1}*lambda_{j-1}from{j} + dq_{j}*eeta_{j}
eeta1 = [ 0, -w1(1), 0, - dq1/2 - w1(2), -w1(3), 0, V1(3), 0, -V1(1), 0];
eeta2 = [ - dq2/2 - w2(1), -w2(2), -w2(3), 0, 0, 0, 0, -V2(3), V2(2), 0];
eeta3 = [ 0, -w3(1), 0, - dq3/2 - w3(2), -w3(3), 0, V3(3), 0, -V3(1), 0];
eeta4 = [ - dq4/2 - w4(1), -w4(2), -w4(3), 0, 0, 0, 0, -V4(3), V4(2), 0];
eeta5 = [ 0, -w5(1), 0, - dq5/2 - w5(2), -w5(3), 0, V5(3), 0, -V5(1), 0];
eeta6 = [ - dq6/2 - w6(1), -w6(2), -w6(3), 0, 0, 0, 0, -V6(3), V6(2), 0];
eeta7 = [ 0, 0, -w7(1), 0, -w7(2), - dq7/2 - w7(3), -V7(2), V7(1), 0, 0];
h7_ = simplify(h6*lambda_6from7 + dq7*eeta7);
h6_ = simplify(h5*lambda_5from6 + dq6*eeta6);
h5_ = simplify(h4*lambda_4from5 + dq5*eeta5);
h4_ = simplify(h3*lambda_3from4 + dq4*eeta4);
h3_ = simplify(h2*lambda_2from3 + dq3*eeta3);
h2_ = simplify(h1*lambda_1from2 + dq2*eeta2);

eq=zeros(6,10);
for i=1:10
    eq(1,i)=isequaln(h7(i), h7_(i));
    eq(2,i)=isequaln(h6(i), h6_(i));
    eq(3,i)=isequaln(h5(i), h5_(i));
    eq(4,i)=isequaln(h4(i), h4_(i));
    eq(5,i)=isequaln(h3(i), h3_(i));
    eq(6,i)=isequaln(h2(i), h2_(i));
end
