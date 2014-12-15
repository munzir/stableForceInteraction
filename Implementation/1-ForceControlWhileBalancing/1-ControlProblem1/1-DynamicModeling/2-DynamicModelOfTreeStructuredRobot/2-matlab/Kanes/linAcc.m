function a = linAcc(f, key, varargin)

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

    if(nargin == 2)
        w0 = [0;0;0];
        alpha0 = [0;0;0];
        V0= [0;0;0];
        a0 = [0;0;0];
    else
        w0 = varargin{1}(:,1);
        alpha0 = varargin{1}(:,2);
        V0 = varargin{1}(:,3);
        a0 = varargin{1}(:,4);
    end

    % Vel/Acc of antecedent frame represented in antededent frame
    if(isequal(f(key).a, '0')) % if it's the first link in the chain
        w_a = w0;
        alpha_a = alpha0;
        a_a = a0;
    else % if it's some other link
        w_a = angVel(f, f(key).a, w0); 
        alpha_a = angAcc(f, f(key).a, [w0 alpha0]); 
        a_a = linAcc(f, f(key).a, [w0 alpha0 V0 a0]); 
    end

    % Acceleration of the current frame
    a = Rot(f, f(key).a, key) * (a_a + cross(alpha_a, f(key).P) ...
        + cross(w_a, cross(w_a, f(key).P)));

    frame = f(key);
    frame.linAcc = a;
    frame.gotLinAcc = true;
    f(key) = frame;

end
    
disp(['   Computed linAcc of ', key]);
