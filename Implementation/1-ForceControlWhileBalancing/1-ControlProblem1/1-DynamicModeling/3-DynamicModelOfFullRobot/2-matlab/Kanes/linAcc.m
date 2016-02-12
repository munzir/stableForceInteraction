function a = linAcc(f, key)

% Calculate linear velocity of the current frame measured in the world
% frame represented in the current frame
% 'f' is the map conatainer containing the information of the frames of 
% the robot
% 'key' identifies the current frame
% Optional arguments:
% 'w0' is the angular velocity of the base frame
% 'V0' is the linear velocity of the base frame

disp(['   Computing linAcc of ', key]);

if(f(key).gotLinAcc) 
    a=f(key).linAcc;
else
    w_a = angVel(f, f(key).a); 
    alpha_a = angAcc(f, f(key).a); 
    a_a = linAcc(f, f(key).a); 

    % Acceleration of the current frame
    a = Rot(f, f(key).a, key) * (a_a + cross(alpha_a, f(key).P) ...
        + cross(w_a, cross(w_a, f(key).P)));

    frame = f(key);
    frame.linAcc = a;
    frame.gotLinAcc = true;
    f(key) = frame;

end
    
disp(['   Computed linAcc of ', key]);
