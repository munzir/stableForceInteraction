function V = linVel(f, key)

% Calculate linear velocity of the current frame measured in the world
% frame represented in the current frame
% 'f' is the map conatainer containing the information of the frames of 
% the robot
% 'key' identifies the current frame
% Optional arguments:
% 'w0' is the angular velocity of the base frame
% 'V0' is the linear velocity of the base frame

disp(['   Computing linVel of ', key]);

if(f(key).gotLinVel) 
    V=f(key).linVel;
else
    V = Rot(f, f(key).a, key) * (linVel(f, f(key).a) + ...
            cross(angVel(f, f(key).a), f(key).P));

    frame = f(key);
    frame.linVel = V;
    frame.gotLinVel = true;
    f(key) = frame;

end

disp(['   Computed linVel of ', key]);
