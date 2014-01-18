load frictionAdded

%% Link 1, 2
% dq2:dq7 = 0, ddq1:ddq7 = 0 
L1T2 = subs(GGamma(2), {dq3, dq4 ,dq5 ,dq6, dq7, ddq3, ddq4 ,ddq5 ,ddq6, ddq7}, {0, 0, 0, 0, 0, 0, 0, 0, 0, 0});
DD_L1T2 = subs(DD(2,:), {dq3, dq4 ,dq5 ,dq6, dq7, ddq3, ddq4 ,ddq5 ,ddq6, ddq7}, {0, 0, 0, 0, 0, 0, 0, 0, 0, 0});

syms abalakabala real
D_L1T2 = abalakabala*zeros(1,size(DD,2));
K_L1T2 = abalakabala*zeros(length(KKR),1);
K_L1T2_ind = zeros(length(KKR),1);

j = 0;
for i=1:size(DD,2)
    if(~isequaln(DD_L1T2(1,i),0) && ~isequaln(KKR(i),0))
        j = j + 1;
        D_L1T2(j) = DD_L1T2(1,i);
        K_L1T2(j) = KKR(i);
        K_L1T2_ind(j) = i;
    end
end

D_L1T2 = D_L1T2(1:j);
K_L1T2 = K_L1T2(1:j);
K_L1T2_ind = K_L1T2_ind(1:j);

simplify(L1T2 - D_L1T2*K_L1T2)
%% Link 1, 3
% dq2:dq7 = 0, ddq1:ddq7 = 0 
L1T3 = subs(GGamma(3), {dq2, dq4 ,dq5 ,dq6, dq7, ddq2, ddq4 ,ddq5 ,ddq6, ddq7}, {0, 0, 0, 0, 0, 0, 0, 0, 0, 0});
DD_L1T3 = subs(DD(3,:), {dq2, dq4 ,dq5 ,dq6, dq7, ddq2, ddq4 ,ddq5 ,ddq6, ddq7}, {0, 0, 0, 0, 0, 0, 0, 0, 0, 0});

syms abalakabala real
D_L1T3 = abalakabala*zeros(1,size(DD,2));
K_L1T3 = abalakabala*zeros(length(KKR),1);
K_L1T3_ind = zeros(length(KKR),1);

j = 0;
for i=1:size(DD,2)
    if(~isequaln(DD_L1T3(1,i),0) && ~isequaln(KKR(i),0))
        j = j + 1;
        D_L1T3(j) = DD_L1T3(1,i);
        K_L1T3(j) = KKR(i);
        K_L1T3_ind(j) = i;
    end
end

D_L1T3 = D_L1T3(1:j);
K_L1T3 = K_L1T3(1:j);
K_L1T3_ind = K_L1T3_ind(1:j);

simplify(L1T3 - D_L1T3*K_L1T3)
%% Link 1, 4
% dq2:dq7 = 0, ddq1:ddq7 = 0 
L1T4 = subs(GGamma(4), {dq3, dq2 ,dq5 ,dq6, dq7, ddq3, ddq2 ,ddq5 ,ddq6, ddq7}, {0, 0, 0, 0, 0, 0, 0, 0, 0, 0});
DD_L1T4 = subs(DD(4,:), {dq3, dq2 ,dq5 ,dq6, dq7, ddq3, ddq2 ,ddq5 ,ddq6, ddq7}, {0, 0, 0, 0, 0, 0, 0, 0, 0, 0});

syms abalakabala real
D_L1T4 = abalakabala*zeros(1,size(DD,2));
K_L1T4 = abalakabala*zeros(length(KKR),1);
K_L1T4_ind = zeros(length(KKR),1);

j = 0;
for i=1:size(DD,2)
    if(~isequaln(DD_L1T4(1,i),0) && ~isequaln(KKR(i),0))
        j = j + 1;
        D_L1T4(j) = DD_L1T4(1,i);
        K_L1T4(j) = KKR(i);
        K_L1T4_ind(j) = i;
    end
end

D_L1T4 = D_L1T4(1:j);
K_L1T4 = K_L1T4(1:j);
K_L1T4_ind = K_L1T4_ind(1:j);

