function [A, C] = getAC(f, K, varargin)

if nargin == 2
    dq=dqVec(f);
    ddq=ddqVec(f);
elseif nargin > 2
    dq=[varargin{1}; dqVec(f)];
    ddq=[varargin{2}; ddqVec(f)];
end

n=length(dq);
A = sym(zeros(n,n)); C = sym(zeros(n,n)); 
for i=1:n
    for j=1:n
        A(i,j)=getcoeff(K(i),ddq(j),1);
        C(i,j)=getcoeff(K(i), dq(j),2)*dq(j);
        ccc = getcoeff(K(i),dq(j),1); 
        C(i,j) = C(i,j)+ccc;
        for k=1:n
            disp(['getAC: i=', num2str(i), ', j=', num2str(j), ', k=', num2str(k)]);
            C(i,j) = C(i,j) - 0.5*(getcoeff(ccc,dq(k),1))*dq(k);
        end
    end
end

% A=simplify(A);
% C=simplify(C);
