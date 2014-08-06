function dq = dqVec(f)

% Generate the vector containing all dq in the sequence defined by 'o'
% member of 'f'

key = keys(f);
n = length(key)-1;
dq = sym(zero(n, 1));
for i=1:length(key)
    if(isequal(key{i}, '0')); continue; end
    dq(f(key{i}).o) = f(key{i}).dq;
end