simplify(L1T4 - D_L1T4*K_L1T4)
%% Link 1, 5
% dq2:dq7 = 0, ddq1:ddq7 = 0 
L1T5 = subs(GGamma(5), {dq3, dq4 ,dq2 ,dq6, dq7, ddq3, ddq4 ,ddq2 ,ddq6, ddq7}, {0, 0, 0, 0, 0, 0, 0, 0, 0, 0});
DD_L1T5 = subs(DD(5,:), {dq3, dq4 ,dq2 ,dq6, dq7, ddq3, ddq4 ,ddq2 ,ddq6, ddq7}, {0, 0, 0, 0, 0, 0, 0, 0, 0, 0});

syms abalakabala real
D_L1T5 = abalakabala*zeros(1,size(DD,2));
K_L1T5 = abalakabala*zeros(length(KKR),1);
K_L1T5_ind = zeros(length(KKR),1);

j = 0;
for i=1:size(DD,2)
    if(~isequaln(DD_L1T5(1,i),0) && ~isequaln(KKR(i),0))
        j = j + 1;
        D_L1T5(j) = DD_L1T5(1,i);
        K_L1T5(j) = KKR(i);
        K_L1T5_ind(j) = i;
    end
end

D_L1T5 = D_L1T5(1:j);
K_L1T5 = K_L1T5(1:j);
K_L1T5_ind = K_L1T5_ind(1:j);

simplify(L1T5 - D_L1T5*K_L1T5)
%% Link 1, 6
% dq2:dq7 = 0, ddq1:ddq7 = 0 
L1T6 = subs(GGamma(6), {dq3, dq4 ,dq5 ,dq2, dq7, ddq3, ddq4 ,ddq5 ,ddq2, ddq7}, {0, 0, 0, 0, 0, 0, 0, 0, 0, 0});
DD_L1T6 = subs(DD(6,:), {dq3, dq4 ,dq5 ,dq2, dq7, ddq3, ddq4 ,ddq5 ,ddq2, ddq7}, {0, 0, 0, 0, 0, 0, 0, 0, 0, 0});

syms abalakabala real
D_L1T6 = abalakabala*zeros(1,size(DD,2));
K_L1T6 = abalakabala*zeros(length(KKR),1);
K_L1T6_ind = zeros(length(KKR),1);

j = 0;
for i=1:size(DD,2)
    if(~isequaln(DD_L1T6(1,i),0) && ~isequaln(KKR(i),0))
        j = j + 1;
        D_L1T6(j) = DD_L1T6(1,i);
        K_L1T6(j) = KKR(i);
        K_L1T6_ind(j) = i;
    end
end

D_L1T6 = D_L1T6(1:j);
K_L1T6 = K_L1T6(1:j);
K_L1T6_ind = K_L1T6_ind(1:j);

simplify(L1T6 - D_L1T6*K_L1T6)
%% Link 1, 7
% dq2:dq7 = 0, ddq1:ddq7 = 0 
L1T7 = subs(GGamma(7), {dq3, dq4 ,dq5 ,dq6, dq2, ddq3, ddq4 ,ddq5 ,ddq6, ddq2}, {0, 0, 0, 0, 0, 0, 0, 0, 0, 0});
DD_L1T7 = subs(DD(7,:), {dq3, dq4 ,dq5 ,dq6, dq2, ddq3, ddq4 ,ddq5 ,ddq6, ddq2}, {0, 0, 0, 0, 0, 0, 0, 0, 0, 0});

syms abalakabala real
D_L1T7 = abalakabala*zeros(1,size(DD,2));
K_L1T7 = abalakabala*zeros(length(KKR),1);
K_L1T7_ind = zeros(length(KKR),1);

j = 0;
for i=1:size(DD,2)
    if(~isequaln(DD_L1T7(1,i),0) && ~isequaln(KKR(i),0))
        j = j + 1;
        D_L1T7(j) = DD_L1T7(1,i);
        K_L1T7(j) = KKR(i);
        K_L1T7_ind(j) = i;
    end
end

D_L1T7 = D_L1T7(1:j);
K_L1T7 = K_L1T7(1:j);
K_L1T7_ind = K_L1T7_ind(1:j);

