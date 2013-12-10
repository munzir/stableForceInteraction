%% Link 7
%  eeta7 = [ 0, 0, -w7(1), 0, -w7(2), - dq7/2 - w7(3), -V7(2), V7(1), 0, 0];
%  lambda_6from7 =
%   +-                                                                                          -+
%   |         2                                                                               2  |
%   |  cos(q7) ,  sin(2 q7),     0,       #2,       0,    0,      0,          0,      2 L7, L7   |
%   |                                                                                            |
%   |      0,         0,      cos(q7),     0,    sin(q7), 0,     #3,     -L7 sin(q7),   0,   0   |
%   |                                                                                            |
%   |     -#1,    cos(2 q7),     0,       #1,       0,    0,      0,          0,        0,   0   |
%   |                                                                                            |
%   |      0,         0,         0,        0,       0,    1,      0,          0,        0,   0   |
%   |                                                                                            |
%   |      0,         0,     -sin(q7),     0,    cos(q7), 0, L7 sin(q7),      #3,       0,   0   |
%   |                                                                                            |
%   |                                         2                                               2  |
%   |     #2,    -sin(2 q7),     0,    cos(q7) ,    0,    0,      0,          0,      2 L7, L7   |
%   |                                                                                            |
%   |      0,         0,         0,        0,       0,    0,  -cos(q7),    -sin(q7),    0,   0   |
%   |                                                                                            |
%   |      0,         0,         0,        0,       0,    0,      0,          0,       -1,  -L7  |
%   |                                                                                            |
%   |      0,         0,         0,        0,       0,    0,   sin(q7),    -cos(q7),    0,   0   |
%   |                                                                                            |
%   |      0,         0,         0,        0,       0,    0,      0,          0,        0,   1   |
%   +-                                                                                          -+
%   
%   where
%   
%            sin(2 q7)
%      #1 == ---------
%                2
%   
%                       2
%      #2 == 1 - cos(q7)
%   
%      #3 == -L7 cos(q7)
% 
%% We note that:
%   h7(4) = h6*(lambda_6from7(:,1) + lambda_6from7(:,4)) - h7(1)
%   h7(9) = h6*lambda_6from7(:,9)
%   h7(10) = h6*lambda_6from7(:,10)
%   
%   (lambda_6from7(:,1) + lambda_6from7(:,4)), lambda_6from7(:,9) and
%   lambda_6from7(:,10) are constants and so K7(4), K7(9) and K7(10) can
%   be eliminated and the new parameters can be defined by grouping together
%   these guys with the remaining parameters using these constants as the
%   coefficients.
%
%  So the new paramters would be:
%  K7(1) = K7(1) - K7(4)
%  K6 = K6 + (lambda_6from7(1) + lambda_6from7(4))*K7(4) 
%      + lambda_6from7(9)*K7(9) + lambda_6from7(10)*K7(10)
%% Link 6:
% eeta6 = [ - dq6/2 - w6(1), -w6(2), -w6(3), 0, 0, 0, 0, -V6(3), V6(2), 0];
% pretty(lambda_5from6) =
% 
%   +-                                                                                 -+
%   |  1,    0,        0,        0,         0,         0,     0,     0,        0,    0  |
%   |                                                                                   |
%   |  0, cos(q6),  sin(q6),     0,         0,         0,     0,     0,        0,    0  |
%   |                                                                                   |
%   |  0, sin(q6), -cos(q6),     0,         0,         0,     0,     0,        0,    0  |
%   |                                                                                   |
%   |                               2                     2                             |
%   |  0,    0,        0,    cos(q6) ,     #1,     sin(q6) ,  0,     0,        0,    0  |
%   |                                                                                   |
%   |  0,    0,        0,       #2,    -cos(2 q6),    -#2,    0,     0,        0,    0  |
%   |                                                                                   |
%   |                               2                     2                             |
%   |  0,    0,        0,    sin(q6) ,     -#1,    cos(q6) ,  0,     0,        0,    0  |
%   |                                                                                   |
%   |  0,    0,        0,        0,         0,         0,    -1,     0,        0,    0  |
%   |                                                                                   |
%   |  0,    0,        0,        0,         0,         0,     0, -cos(q6), -sin(q6), 0  |
%   |                                                                                   |
%   |  0,    0,        0,        0,         0,         0,     0, -sin(q6),  cos(q6), 0  |
%   |                                                                                   |
%   |  0,    0,        0,        0,         0,         0,     0,     0,        0,    1  |
%   +-                                                                                 -+
%   
%   where
%   
%      #1 == 2 cos(q6) sin(q6)
%   
%            sin(2 q6)
%      #2 == ---------
%                2
%% We note that:
%  h6(6) = h5*(lambda_5from6(:,4) + lambda_5from6(:,6)) - h6(4)
%  h6(7) = h5*lambda_5from6(:,7)
%  h6(10) = h5*lambda_5from6(:,10)
%
% So
%  K6(4) = K6(4) - K6(6)
%  K5 = K5 + K6(6)*(lambda_5from6(:,4)+lambda_5from6(:,6))
%    + K6(7)*lambda_5from6(:,7) + K6(10)*lambda_5from6(:,10)
%% Link 5:
% eeta5 = [ 0, -w5(1), 0, - dq5/2 - w5(2), -w5(3), 0, V5(3), 0, -V5(1), 0];
% pretty(lambda_4from5)
% 
%   +-                                                                                           -+
%   |         2                                                                                2  |
%   |  cos(q5) ,     0,    -sin(2 q5), 0,     0,       #2,         0,      2 L5,      0,     L5   |
%   |                                                                                             |
%   |      0,     cos(q5),      0,     0, -sin(q5),     0,    -L5 cos(q5),   0,  L5 sin(q5),  0   |
%   |                                                                                             |
%   |     -#1,       0,    -cos(2 q5), 0,     0,       #1,         0,        0,       0,      0   |
%   |                                                                                             |
%   |      0,        0,         0,     1,     0,        0,         0,        0,       0,      0   |
%   |                                                                                             |
%   |      0,    -sin(q5),      0,     0, -cos(q5),     0,     L5 sin(q5),   0,  L5 cos(q5),  0   |
%   |                                                                                             |
%   |                                                      2                                   2  |
%   |     #2,        0,     sin(2 q5), 0,     0,    cos(q5) ,      0,      2 L5,      0,     L5   |
%   |                                                                                             |
%   |      0,        0,         0,     0,     0,        0,      -cos(q5),    0,    sin(q5),   0   |
%   |                                                                                             |
%   |      0,        0,         0,     0,     0,        0,         0,       -1,       0,     -L5  |
%   |                                                                                             |
%   |      0,        0,         0,     0,     0,        0,      sin(q5),     0,    cos(q5),   0   |
%   |                                                                                             |
%   |      0,        0,         0,     0,     0,        0,         0,        0,       0,      1   |
%   +-                                                                                           -+
%   
%   where
%   
%            sin(2 q5)
%      #1 == ---------
%                2
%   
%                       2
%      #2 == 1 - cos(q5)
%% We note that:
%  h5(6) = h4*(lambda_4from5(:,1) + lambda_4from5(:,6)) - h5(1)
%  h5(8) =  h4*lambda_4from5(:,8)
%  h5(10) = h4*lambda_4from5(:,10)
%
% So
%  K5(1) = K5(1) - K5(6)
%  K4 = K4 + K5(6)*(lambda_4from5(:,1)+lambda_4from5(:,6))
%    + K5(8)*lambda_4from5(:,8) + K5(10)*lambda_4from5(:,10)
%% Link 4:
% eeta4 = [ - dq4/2 - w4(1), -w4(2), -w4(3), 0, 0, 0, 0, -V4(3), V4(2), 0];
% pretty(lambda_3from4)
% 
%   +-                                                                                 -+
%   |  1,    0,        0,        0,         0,         0,     0,     0,        0,    0  |
%   |                                                                                   |
%   |  0, cos(q4),  sin(q4),     0,         0,         0,     0,     0,        0,    0  |
%   |                                                                                   |
%   |  0, sin(q4), -cos(q4),     0,         0,         0,     0,     0,        0,    0  |
%   |                                                                                   |
%   |                               2                     2                             |
%   |  0,    0,        0,    cos(q4) ,     #1,     sin(q4) ,  0,     0,        0,    0  |
%   |                                                                                   |
%   |  0,    0,        0,       #2,    -cos(2 q4),    -#2,    0,     0,        0,    0  |
%   |                                                                                   |
%   |                               2                     2                             |
%   |  0,    0,        0,    sin(q4) ,     -#1,    cos(q4) ,  0,     0,        0,    0  |
%   |                                                                                   |
%   |  0,    0,        0,        0,         0,         0,    -1,     0,        0,    0  |
%   |                                                                                   |
%   |  0,    0,        0,        0,         0,         0,     0, -cos(q4), -sin(q4), 0  |
%   |                                                                                   |
%   |  0,    0,        0,        0,         0,         0,     0, -sin(q4),  cos(q4), 0  |
%   |                                                                                   |
%   |  0,    0,        0,        0,         0,         0,     0,     0,        0,    1  |
%   +-                                                                                 -+
%   
%   where
%   
%      #1 == 2 cos(q4) sin(q4)
%   
%            sin(2 q4)
%      #2 == ---------
%                2
%% We note that:
%  h4(6) = h3*(lambda_3from4(:,4) + lambda_3from4(:,6)) - h4(4)
%  h4(7) = h3*lambda_3from4(:,7)
%  h4(10) = h3*lambda_3from4(:,10)
%
% So
%  K4(4) = K4(4) - K4(6)
%  K3 = K3 + K4(6)*(lambda_3from4(:,4)+lambda_3from4(:,6))
%    + K4(7)*lambda_3from4(:,7) + K4(10)*lambda_3from4(:,10)
%% Link 3:
% eeta3 = [ 0, -w3(1), 0, - dq3/2 - w3(2), -w3(3), 0, V3(3), 0, -V3(1), 0];
% pretty(lambda_2from3) =
% 
%   +-                                                                                           -+
%   |         2                                                                                2  |
%   |  cos(q3) ,     0,    -sin(2 q3), 0,     0,       #2,         0,      2 L3,      0,     L3   |
%   |                                                                                             |
%   |      0,     cos(q3),      0,     0, -sin(q3),     0,    -L3 cos(q3),   0,  L3 sin(q3),  0   |
%   |                                                                                             |
%   |     -#1,       0,    -cos(2 q3), 0,     0,       #1,         0,        0,       0,      0   |
%   |                                                                                             |
%   |      0,        0,         0,     1,     0,        0,         0,        0,       0,      0   |
%   |                                                                                             |
%   |      0,    -sin(q3),      0,     0, -cos(q3),     0,     L3 sin(q3),   0,  L3 cos(q3),  0   |
%   |                                                                                             |
%   |                                                      2                                   2  |
%   |     #2,        0,     sin(2 q3), 0,     0,    cos(q3) ,      0,      2 L3,      0,     L3   |
%   |                                                                                             |
%   |      0,        0,         0,     0,     0,        0,      -cos(q3),    0,    sin(q3),   0   |
%   |                                                                                             |
%   |      0,        0,         0,     0,     0,        0,         0,       -1,       0,     -L3  |
%   |                                                                                             |
%   |      0,        0,         0,     0,     0,        0,      sin(q3),     0,    cos(q3),   0   |
%   |                                                                                             |
%   |      0,        0,         0,     0,     0,        0,         0,        0,       0,      1   |
%   +-                                                                                           -+
%   
%   where
%   
%            sin(2 q3)
%      #1 == ---------
%                2
%   
%                       2
%      #2 == 1 - cos(q3)
%% We note that:
%  h3(6) = h2*(lambda_2from3(:,1) + lambda_2from3(:,6)) - h3(1)
%  h3(8) =  h2*lambda_2from3(:,8)
%  h3(10) = h2*lambda_2from3(:,10)
%
% So
%  K3(1) = K3(1) - K3(6)
%  K2 = K2 + K3(6)*(lambda_2from3(:,1)+lambda_2from3(:,6))
%    + K3(8)*lambda_2from3(:,8) + K3(10)*lambda_2from3(:,10)
%% Link 2:
% eeta2 = [ - dq2/2 - w2(1), -w2(2), -w2(3), 0, 0, 0, 0, -V2(3), V2(2), 0];
% pretty(lambda_1from2)
% 
%   +-                                                                                 -+
%   |  1,    0,        0,        0,         0,         0,     0,     0,        0,    0  |
%   |                                                                                   |
%   |  0, cos(q2),  sin(q2),     0,         0,         0,     0,     0,        0,    0  |
%   |                                                                                   |
%   |  0, sin(q2), -cos(q2),     0,         0,         0,     0,     0,        0,    0  |
%   |                                                                                   |
%   |                               2                     2                             |
%   |  0,    0,        0,    cos(q2) ,     #1,     sin(q2) ,  0,     0,        0,    0  |
%   |                                                                                   |
%   |  0,    0,        0,       #2,    -cos(2 q2),    -#2,    0,     0,        0,    0  |
%   |                                                                                   |
%   |                               2                     2                             |
%   |  0,    0,        0,    sin(q2) ,     -#1,    cos(q2) ,  0,     0,        0,    0  |
%   |                                                                                   |
%   |  0,    0,        0,        0,         0,         0,    -1,     0,        0,    0  |
%   |                                                                                   |
%   |  0,    0,        0,        0,         0,         0,     0, -cos(q2), -sin(q2), 0  |
%   |                                                                                   |
%   |  0,    0,        0,        0,         0,         0,     0, -sin(q2),  cos(q2), 0  |
%   |                                                                                   |
%   |  0,    0,        0,        0,         0,         0,     0,     0,        0,    1  |
%   +-                                                                                 -+
%   
%   where
%   
%      #1 == 2 cos(q2) sin(q2)
%   
%            sin(2 q2)
%      #2 == ---------
%                2
%% We note that:
%  h2(6) = h1*(lambda_1from2(:,4) + lambda_1from2(:,6)) - h2(4)
%  h2(7) = h1*lambda_1from2(:,7)
%  h2(10) = h1*lambda_1from2(:,10)
%
% So
%  K2(4) = K2(4) - K2(6)
%  K1 = K1 + K2(6)*(lambda_1from2(:,4)+lambda_1from2(:,6))
%    + K2(7)*lambda_1from2(:,7) + K2(10)*lambda_1from2(:,10)
%% Link 1:
% h1 = [ 0, 0, 0, dq1^2/2, 0, 0, (49*cos(q1))/5, 0, -(49*sin(q1))/5, 0]
% So, K1(1:3) = 0; K1(5:6) = 0; K1(8) = 0; K1(10) = 0;

