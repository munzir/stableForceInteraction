function alpha = angAcc(f, key)

% Calculate angular acceleration of the current frame represented in the same
% frame.
% 'f' is the map container of the information for all the frames
% 'key' identifies the frame whose angular acceleration is demanded
% One more argument can define non-zero angular velocity of the base frame

disp(['   Computing angAcc of ', key]);

if(f(key).gotAngAcc) 
    alpha=f(key).angAcc;
else
    alpha_a = Rot(f, f(key).a, key) * angAcc(f, f(key).a);
    alpha = alpha_a + f(key).e * f(key).ddq ...
        + f(key).dq * cross(angVel(f, key), f(key).e);

    frame = f(key);
    frame.angAcc = alpha;
    frame.gotAngAcc = true;
    f(key) = frame;
end

disp(['   Computed angAcc of ', key]);
