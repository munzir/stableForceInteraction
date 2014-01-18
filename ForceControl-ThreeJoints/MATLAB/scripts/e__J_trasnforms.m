load PE

skew = @(v) [0 -v(3) v(2); v(3) 0 -v(1); -v(2) v(1) 0];

TF_1from0 = [Tf_1from0(1:3,1:3) -Tf_1from0(1:3,1:3)*skew(Tf_0from1(1:3,4)); zeros(3) Tf_1from0(1:3,1:3)];
TF_2from1 = [Tf_2from1(1:3,1:3) -Tf_2from1(1:3,1:3)*skew(Tf_1from2(1:3,4)); zeros(3) Tf_2from1(1:3,1:3)];
TF_3from2 = [Tf_3from2(1:3,1:3) -Tf_3from2(1:3,1:3)*skew(Tf_2from3(1:3,4)); zeros(3) Tf_3from2(1:3,1:3)];

JJ1 = [m1*eye(3) -skew(MS1); skew(MS1) J1];
JJ2 = [m2*eye(3) -skew(MS2); skew(MS2) J2];
JJ3 = [m3*eye(3) -skew(MS3); skew(MS3) J3];

JJ1_in0 = simplify(TF_1from0'*JJ1*TF_1from0);
JJ2_in1 = simplify(TF_2from1'*JJ2*TF_2from1);
JJ3_in2 = simplify(TF_3from2'*JJ3*TF_3from2);

lambda_0from1 = findLambda(JJ1_in0,JJ1);
lambda_1from2 = findLambda(JJ2_in1,JJ2);
lambda_2from3 = findLambda(JJ3_in2,JJ3);

% Find all h
h1 = simplify(findh(E1+U1,JJ1));
h2 = simplify(findh(E2+U2,JJ2));
h3 = simplify(findh(E3+U3,JJ3));

% Verfiy the equation h_{j} = h_{j-1}*lambda_{j-1}from{j} + dq_{j}*eeta_{j}
eeta1 = [ 0, 0, -w1(1), 0, -w1(2), - dq1/2 - w1(3), -V1(2), V1(1), 0, 0];
eeta2 = [ - dq2/2 - w2(1), -w2(2), -w2(3), 0, 0, 0, 0, -V2(3), V2(2), 0];
eeta3 = [ - dq3/2 - w3(1), -w3(2), -w3(3), 0, 0, 0, 0, -V3(3), V3(2), 0];

h3_ = simplify(h2*lambda_2from3 + dq3*eeta3);
h2_ = simplify(h1*lambda_1from2 + dq2*eeta2);

eq=zeros(2,10);
for i=1:10
    eq(1,i)=isequaln(h3(i), h3_(i));
    eq(2,i)=isequaln(h2(i), h2_(i));
end