%% So now we go!

load lambda
a = [4 4; 4 5; 4 6; 5 5; 5 6; 6 6; 6 2; 4 3; 5 1; 1 1];
JJ = {JJ1, JJ2, JJ3, JJ4, JJ5, JJ6, JJ7};
syms alabala
K = alabala * zeros(10,7);
for i=1:7
    for j=1:10
        K(j,i) = JJ{i}(a(j,1), a(j,2));
    end
end
K1 = K(:,1); K2 = K(:,2); K3 = K(:,3); K4 = K(:,4); 
K5 = K(:,5); K6 = K(:,6); K7 = K(:,7); 


K7(1) = simplify(K7(1) - K7(4));
K6 = simplify(K6 + (lambda_6from7(:,1) + lambda_6from7(:,4))*K7(4) ...
    + lambda_6from7(:,9)*K7(9) + lambda_6from7(:,10)*K7(10));
K6(4) = simplify(K6(4) - K6(6));
K5 = simplify(K5 + K6(6)*(lambda_5from6(:,4)+lambda_5from6(:,6))...
    + K6(7)*lambda_5from6(:,7) + K6(10)*lambda_5from6(:,10));
K5(1) = simplify(K5(1) - K5(6));
K4 = simplify(K4 + K5(6)*(lambda_4from5(:,1)+lambda_4from5(:,6))...
    + K5(8)*lambda_4from5(:,8) + K5(10)*lambda_4from5(:,10));