simplify(L1T7 - D_L1T7*K_L1T7)
%% Link 2, 3
% dq2:dq7 = 0, ddq1:ddq7 = 0 
L2T3 = subs(GGamma(3), {dq1, dq4 ,dq5 ,dq6, dq7, ddq1, ddq4 ,ddq5 ,ddq6, ddq7}, {0, 0, 0, 0, 0, 0, 0, 0, 0, 0});
DD_L2T3 = subs(DD(3,:), {dq1, dq4 ,dq5 ,dq6, dq7, ddq1, ddq4 ,ddq5 ,ddq6, ddq7}, {0, 0, 0, 0, 0, 0, 0, 0, 0, 0});

syms abalakabala real
D_L2T3 = abalakabala*zeros(1,size(DD,2));
K_L2T3 = abalakabala*zeros(length(KKR),1);
K_L2T3_ind = zeros(length(KKR),1);

j = 0;
for i=1:size(DD,2)
    if(~isequaln(DD_L2T3(1,i),0) && ~isequaln(KKR(i),0))
        j = j + 1;
        D_L2T3(j) = DD_L2T3(1,i);
        K_L2T3(j) = KKR(i);
        K_L2T3_ind(j) = i;
    end
end

D_L2T3 = D_L2T3(1:j);
K_L2T3 = K_L2T3(1:j);
K_L2T3_ind = K_L2T3_ind(1:j);

simplify(L2T3 - D_L2T3*K_L2T3)
%% Link 2, 4
% dq2:dq7 = 0, ddq1:ddq7 = 0 
L2T4 = subs(GGamma(4), {dq3, dq1 ,dq5 ,dq6, dq7, ddq3, ddq1 ,ddq5 ,ddq6, ddq7}, {0, 0, 0, 0, 0, 0, 0, 0, 0, 0});
DD_L2T4 = subs(DD(4,:), {dq3, dq1 ,dq5 ,dq6, dq7, ddq3, ddq1 ,ddq5 ,ddq6, ddq7}, {0, 0, 0, 0, 0, 0, 0, 0, 0, 0});

syms abalakabala real
D_L2T4 = abalakabala*zeros(1,size(DD,2));
K_L2T4 = abalakabala*zeros(length(KKR),1);
K_L2T4_ind = zeros(length(KKR),1);

j = 0;
for i=1:size(DD,2)
    if(~isequaln(DD_L2T4(1,i),0) && ~isequaln(KKR(i),0))
        j = j + 1;
        D_L2T4(j) = DD_L2T4(1,i);
        K_L2T4(j) = KKR(i);
        K_L2T4_ind(j) = i;
    end
end

D_L2T4 = D_L2T4(1:j);
K_L2T4 = K_L2T4(1:j);
K_L2T4_ind = K_L2T4_ind(1:j);

simplify(L2T4 - D_L2T4*K_L2T4)
%% Link 2, 5
% dq2:dq7 = 0, ddq1:ddq7 = 0 
L2T5 = subs(GGamma(5), {dq3, dq4 ,dq1 ,dq6, dq7, ddq3, ddq4 ,ddq1 ,ddq6, ddq7}, {0, 0, 0, 0, 0, 0, 0, 0, 0, 0});
DD_L2T5 = subs(DD(5,:), {dq3, dq4 ,dq1 ,dq6, dq7, ddq3, ddq4 ,ddq1 ,ddq6, ddq7}, {0, 0, 0, 0, 0, 0, 0, 0, 0, 0});

syms abalakabala real
D_L2T5 = abalakabala*zeros(1,size(DD,2));
K_L2T5 = abalakabala*zeros(length(KKR),1);
K_L2T5_ind = zeros(length(KKR),1);

j = 0;
for i=1:size(DD,2)
    if(~isequaln(DD_L2T5(1,i),0) && ~isequaln(KKR(i),0))
        j = j + 1;
        D_L2T5(j) = DD_L2T5(1,i);
        K_L2T5(j) = KKR(i);
        K_L2T5_ind(j) = i;
    end
end

D_L2T5 = D_L2T5(1:j);
K_L2T5 = K_L2T5(1:j);
K_L2T5_ind = K_L2T5_ind(1:j);

