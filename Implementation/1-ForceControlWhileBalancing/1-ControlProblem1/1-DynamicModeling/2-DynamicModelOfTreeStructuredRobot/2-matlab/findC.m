function C = findC(f, A)

key = keys(f);
n = length(key)-1;

% Get partial derivatives of A_ij wrt q_k and store them in dA
dA = sym(zeros(n, n, n));
dq = dqVec(f);
for i=1:n    
    for j=1:n
        for k=1:n
            dA(i, j, k) = diff(A(i, j), dq(k));
        end
    end
end 

% Find Christoffel coefficients c_ijk and use them to find C_ij
c = sym(zeros(n, n, n));
C = sym(zeros(n, n));
for i=1:n    
    for j=1:n
        for k=1:n
            c(i, j, k) = 0.5*(dA(i, j, k) + dA(i, k, j) - dA(j, k, i));
        end
        C(i, j) = C(i, j) + c(i, j, k)*dq(k);
    end
end 