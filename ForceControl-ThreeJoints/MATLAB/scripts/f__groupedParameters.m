%% Link 3
% eeta3 = [ - dq3/2 - w3(1), -w3(2), -w3(3), 0, 0, 0, 0, -V3(3), V3(2), 0];
% lambda_2from3 =
%   +-                                                                                                   -+
%   |                                                                                                  2  |
%   |  1,     0,       0,        0,             0,              0,     0,       #3,          #4,     L2   |
%   |                                                                                                     |
%   |  0,  cos(q3), sin(q3),     0,             0,              0,     0,       0,           0,       0   |
%   |                                                                                                     |
%   |  0, -sin(q3), cos(q3),     0,             0,              0,    -L2,      0,           0,       0   |
%   |                                                                                                     |
%   |                               2                              2                                   2  |
%   |  0,     0,       0,    cos(q3) ,          #1,         sin(q3) ,  0,       #3,          #4,     L2   |
%   |                                                                                                     |
%   |                                         2          2                                                |
%   |  0,     0,       0,       -#2,   cos(q3)  - sin(q3) ,    #2,     0,  -L2 cos(q3), -L2 sin(q3),  0   |
%   |                                                                                                     |
%   |                               2                              2                                      |
%   |  0,     0,       0,    sin(q3) ,         -#1,         cos(q3) ,  0,       0,           0,       0   |
%   |                                                                                                     |
%   |  0,     0,       0,        0,             0,              0,     1,       0,           0,       0   |
%   |                                                                                                     |
%   |  0,     0,       0,        0,             0,              0,     0,    cos(q3),     sin(q3),    0   |
%   |                                                                                                     |
%   |  0,     0,       0,        0,             0,              0,     0,    -sin(q3),    cos(q3),    L2  |
%   |                                                                                                     |
%   |  0,     0,       0,        0,             0,              0,     0,       0,           0,       1   |
%   +-                                                                                                   -+
%   
%   where
%   
%      #1 == 2 cos(q3) sin(q3)
%   
%      #2 == cos(q3) sin(q3)
%   
%      #3 == -2 L2 sin(q3)
%   
%      #4 == 2 L2 cos(q3)
%% We note that:
%   h3 = h2*lambda_2from3;
%   h3(4) = h2*(lambda_2from3(:,4) + lambda_2from3(:,6)) - h3(6)
%   h3(7) = h2*lambda_2from3(:,7)
%   h3(10) = h2*lambda_2from3(:,10)
%   
%   (lambda_2from3(:,4) + lambda_2from3(:,6)), 
%   lambda_2from3(:,7), lambda_2from3(:,10) are constants and so K3(4), 
%   K3(7) and K3(10) can be eliminated and the new parameters can be
%   defined by grouping together these guys with the remaining parameters 
%   using these constants as the coefficients.
%
%  So the new paramters would be:
%  K3(6) = K3(6) - K3(4)
%  K2 = K2 + (lambda_2from3(:,4) + lambda_2from3(:,6))*K3(4) 
%      lambda_2from3(:,7)*K3(7) + lambda_2from3(:,10)*K3(10)
%% Link 2
% eeta2 = [ - dq2/2 - w2(1), -w2(2), -w2(3), 0, 0, 0, 0, -V2(3), V2(2), 0];
% lambda_1from2 =
%   +-                                                                              -+
%   |  1,     0,       0,        0,        0,         0,    0,     0,       0,    0  |
%   |                                                                                |
%   |  0,  cos(q2), sin(q2),     0,        0,         0,    0,     0,       0,    0  |
%   |                                                                                |
%   |  0, -sin(q2), cos(q2),     0,        0,         0,    0,     0,       0,    0  |
%   |                                                                                |
%   |                               2                    2                           |
%   |  0,     0,       0,    cos(q2) ,     #1,    sin(q2) , 0,     0,       0,    0  |
%   |                                                                                |
%   |  0,     0,       0,       -#2,   cos(2 q2),    #2,    0,     0,       0,    0  |
%   |                                                                                |
%   |                               2                    2                           |
%   |  0,     0,       0,    sin(q2) ,    -#1,    cos(q2) , 0,     0,       0,    0  |
%   |                                                                                |
%   |  0,     0,       0,        0,        0,         0,    1,     0,       0,    0  |
%   |                                                                                |
%   |  0,     0,       0,        0,        0,         0,    0,  cos(q2), sin(q2), 0  |
%   |                                                                                |
%   |  0,     0,       0,        0,        0,         0,    0, -sin(q2), cos(q2), 0  |
%   |                                                                                |
%   |  0,     0,       0,        0,        0,         0,    0,     0,       0,    1  |
%   +-                                                                              -+
%   
%   where
%   
%      #1 == 2 cos(q2) sin(q2)
%   
%            sin(2 q2)
%      #2 == ---------
%                2
%% We note that:
%   h2 = h1*lambda_1from2;
%   h2(4) = h1*(lambda_1from2(:,4) + lambda_1from2(:,6)) - h2(6)
%   h2(7) = h1*lambda_1from2(:,7)
%   h2(10) = h1*lambda_1from2(:,10)
%   
%   (lambda_1from2(:,4) + lambda_1from2(:,6)), lambda_1from2(:,7), 
%   lambda_1from2(:,10) are constants and so K2(4), K2(7) and K2(10) can 
%   be eliminated and the new parameters can be
%   defined by grouping together these guys with the remaining parameters 
%   using these constants as the coefficients.
%
%  So the new paramters would be:
%  K2(6) = K2(6) - K2(4)
%  K1 = K1 + (lambda_1from2(:,1) + lambda_1from2(:,4))*K2(4) 
%      + lambda_1from2(:,7)*K2(7) + lambda_1from2(:,10)*K2(10)
%% Link 1:
% h1 = [ 0, 0, 0, 0, 0, dq1^2/2, (49*cos(q1))/5, (49*sin(q1))/5, 0, 0]
% So, K1(1:5) = 0; K1(9:10) = 0;


%% So now we go!

load lambda
a = [4 4; 4 5; 4 6; 5 5; 5 6; 6 6; 6 2; 4 3; 5 1; 1 1];
JJ = {JJ1, JJ2, JJ3};
syms alabala
K = alabala * zeros(10,7);
for i=1:3
    for j=1:10
        K(j,i) = JJ{i}(a(j,1), a(j,2));
    end
end
K1 = K(:,1); K2 = K(:,2); K3 = K(:,3);

K3(6) = simplify(K3(6) - K3(4));
K2 = simplify(K2 + (lambda_2from3(:,4) + lambda_2from3(:,6))*K3(4)  ...
     + lambda_2from3(:,7)*K3(7) + lambda_2from3(:,10)*K3(10));

K2(6) = simplify(K2(6) - K2(4));
K1 = simplify(K1 + (lambda_1from2(:,6) + lambda_1from2(:,4))*K2(4) + ...
      + lambda_1from2(:,7)*K2(7) + lambda_1from2(:,10)*K2(10));



K3(4) = 0; K3(7) = 0; K3(10) = 0;
K2(4) = 0; K2(7) = 0; K2(10) = 0;
K1(1:5) = 0; K1(9:10) = 0;

KR1 = K1; KR2 = K2; KR3 = K3;

K1 = K(:,1); K2 = K(:,2); K3 = K(:,3); 

[KR1 KR2 KR3]