simplify(L2T5 - D_L2T5*K_L2T5)
%% Link 2, 6
% dq2:dq7 = 0, ddq1:ddq7 = 0 
L2T6 = subs(GGamma(6), {dq3, dq4 ,dq5 ,dq1, dq7, ddq3, ddq4 ,ddq5 ,ddq1, ddq7}, {0, 0, 0, 0, 0, 0, 0, 0, 0, 0});
DD_L2T6 = subs(DD(6,:), {dq3, dq4 ,dq5 ,dq1, dq7, ddq3, ddq4 ,ddq5 ,ddq1, ddq7}, {0, 0, 0, 0, 0, 0, 0, 0, 0, 0});

syms abalakabala real
D_L2T6 = abalakabala*zeros(1,size(DD,2));
K_L2T6 = abalakabala*zeros(length(KKR),1);
K_L2T6_ind = zeros(length(KKR),1);

j = 0;
for i=1:size(DD,2)
    if(~isequaln(DD_L2T6(1,i),0) && ~isequaln(KKR(i),0))
        j = j + 1;
        D_L2T6(j) = DD_L2T6(1,i);
        K_L2T6(j) = KKR(i);
        K_L2T6_ind(j) = i;
    end
end

D_L2T6 = D_L2T6(1:j);
K_L2T6 = K_L2T6(1:j);
K_L2T6_ind = K_L2T6_ind(1:j);

simplify(L2T6 - D_L2T6*K_L2T6)
%% Link 2, 7
% dq2:dq7 = 0, ddq1:ddq7 = 0 
L2T7 = subs(GGamma(7), {dq3, dq4 ,dq5 ,dq6, dq1, ddq3, ddq4 ,ddq5 ,ddq6, ddq1}, {0, 0, 0, 0, 0, 0, 0, 0, 0, 0});
DD_L2T7 = subs(DD(7,:), {dq3, dq4 ,dq5 ,dq6, dq1, ddq3, ddq4 ,ddq5 ,ddq6, ddq1}, {0, 0, 0, 0, 0, 0, 0, 0, 0, 0});

syms abalakabala real
D_L2T7 = abalakabala*zeros(1,size(DD,2));
K_L2T7 = abalakabala*zeros(length(KKR),1);
K_L2T7_ind = zeros(length(KKR),1);

j = 0;
for i=1:size(DD,2)
    if(~isequaln(DD_L2T7(1,i),0) && ~isequaln(KKR(i),0))
        j = j + 1;
        D_L2T7(j) = DD_L2T7(1,i);
        K_L2T7(j) = KKR(i);
        K_L2T7_ind(j) = i;
    end
end

D_L2T7 = D_L2T7(1:j);
K_L2T7 = K_L2T7(1:j);
K_L2T7_ind = K_L2T7_ind(1:j);

simplify(L2T7 - D_L2T7*K_L2T7)
%% Link 3, 4
% dq2:dq7 = 0, ddq1:ddq7 = 0 
L3T4 = subs(GGamma(4), {dq1, dq2 ,dq5 ,dq6, dq7, ddq1, ddq2 ,ddq5 ,ddq6, ddq7}, {0, 0, 0, 0, 0, 0, 0, 0, 0, 0});
DD_L3T4 = subs(DD(4,:), {dq1, dq2 ,dq5 ,dq6, dq7, ddq1, ddq2 ,ddq5 ,ddq6, ddq7}, {0, 0, 0, 0, 0, 0, 0, 0, 0, 0});

syms abalakabala real
D_L3T4 = abalakabala*zeros(1,size(DD,2));
K_L3T4 = abalakabala*zeros(length(KKR),1);
K_L3T4_ind = zeros(length(KKR),1);

j = 0;
for i=1:size(DD,2)
    if(~isequaln(DD_L3T4(1,i),0) && ~isequaln(KKR(i),0))
        j = j + 1;
        D_L3T4(j) = DD_L3T4(1,i);
        K_L3T4(j) = KKR(i);
        K_L3T4_ind(j) = i;
    end
end

D_L3T4 = D_L3T4(1:j);
K_L3T4 = K_L3T4(1:j);
K_L3T4_ind = K_L3T4_ind(1:j);

