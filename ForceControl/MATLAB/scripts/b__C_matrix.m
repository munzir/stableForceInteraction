clear 
load KE

for i=1:7; 
    for j=1:7; 
        d(i,j,1)=diff(A(i,j),q1); 
        d(i,j,2)=diff(A(i,j),q2); 
        d(i,j,3)=diff(A(i,j),q3); 
        d(i,j,4)=diff(A(i,j),q4); 
        d(i,j,5)=diff(A(i,j),q5); 
        d(i,j,6)=diff(A(i,j),q6); 
        d(i,j,7)=diff(A(i,j),q7); 
    end; 
end

for i = 1:7
    for j = 1:7
        C(i,j)=((d(i,j,1) + d(i,1,j) - d(j,1,i))/2)*dq1;
        for k = 2:7
            C(i,j) = C(i,j) + ((d(i,j,k) + d(i,k,j) - d(j,k,i))/2)*dq(k);
        end
    end
end