load groupedParams

syms abalakabala real
N = abalakabala*zeros(3,6);

first = [ones(1,3) 2*ones(1,2) 3];
second = [1:3 2:3 3];

for i=1:3
    for j=1:6
        i
        j
        k=first(j); l=second(j);
        [CCC,TTT]=coeffs(C(i,k),dq(l));
        for p=1:length(TTT)
            if(TTT(p)==dq(l))
                N(i,j)=CCC(p);
            end
        end
        if(k~=l)
            [CCC,TTT]=coeffs(C(i,l),dq(k));
            for p=1:length(TTT)
                if(TTT(p)==dq(k))
                    N(i,j)=N(i,j)+CCC(p);
                end
            end
        end
    end
end

save N

dqdq = [dq1*dq' dq2*dq(2:3)' dq3*dq3]';

Cdq = C*dq;
display('Cdq done   ');

Ndqdq=N*dqdq;
display('Ndqdq done   ');

for i=1:3
    i
    simplify(Cdq(i)-Ndqdq(i))
end