function dq = dqVec(f)

% Generate dq vector in the order defined by memeber 'o' of the frames
% contained in 'f'

key = keys(f);
n = length(key)+1;
dq = sym(zeros(n, 1));
for i=1:length(key)
    if(isequal(key{i}, '0')); 
        w0 = f('0').angVel; 
        v0 = f('0').linVel;
        dq(1) = v0(1);
        dq(2) = w0(3);
    else
        dq(f(key{i}).o) = f(key{i}).dq;
    end
end