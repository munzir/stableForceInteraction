%% Link 1
% dq2:dq7 = 0, ddq1:ddq7 = 0 
T4L1 = subs(GGamma(1), {dq2, dq3, dq4 ,dq5 ,dq6, dq7, ddq2, ddq1, ddq3, ddq4, ...
    ddq5, ddq6, ddq7}, {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0});
DD_T4L1 = subs(DD(1,:), {dq2, dq3, dq4 ,dq5 ,dq6, dq7, ddq1, ddq2, ddq3, ddq4, ...
    ddq5, ddq6, ddq7}, {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0});

syms abalakabala real
D_T4L1 = abalakabala*zeros(1,size(DD,2));
K_T4L1 = abalakabala*zeros(length(KKR),1);
K_T4L1_ind = zeros(length(KKR),1);

j = 0;
for i=1:size(DD,2)
    if(~isequaln(DD_T4L1(1,i),0) && ~isequaln(KKR(i),0))
        j = j + 1;
        D_T4L1(j) = DD_T4L1(1,i);
        K_T4L1(j) = KKR(i);
        K_T4L1_ind(j) = i;
    end
end

D_T4L1 = D_T4L1(1:j);
K_T4L1 = K_T4L1(1:j);
K_T4L1_ind = K_T4L1_ind(1:j);

simplify(T4L1 - D_T4L1*K_T4L1)
%% Link 2
% dq2:dq7 = 0, ddq1:ddq7 = 0 
T4L2 = subs(GGamma(2), {dq1, dq3, dq4 ,dq5 ,dq6, dq7, ddq1, ddq2, ddq3, ddq4, ...
    ddq5, ddq6, ddq7}, {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0});
DD_T4L2 = subs(DD(2,:), {dq1, dq3, dq4 ,dq5 ,dq6, dq7, ddq1, ddq2, ddq3, ddq4, ...
    ddq5, ddq6, ddq7}, {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0});

syms abalakabala real
D_T4L2 = abalakabala*zeros(1,size(DD,2));
K_T4L2 = abalakabala*zeros(length(KKR),1);
K_T4L2_ind = zeros(length(KKR),1);

j = 0;
for i=1:size(DD,2)
    if(~isequaln(DD_T4L2(1,i),0) && ~isequaln(KKR(i),0))
        j = j + 1;
        D_T4L2(j) = DD_T4L2(1,i);
        K_T4L2(j) = KKR(i);
        K_T4L2_ind(j) = i;
    end
end

D_T4L2 = D_T4L2(1:j);
K_T4L2 = K_T4L2(1:j);
K_T4L2_ind = K_T4L2_ind(1:j);

simplify(T4L2 - D_T4L2*K_T4L2)
%% Link 3
% dq2:dq7 = 0, ddq1:ddq7 = 0 
T4L3 = subs(GGamma(3), {dq2, dq1, dq4 ,dq5 ,dq6, dq7, ddq2, ddq1, ddq3, ddq4, ...
    ddq5, ddq6, ddq7}, {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0});
DD_T4L3 = subs(DD(3,:), {dq2, dq1, dq4 ,dq5 ,dq6, dq7, ddq1, ddq2, ddq3, ddq4, ...
    ddq5, ddq6, ddq7}, {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0});

syms abalakabala real
D_T4L3 = abalakabala*zeros(1,size(DD,2));
K_T4L3 = abalakabala*zeros(length(KKR),1);
K_T4L3_ind = zeros(length(KKR),1);

j = 0;
for i=1:size(DD,2)
    if(~isequaln(DD_T4L3(1,i),0) && ~isequaln(KKR(i),0))
        j = j + 1;
        D_T4L3(j) = DD_T4L3(1,i);
        K_T4L3(j) = KKR(i);
        K_T4L3_ind(j) = i;
    end
end

D_T4L3 = D_T4L3(1:j);
K_T4L3 = K_T4L3(1:j);
K_T4L3_ind = K_T4L3_ind(1:j);

simplify(T4L3 - D_T4L3*K_T4L3)
%% Link 4
% dq2:dq7 = 0, ddq1:ddq7 = 0 
T4L4 = subs(GGamma(4), {dq2, dq3, dq1 ,dq5 ,dq6, dq7, ddq2, ddq1, ddq3, ddq4, ...
    ddq5, ddq6, ddq7}, {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0});
DD_T4L4 = subs(DD(4,:), {dq2, dq3, dq1 ,dq5 ,dq6, dq7, ddq1, ddq2, ddq3, ddq4, ...
    ddq5, ddq6, ddq7}, {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0});

