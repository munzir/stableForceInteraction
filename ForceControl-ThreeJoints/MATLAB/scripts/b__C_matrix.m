clear 
load KE

for i=1:3; 
    for j=1:3; 
        d(i,j,1)=diff(A(i,j),q1); 
        d(i,j,2)=diff(A(i,j),q2); 
        d(i,j,3)=diff(A(i,j),q3); 
    end; 
end

for i = 1:3
    for j = 1:3
        C(i,j)=((d(i,j,1) + d(i,1,j) - d(j,1,i))/2)*dq1;
        for k = 2:3
            C(i,j) = C(i,j) + ((d(i,j,k) + d(i,k,j) - d(j,k,i))/2)*dq(k);
        end
    end
end