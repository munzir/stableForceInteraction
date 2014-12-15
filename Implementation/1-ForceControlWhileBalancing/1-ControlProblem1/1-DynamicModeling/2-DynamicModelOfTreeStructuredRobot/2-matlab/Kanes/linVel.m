function V = linVel(f, key, varargin)

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

    if(nargin == 2)
        w0 = [0;0;0];
        V0= [0;0;0];
    else
        w0 = varargin{1}(:,1);
        V0 = varargin{1}(:,2);
    end

    if(isequal(f(key).a, '0')) % if it's the first link in the chain
        V = Rot(f, f(key).a, key) * (V0 + cross(w0, f(key).P));
    else % if it's some other link
        V = Rot(f, f(key).a, key) * (linVel(f, f(key).a) + ...
            cross(angVel(f, f(key).a), f(key).P));
    end
    
    frame = f(key);
    frame.linVel = V;
    frame.gotLinVel = true;
    f(key) = frame;

end

disp(['   Computed linVel of ', key]);