syms abalakabala real
D_T4L4 = abalakabala*zeros(1,size(DD,2));
K_T4L4 = abalakabala*zeros(length(KKR),1);
K_T4L4_ind = zeros(length(KKR),1);

j = 0;
for i=1:size(DD,2)
    if(~isequaln(DD_T4L4(1,i),0) && ~isequaln(KKR(i),0))
        j = j + 1;
        D_T4L4(j) = DD_T4L4(1,i);
        K_T4L4(j) = KKR(i);
        K_T4L4_ind(j) = i;
    end
end

D_T4L4 = D_T4L4(1:j);
K_T4L4 = K_T4L4(1:j);
K_T4L4_ind = K_T4L4_ind(1:j);

simplify(T4L4 - D_T4L4*K_T4L4)
%% Link 5
% dq2:dq7 = 0, ddq1:ddq7 = 0 
T4L5 = subs(GGamma(5), {dq2, dq3, dq4 ,dq1 ,dq6, dq7, ddq2, ddq1, ddq3, ddq4, ...
    ddq5, ddq6, ddq7}, {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0});
DD_T4L5 = subs(DD(5,:), {dq2, dq3, dq4 ,dq1 ,dq6, dq7, ddq1, ddq2, ddq3, ddq4, ...
    ddq5, ddq6, ddq7}, {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0});

syms abalakabala real
D_T4L5 = abalakabala*zeros(1,size(DD,2));
K_T4L5 = abalakabala*zeros(length(KKR),1);
K_T4L5_ind = zeros(length(KKR),1);

j = 0;
for i=1:size(DD,2)
    if(~isequaln(DD_T4L5(1,i),0) && ~isequaln(KKR(i),0))
        j = j + 1;
        D_T4L5(j) = DD_T4L5(1,i);
        K_T4L5(j) = KKR(i);
        K_T4L5_ind(j) = i;
    end
end

D_T4L5 = D_T4L5(1:j);
K_T4L5 = K_T4L5(1:j);
K_T4L5_ind = K_T4L5_ind(1:j);

simplify(T4L5 - D_T4L5*K_T4L5)
%% Link 6
% dq2:dq7 = 0, ddq1:ddq7 = 0 
T4L6 = subs(GGamma(6), {dq2, dq3, dq4 ,dq5 ,dq1, dq7, ddq2, ddq1, ddq3, ddq4, ...
    ddq5, ddq6, ddq7}, {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0});
DD_T4L6 = subs(DD(6,:), {dq2, dq3, dq4 ,dq5 ,dq1, dq7, ddq1, ddq2, ddq3, ddq4, ...
    ddq5, ddq6, ddq7}, {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0});

syms abalakabala real
D_T4L6 = abalakabala*zeros(1,size(DD,2));
K_T4L6 = abalakabala*zeros(length(KKR),1);
K_T4L6_ind = zeros(length(KKR),1);

j = 0;
for i=1:size(DD,2)
    if(~isequaln(DD_T4L6(1,i),0) && ~isequaln(KKR(i),0))
        j = j + 1;
        D_T4L6(j) = DD_T4L6(1,i);
        K_T4L6(j) = KKR(i);
        K_T4L6_ind(j) = i;
    end
end

D_T4L6 = D_T4L6(1:j);
K_T4L6 = K_T4L6(1:j);
K_T4L6_ind = K_T4L6_ind(1:j);

simplify(T4L6 - D_T4L6*K_T4L6)
%% Link 7
% dq2:dq7 = 0, ddq1:ddq7 = 0 
T4L7 = subs(GGamma(7), {dq2, dq3, dq4 ,dq5 ,dq6, dq1, ddq2, ddq1, ddq3, ddq4, ...
    ddq5, ddq6, ddq7}, {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0});
DD_T4L7 = subs(DD(7,:), {dq2, dq3, dq4 ,dq5 ,dq6, dq1, ddq1, ddq2, ddq3, ddq4, ...
    ddq5, ddq6, ddq7}, {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0});

syms abalakabala real
D_T4L7 = abalakabala*zeros(1,size(DD,2));
K_T4L7 = abalakabala*zeros(length(KKR),1);
K_T4L7_ind = zeros(length(KKR),1);

j = 0;
for i=1:size(DD,2)
    if(~isequaln(DD_T4L7(1,i),0) && ~isequaln(KKR(i),0))
        j = j + 1;
        D_T4L7(j) = DD_T4L7(1,i);
        K_T4L7(j) = KKR(i);
        K_T4L7_ind(j) = i;
    end
end

D_T4L7 = D_T4L7(1:j);
K_T4L7 = K_T4L7(1:j);
K_T4L7_ind = K_T4L7_ind(1:j);

simplify(T4L7 - D_T4L7*K_T4L7)