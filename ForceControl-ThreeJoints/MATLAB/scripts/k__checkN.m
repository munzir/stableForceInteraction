load N_matrix

for i=1:3
    for j=1:3
        for k=1:3
            i
            j
            k
            a=simplify(diff(diff(Cdq(i),dq(j)),dq(k))-diff(diff(Ndqdq(i),dq(j)),dq(k)))
            if(~isequaln(a,0))
                display('FAILURE!!!!')
                break;
            end
        end
        if(~isequaln(a,0))
            break;
        end
    end
    if(~isequaln(a,0))
        break;
    end
end