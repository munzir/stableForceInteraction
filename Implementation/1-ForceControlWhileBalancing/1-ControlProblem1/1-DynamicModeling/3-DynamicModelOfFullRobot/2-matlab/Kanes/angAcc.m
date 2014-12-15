function alpha = angAcc(f, key, varargin)

% Calculate angular acceleration of the current frame represented in the same
% frame.
% 'f' is the map container of the information for all the frames
% 'key' identifies the frame whose angular acceleration is demanded
% One more argument can define non-zero angular velocity of the base frame

disp(['   Computing angAcc of ', key]);

if(f(key).gotAngAcc) 
    alpha=f(key).angAcc;
else

    if(nargin == 2)
        w0 = [0; 0; 0];
        alpha0 = [0; 0; 0];
    else
        w0 = varargin{1}(:,1);
        alpha0 = varargin{1}(:,2);
    end

    % Angular acceleration of antecendent frame
    if(isequal(f(key).a, '0')) % if it's the first link in the chain
        alpha_a = Rot(f, f(key).a, key) * alpha0;
    else % recursive call if the frame is not the first link in the chain
        alpha_a = Rot(f, f(key).a, key) * angAcc(f, f(key).a, [w0 alpha0]);
    end

    % Angular acceleration of the current frame
    alpha = alpha_a + f(key).e * f(key).ddq ...
        + f(key).dq * cross(angVel(f, key, w0), f(key).e);

    frame = f(key);
    frame.angAcc = alpha;
    frame.gotAngAcc = true;
    f(key) = frame;
end

disp(['   Computed angAcc of ', key]);
