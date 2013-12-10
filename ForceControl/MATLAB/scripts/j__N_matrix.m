load groupedParams

syms abalakabala real
N = abalakabala*zeros(7,28);

first = [ones(1,7) 2*ones(1,6) 3*ones(1,5) 4*ones(1,4) 5*ones(1,3) 6*ones(1,2) 7];
second = [1:7 2:7 3:7 4:7 5:7 6:7 7];

for i=1:7
    for j=1:28
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

dqdq = [dq1*dq' dq2*dq(2:7)' dq3*dq(3:7)' dq4*dq(4:7)' dq5*dq(5:7)' dq6*dq(6:7)' dq7*dq7]';

Cdq = C*dq;
display('Cdq done   ');

Ndqdq=N*dqdq;
display('Ndqdq done   ');

for i=1:7
    i
    simplify(Cdq(i)-Ndqdq(i))
end