function cc = coeffdq(f, KK)


dq=dqVec(f);
n=length(dq);
for i=1:length(KK)
    cc(i).dq2 = sym(zeros(n,1)); 
    cc(i).dqdq = sym(zeros(n,n)); 
    cc(i).dq = sym(zeros(n,1));
    for j=1:n
        disp(['i=',num2str(i),', j=',num2str(j), 'dq2']);
        cc(i).dq2(j)=getcoeff(KK(i),dq(j),2);
        ccc=getcoeff(KK(i),dq(j),1);
        for k=1:n
            disp(['i=',num2str(i),', j=',num2str(j), ', k=', num2str(k)]);
            cc(i).dqdq(j,k)=getcoeff(ccc,dq(k),1);
            ccc=ccc-cc(i).dqdq(j,k)*dq(k);
        end
        disp(['i=',num2str(i),', j=',num2str(j), 'dq']);
        cc(i).dq(j)=ccc;
    end
end