simplify(L3T4 - D_L3T4*K_L3T4)
%% Link 3, 5
% dq2:dq7 = 0, ddq1:ddq7 = 0 
L3T5 = subs(GGamma(5), {dq1, dq4 ,dq2 ,dq6, dq7, ddq1, ddq4 ,ddq2 ,ddq6, ddq7}, {0, 0, 0, 0, 0, 0, 0, 0, 0, 0});
DD_L3T5 = subs(DD(5,:), {dq1, dq4 ,dq2 ,dq6, dq7, ddq1, ddq4 ,ddq2 ,ddq6, ddq7}, {0, 0, 0, 0, 0, 0, 0, 0, 0, 0});

syms abalakabala real
D_L3T5 = abalakabala*zeros(1,size(DD,2));
K_L3T5 = abalakabala*zeros(length(KKR),1);
K_L3T5_ind = zeros(length(KKR),1);

j = 0;
for i=1:size(DD,2)
    if(~isequaln(DD_L3T5(1,i),0) && ~isequaln(KKR(i),0))
        j = j + 1;
        D_L3T5(j) = DD_L3T5(1,i);
        K_L3T5(j) = KKR(i);
        K_L3T5_ind(j) = i;
    end
end

D_L3T5 = D_L3T5(1:j);
K_L3T5 = K_L3T5(1:j);
K_L3T5_ind = K_L3T5_ind(1:j);

simplify(L3T5 - D_L3T5*K_L3T5)
%% Link 3, 6
% dq2:dq7 = 0, ddq1:ddq7 = 0 
L3T6 = subs(GGamma(6), {dq1, dq4 ,dq5 ,dq2, dq7, ddq1, ddq4 ,ddq5 ,ddq2, ddq7}, {0, 0, 0, 0, 0, 0, 0, 0, 0, 0});
DD_L3T6 = subs(DD(6,:), {dq1, dq4 ,dq5 ,dq2, dq7, ddq1, ddq4 ,ddq5 ,ddq2, ddq7}, {0, 0, 0, 0, 0, 0, 0, 0, 0, 0});

syms abalakabala real
D_L3T6 = abalakabala*zeros(1,size(DD,2));
K_L3T6 = abalakabala*zeros(length(KKR),1);
K_L3T6_ind = zeros(length(KKR),1);

j = 0;
for i=1:size(DD,2)
    if(~isequaln(DD_L3T6(1,i),0) && ~isequaln(KKR(i),0))
        j = j + 1;
        D_L3T6(j) = DD_L3T6(1,i);
        K_L3T6(j) = KKR(i);
        K_L3T6_ind(j) = i;
    end
end

D_L3T6 = D_L3T6(1:j);
K_L3T6 = K_L3T6(1:j);
K_L3T6_ind = K_L3T6_ind(1:j);

simplify(L3T6 - D_L3T6*K_L3T6)
%% Link 3, 7
% dq2:dq7 = 0, ddq1:ddq7 = 0 
L3T7 = subs(GGamma(7), {dq1, dq4 ,dq5 ,dq6, dq2, ddq1, ddq4 ,ddq5 ,ddq6, ddq2}, {0, 0, 0, 0, 0, 0, 0, 0, 0, 0});
DD_L3T7 = subs(DD(7,:), {dq1, dq4 ,dq5 ,dq6, dq2, ddq1, ddq4 ,ddq5 ,ddq6, ddq2}, {0, 0, 0, 0, 0, 0, 0, 0, 0, 0});

syms abalakabala real
D_L3T7 = abalakabala*zeros(1,size(DD,2));
K_L3T7 = abalakabala*zeros(length(KKR),1);
K_L3T7_ind = zeros(length(KKR),1);

j = 0;
for i=1:size(DD,2)
    if(~isequaln(DD_L3T7(1,i),0) && ~isequaln(KKR(i),0))
        j = j + 1;
        D_L3T7(j) = DD_L3T7(1,i);
        K_L3T7(j) = KKR(i);
        K_L3T7_ind(j) = i;
    end
end

D_L3T7 = D_L3T7(1:j);
K_L3T7 = K_L3T7(1:j);
K_L3T7_ind = K_L3T7_ind(1:j);

