syms abalakabala real



for i=1:7; 
    coeffdqi = abalakabala * 0;
    [CCC, TTT]=coeffs(L6T7,dq(i)); 
    for k=1:length(TTT); 
        if(isequaln(TTT(k),dq(i)^2)); 
            coeffdqi=coeffdqi+CCC(k)*dq(i); 
        elseif(isequaln(TTT(k),dq(i)))
            coeffdqi=coeffdqi+CCC(k);
        end
    end; 
    if(~isequal(coeffdqi,0))
        for j=i:7; 
            coeffdqidqj = abalakabala * 0;
            [CCC, TTT]=coeffs(coeffdqi,dq(j)); 
            for k=1:length(TTT); 
                if(isequaln(TTT(k),dq(j))); 
                    coeffdqidqj=CCC(k); 
                end; 
            end; 
            if(~isequaln(coeffdqidqj,0)) 
                display([i j])
            end; 
        end; 
    end
end;