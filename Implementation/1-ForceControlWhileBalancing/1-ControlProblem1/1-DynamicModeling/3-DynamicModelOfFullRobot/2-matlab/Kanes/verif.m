k=0;

for a=2:-1:1
for b=17:-1:4

cc1=coeffdq(f,C(a,b)*dq(b));
cc2=coeffdq(f,CC(a,b)*dq(b));

cdq2=sym(zeros(17,1));
cdq=sym(zeros(17,1));
cdqdq=sym(zeros(17,17));

for i=1:17; tic; 
    disp(' '); disp(' '); disp(' ');
    t=clock;disp([num2str(t(4)),':',num2str(t(5)),':',num2str(floor(t(6)))]);
    disp(['a=',num2str(a),', b=',num2str(b)]);
    disp(['ddq',num2str(i)]);
    disp('Expanding c...'); 
    c=expand(cc1.dq2(i)); 
    disp('Expanding cc...'); 
    cc=expand(cc2.dq2(i)); 
    disp('Subtracting ...'); 
    delc=c-cc; 
    disp('Simplifying...'); 
    sdelc=simplify(delc); 
    pretty(sdelc); 
    cdq2(i)=sdelc;
    toc; 
end

for i=1:17; 
    for j=i:17; 
        tic; 
        disp(' '); disp(' ');disp(' ');disp(' '); 
        t=clock;disp([num2str(t(4)),':',num2str(t(5)),':',num2str(floor(t(6)))]);
        disp(['a=',num2str(a),', b=',num2str(b)]);
        disp(['dq',num2str(i),' dq',num2str(j)]); 
        disp('Expanding c...'); 
        c=expand(cc1.dqdq(i,j)); 
        disp('Expanding cc...'); 
        cc=expand(cc2.dqdq(i,j)); 
        disp('Subtracting ...'); 
        delc=c-cc; 
        disp('Simplifying...'); 
        sdelc=simplify(delc); 
        pretty(sdelc); 
        cdqdq(i,j)=sdelc;
        cdqdq(j,i)=sdelc;
        toc; 
    end
end

for i=1:17; 
    tic; 
    disp(' '); disp(' '); disp(' ');  
    t=clock;disp([num2str(t(4)),':',num2str(t(5)),':',num2str(floor(t(6)))]);
    disp(['a=',num2str(a),', b=',num2str(b)]);
    disp(['dq',num2str(i)]); 
    disp('Expanding c...'); 
    c=expand(cc1.dq(i)); 
    disp('Expanding cc...'); 
    cc=expand(cc2.dq(i)); 
    disp('Subtracting ...'); 
    delc=c-cc; disp('Simplifying...'); 
    sdelc=simplify(delc); 
    toc; 
    pretty(sdelc); 
    cdq(i)=sdelc;
end

pretty(cdq2);pretty(cdqdq);pretty(cdq);
k=k+1;
result(k).cdq2=cdq2; result(k).cdqdq=cdqdq; result(k).cdq=cdq; 

end
end