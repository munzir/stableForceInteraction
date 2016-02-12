function w = angVel(f, key)

% Calculate angular velocity of the current frame represented in the same
% frame.
% 'f' is the map container of the information for all the frames
% 'key' identifies the frame whose angular veclocity is demanded
% One more argument can define non-zero angular velocity of the base frame

disp(['   Computing angVel of ', key]);


if(f(key).gotAngVel) % This serves two purposes:
                     % 1. Base condition for recursive call as Frame 0 is
                     % setup to be gotAngVel = true
                     % 2. If this link has already been evaluated then
                     % don't go into recursion
    w=f(key).angVel;
else % recursive call 
    w = Rot(f, f(key).a, key) * angVel(f, f(key).a) + f(key).e*f(key).dq;
    frame = f(key);
    frame.angVel = w;
    frame.gotAngVel = true;
    f(key) = frame;
end

disp(['   Computed angVel of ', key]);