K4(4) = simplify(K4(4) - K4(6));
K3 = simplify(K3 + K4(6)*(lambda_3from4(:,4)+lambda_3from4(:,6))...
    + K4(7)*lambda_3from4(:,7) + K4(10)*lambda_3from4(:,10));
K3(1) = simplify(K3(1) - K3(6));
K2 = simplify(K2 + K3(6)*(lambda_2from3(:,1)+lambda_2from3(:,6))...
    + K3(8)*lambda_2from3(:,8) + K3(10)*lambda_2from3(:,10));
K2(4) = simplify(K2(4) - K2(6));
K1 = simplify(K1 + K2(6)*(lambda_1from2(:,4)+lambda_1from2(:,6))...
    + K2(7)*lambda_1from2(:,7) + K2(10)*lambda_1from2(:,10));

K7(4) = 0; K7(9) = 0; K7(10) = 0;
K6(6) = 0; K6(7) = 0; K6(10) = 0;
K5(6) = 0; K5(8) = 0; K5(10) = 0;
K4(6) = 0; K4(7) = 0; K4(10) = 0;
K3(6) = 0; K3(8) = 0; K3(10) = 0;
K2(6) = 0; K2(7) = 0; K2(10) = 0;
K1(1:3) = 0; K1(5:6) = 0; K1(8) = 0; K1(10) = 0;

KR1 = K1; KR2 = K2; KR3 = K3; KR4 = K4; KR5 = K5; KR6 = K6; KR7 = K7;

K1 = K(:,1); K2 = K(:,2); K3 = K(:,3); K4 = K(:,4); 
K5 = K(:,5); K6 = K(:,6); K7 = K(:,7); 

[KR1 KR2 KR3 KR4 KR5 KR6 KR7]


