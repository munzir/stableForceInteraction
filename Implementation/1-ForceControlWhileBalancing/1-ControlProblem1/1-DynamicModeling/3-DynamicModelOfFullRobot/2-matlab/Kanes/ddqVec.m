function ddq = ddqVec(f)

% Generate ddq vector in the order defined by memeber 'o' of the frames
% contained in 'f'

key = keys(f);
n = length(key)+1;
ddq = sym(zeros(n, 1));
for i=1:length(key)
    if(isequal(key{i}, '0')); 
        alpha0 = f('0').angAcc;
        a0 = f('0').linAcc;
        ddq(1) = a0(1);
        ddq(2) = alpha0(3);
    else
        ddq(f(key{i}).o) = f(key{i}).ddq;
    end
end