simplify(L3T7 - D_L3T7*K_L3T7)
%% Link 4, 5
% dq2:dq7 = 0, ddq1:ddq7 = 0 
L4T5 = subs(GGamma(5), {dq3, dq1 ,dq2 ,dq6, dq7, ddq3, ddq1 ,ddq2 ,ddq6, ddq7}, {0, 0, 0, 0, 0, 0, 0, 0, 0, 0});
DD_L4T5 = subs(DD(5,:), {dq3, dq1 ,dq2 ,dq6, dq7, ddq3, ddq1 ,ddq2 ,ddq6, ddq7}, {0, 0, 0, 0, 0, 0, 0, 0, 0, 0});

syms abalakabala real
D_L4T5 = abalakabala*zeros(1,size(DD,2));
K_L4T5 = abalakabala*zeros(length(KKR),1);
K_L4T5_ind = zeros(length(KKR),1);

j = 0;
for i=1:size(DD,2)
    if(~isequaln(DD_L4T5(1,i),0) && ~isequaln(KKR(i),0))
        j = j + 1;
        D_L4T5(j) = DD_L4T5(1,i);
        K_L4T5(j) = KKR(i);
        K_L4T5_ind(j) = i;
    end
end

D_L4T5 = D_L4T5(1:j);
K_L4T5 = K_L4T5(1:j);
K_L4T5_ind = K_L4T5_ind(1:j);

simplify(L4T5 - D_L4T5*K_L4T5)
%% Link 4, 6
% dq2:dq7 = 0, ddq1:ddq7 = 0 
L4T6 = subs(GGamma(6), {dq3, dq1 ,dq5 ,dq2, dq7, ddq3, ddq1 ,ddq5 ,ddq2, ddq7}, {0, 0, 0, 0, 0, 0, 0, 0, 0, 0});
DD_L4T6 = subs(DD(6,:), {dq3, dq1 ,dq5 ,dq2, dq7, ddq3, ddq1 ,ddq5 ,ddq2, ddq7}, {0, 0, 0, 0, 0, 0, 0, 0, 0, 0});

syms abalakabala real
D_L4T6 = abalakabala*zeros(1,size(DD,2));
K_L4T6 = abalakabala*zeros(length(KKR),1);
K_L4T6_ind = zeros(length(KKR),1);

j = 0;
for i=1:size(DD,2)
    if(~isequaln(DD_L4T6(1,i),0) && ~isequaln(KKR(i),0))
        j = j + 1;
        D_L4T6(j) = DD_L4T6(1,i);
        K_L4T6(j) = KKR(i);
        K_L4T6_ind(j) = i;
    end
end

D_L4T6 = D_L4T6(1:j);
K_L4T6 = K_L4T6(1:j);
K_L4T6_ind = K_L4T6_ind(1:j);

simplify(L4T6 - D_L4T6*K_L4T6)
%% Link 4, 7
% dq2:dq7 = 0, ddq1:ddq7 = 0 
L4T7 = subs(GGamma(7), {dq3, dq1 ,dq5 ,dq6, dq2, ddq3, ddq1 ,ddq5 ,ddq6, ddq2}, {0, 0, 0, 0, 0, 0, 0, 0, 0, 0});
DD_L4T7 = subs(DD(7,:), {dq3, dq1 ,dq5 ,dq6, dq2, ddq3, ddq1 ,ddq5 ,ddq6, ddq2}, {0, 0, 0, 0, 0, 0, 0, 0, 0, 0});

syms abalakabala real
D_L4T7 = abalakabala*zeros(1,size(DD,2));
K_L4T7 = abalakabala*zeros(length(KKR),1);
K_L4T7_ind = zeros(length(KKR),1);

j = 0;
for i=1:size(DD,2)
    if(~isequaln(DD_L4T7(1,i),0) && ~isequaln(KKR(i),0))
        j = j + 1;
        D_L4T7(j) = DD_L4T7(1,i);
        K_L4T7(j) = KKR(i);
        K_L4T7_ind(j) = i;
    end
end

D_L4T7 = D_L4T7(1:j);
K_L4T7 = K_L4T7(1:j);
K_L4T7_ind = K_L4T7_ind(1:j);

simplify(L4T7 - D_L4T7*K_L4T7)
%% Link 5, 6
% dq2:dq7 = 0, ddq1:ddq7 = 0 
L5T6 = subs(GGamma(6), {dq3, dq4 ,dq1 ,dq2, dq7, ddq3, ddq4 ,ddq1 ,ddq2, ddq7}, {0, 0, 0, 0, 0, 0, 0, 0, 0, 0});
DD_L5T6 = subs(DD(6,:), {dq3, dq4 ,dq1 ,dq2, dq7, ddq3, ddq4 ,ddq1 ,ddq2, ddq7}, {0, 0, 0, 0, 0, 0, 0, 0, 0, 0});

syms abalakabala real
D_L5T6 = abalakabala*zeros(1,size(DD,2));
K_L5T6 = abalakabala*zeros(length(KKR),1);
K_L5T6_ind = zeros(length(KKR),1);

j = 0;
for i=1:size(DD,2)
    if(~isequaln(DD_L5T6(1,i),0) && ~isequaln(KKR(i),0))
        j = j + 1;
        D_L5T6(j) = DD_L5T6(1,i);
        K_L5T6(j) = KKR(i);
        K_L5T6_ind(j) = i;
    end
end

D_L5T6 = D_L5T6(1:j);
K_L5T6 = K_L5T6(1:j);
K_L5T6_ind = K_L5T6_ind(1:j);

simplify(L5T6 - D_L5T6*K_L5T6)
%% Link 5, 7
% dq2:dq7 = 0, ddq1:ddq7 = 0 
L5T7 = subs(GGamma(7), {dq3, dq4 ,dq1 ,dq6, dq2, ddq3, ddq4 ,ddq1 ,ddq6, ddq2}, {0, 0, 0, 0, 0, 0, 0, 0, 0, 0});
DD_L5T7 = subs(DD(7,:), {dq3, dq4 ,dq1 ,dq6, dq2, ddq3, ddq4 ,ddq1 ,ddq6, ddq2}, {0, 0, 0, 0, 0, 0, 0, 0, 0, 0});

syms abalakabala real
D_L5T7 = abalakabala*zeros(1,size(DD,2));
K_L5T7 = abalakabala*zeros(length(KKR),1);
K_L5T7_ind = zeros(length(KKR),1);

j = 0;
for i=1:size(DD,2)
    if(~isequaln(DD_L5T7(1,i),0) && ~isequaln(KKR(i),0))
        j = j + 1;
        D_L5T7(j) = DD_L5T7(1,i);
        K_L5T7(j) = KKR(i);
        K_L5T7_ind(j) = i;
    end
end

D_L5T7 = D_L5T7(1:j);
K_L5T7 = K_L5T7(1:j);
K_L5T7_ind = K_L5T7_ind(1:j);

simplify(L5T7 - D_L5T7*K_L5T7)
%% Link 6, 7
% dq2:dq7 = 0, ddq1:ddq7 = 0 
L6T7 = subs(GGamma(7), {dq3, dq4 ,dq5 ,dq1, dq2, ddq3, ddq4 ,ddq5 ,ddq1, ddq2}, {0, 0, 0, 0, 0, 0, 0, 0, 0, 0});
DD_L6T7 = subs(DD(7,:), {dq3, dq4 ,dq5 ,dq1, dq2, ddq3, ddq4 ,ddq5 ,ddq1, ddq2}, {0, 0, 0, 0, 0, 0, 0, 0, 0, 0});

syms abalakabala real
D_L6T7 = abalakabala*zeros(1,size(DD,2));
K_L6T7 = abalakabala*zeros(length(KKR),1);
K_L6T7_ind = zeros(length(KKR),1);

j = 0;
for i=1:size(DD,2)
    if(~isequaln(DD_L6T7(1,i),0) && ~isequaln(KKR(i),0))
        j = j + 1;
        D_L6T7(j) = DD_L6T7(1,i);
        K_L6T7(j) = KKR(i);
        K_L6T7_ind(j) = i;
    end
end

D_L6T7 = D_L6T7(1:j);
K_L6T7 = K_L6T7(1:j);
K_L6T7_ind = K_L6T7_ind(1:j);

simplify(L6T7 - D_L6T7*K_L6T7)