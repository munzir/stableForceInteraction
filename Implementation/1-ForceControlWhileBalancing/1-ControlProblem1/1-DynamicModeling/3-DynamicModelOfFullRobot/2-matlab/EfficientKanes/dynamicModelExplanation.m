% Generate the full efficient model automatically (incomplete)

addpath('../Kanes');

clear all
f=getKrangFrames(18);
dq = dqVec(f);
ddq = ddqVec(f);
fout = fopen('dynamicModelAuto2.m','w');

fprintf(fout, 'syms mw YYw ZZw ddx ddpsi R L g x psii q_imu q_w q_torso q_1l q_2l q_3l q_4l q_5l q_6l q_7l real\n');
fprintf(fout, 'syms q_1r q_2r q_3r q_4r q_5r q_6r q_7r L1 L2 L3 L4 L5 L6 L7 L8 L9 real\n');
fprintf(fout, 'syms dx dpsi dq_imu dq_w dq_torso dq_1l dq_2l dq_3l dq_4l dq_5l dq_6l dq_7l real\n');
fprintf(fout, 'syms dq_1r dq_2r dq_3r dq_4r dq_5r dq_6r dq_7r L1 L2 L3 L4 L5 L6 L7 L8 L9 real\n');
fprintf(fout, 'syms ddx ddpsi ddq_imu ddq_w ddq_torso ddq_1l ddq_2l ddq_3l ddq_4l ddq_5l ddq_6l ddq_7l real\n');
fprintf(fout, 'syms ddq_1r ddq_2r ddq_3r ddq_4r ddq_5r ddq_6r ddq_7r real\n');
fprintf(fout, 'syms m_1 MX_1 MY_1 MZ_1 XX_1 XY_1 XZ_1 YY_1 YZ_1 ZZ_1 real\n');
fprintf(fout, 'syms m_2 MX_2 MY_2 MZ_2 XX_2 XY_2 XZ_2 YY_2 YZ_2 ZZ_2 real\n');
fprintf(fout, 'syms m_3 MX_3 MY_3 MZ_3 XX_3 XY_3 XZ_3 YY_3 YZ_3 ZZ_3 real\n');
fprintf(fout, 'syms m_4l MX_4l MY_4l MZ_4l XX_4l XY_4l XZ_4l YY_4l YZ_4l ZZ_4l real\n');
fprintf(fout, 'syms m_5l MX_5l MY_5l MZ_5l XX_5l XY_5l XZ_5l YY_5l YZ_5l ZZ_5l real\n');
fprintf(fout, 'syms m_6l MX_6l MY_6l MZ_6l XX_6l XY_6l XZ_6l YY_6l YZ_6l ZZ_6l real\n');
fprintf(fout, 'syms m_7l MX_7l MY_7l MZ_7l XX_7l XY_7l XZ_7l YY_7l YZ_7l ZZ_7l real\n');
fprintf(fout, 'syms m_8l MX_8l MY_8l MZ_8l XX_8l XY_8l XZ_8l YY_8l YZ_8l ZZ_8l real\n');
fprintf(fout, 'syms m_9l MX_9l MY_9l MZ_9l XX_9l XY_9l XZ_9l YY_9l YZ_9l ZZ_9l real\n');
fprintf(fout, 'syms m_10l MX_10l MY_10l MZ_10l XX_10l XY_10l XZ_10l YY_10l YZ_10l ZZ_10l real\n');
fprintf(fout, 'syms m_4r MX_4r MY_4r MZ_4r XX_4r XY_4r XZ_4r YY_4r YZ_4r ZZ_4r real\n');
fprintf(fout, 'syms m_5r MX_5r MY_5r MZ_5r XX_5r XY_5r XZ_5r YY_5r YZ_5r ZZ_5r real\n');
fprintf(fout, 'syms m_6r MX_6r MY_6r MZ_6r XX_6r XY_6r XZ_6r YY_6r YZ_6r ZZ_6r real\n');
fprintf(fout, 'syms m_7r MX_7r MY_7r MZ_7r XX_7r XY_7r XZ_7r YY_7r YZ_7r ZZ_7r real\n');
fprintf(fout, 'syms m_8r MX_8r MY_8r MZ_8r XX_8r XY_8r XZ_8r YY_8r YZ_8r ZZ_8r real\n');
fprintf(fout, 'syms m_9r MX_9r MY_9r MZ_9r XX_9r XY_9r XZ_9r YY_9r YZ_9r ZZ_9r real\n');
fprintf(fout, 'syms m_10r MX_10r MY_10r MZ_10r XX_10r XY_10r XZ_10r YY_10r YZ_10r ZZ_10r real\n');

syms g mw YYw ZZw ddx ddpsi R L real
keys = {'1', '2', '3', '4l', '5l', '6l', '7l', '8l', '9l', '10l', ...
    '4r', '5r', '6r', '7r', '8r', '9r', '10r'};
z = ZGen('K', fout);
Z = ZGen('D', fout);

f0 = f('0');
f0.wi = f0.angVel; 
f0.we = f0.angVel;
f0.vi = f0.linVel;
f0.ve = f0.linVel;
f0.alpha = f0.angAcc;
f0.acc = f0.linAcc;
f0.g = [0; 0; -g];
f('0') = f0;

for i=1:length(keys)
    this = keys{i};
    prev = f(this).a;
    
    % >>>>>> Angular Velocities
    disp(['w_' this]);
    fprintf(fout, '%s \\nonumber \\\\ \n', ['% \bar\omega_{' this '} &= ' ...
        '{}^{' this '}A_{' prev '} \bar\omega_{' prev '} + '...
        '\dot{q}_{' this '} \bar{e}_{' this '}']);
    
    % Implicit form
    w = Rot(f, prev, this) * f(prev).wi + f(this).e*f(this).dq;
    fprintf(fout, '%s', ['% \bar\omega_{' this '} &= ']); mat2texMat(w, fout); fprintf(fout, ' \\nonumber \\\\ \n');
    wi = sym(zeros(3,1));
    for j=1:3
        wi(j) = z.create(w(j), this);
    end
    fprintf(fout, '%s', ['% \bar\omega_{' this '} &= ']); mat2texMat(wi, fout); fprintf(fout, ' \\nonumber \\\\ \n');
    
    
    % Explicit form
    w = Rot(f, prev, this) * f(prev).we + f(this).e*f(this).dq;
    fprintf(fout, '%s', ['% \bar\omega_{' this '} &= ']); mat2texMat(w, fout); fprintf(fout, ' \\nonumber \\\\ \n');
    we = sym(zeros(3,1));
    for j=1:3
        for k=1:length(dq)
            dw = diff(w(j), dq(k));
            we(j) = we(j) + z.create(dw, this)*dq(k);
        end
    end
    fprintf(fout, '%s', ['% \bar\omega_{' this '} &= ']); mat2texMat(we, fout); fprintf(fout, ' \\nonumber \\\\ \n');
    
    % >>>>>>> Linear Velocities
    disp(['v_' this]);
    fprintf(fout, '%s \\nonumber \\\\ \n', ['% \bar{v}_{' this '} &= ' ...
        '{}^{' this '}A_{' prev '} \left(\bar{v}_{' prev '} + '...
        '\bar\omega_{' prev '} \times \bar{P}_{' this '}\right)']);
    
    % Implicit form
    v = Rot(f, prev, this) * (f(prev).vi + cross(f(prev).wi, f(this).P));
    fprintf(fout, '%s', ['% \bar{v}_{' this '} &= ']); mat2texMat(v, fout); fprintf(fout, ' \\nonumber \\\\ \n');
    vi = sym(zeros(3,1));
    for j=1:3
        vi(j) = z.create(v(j), this);
    end
    fprintf(fout, '%s', ['% \bar{v}_{' this '} &= ']); mat2texMat(vi, fout); fprintf(fout, ' \\nonumber \\\\ \n');
    
    % Explicit form
    v = Rot(f, prev, this) * (f(prev).ve + cross(f(prev).we, f(this).P));
    fprintf(fout, '%s', ['% \bar{v}_{' this '} &= ']); mat2texMat(v, fout); fprintf(fout, ' \\nonumber \\\\ \n');
    ve = sym(zeros(3,1));
    for j=1:3
        for k=1:length(dq)
            dv = diff(v(j), dq(k));
            ve(j) = ve(j) + z.create(dv, this)*dq(k);
        end
    end   
    fprintf(fout, '%s', ['% \bar{v}_{' this '} &= ']); mat2texMat(ve, fout); fprintf(fout, ' \\nonumber \\\\ \n');
    
    % >>>>>>> Angular Accelerations
    disp(['alpha_' this]);
    fprintf(fout, '%s \\nonumber \\\\ \n', ['% \bar\alpha_{' this '} &= ' ...
        '{}^{' this '}A_{' prev '} \bar\alpha_{' prev '} + '...
        '\ddot{q}_{' this '} \bar{e}_{' this '} + '...
        '\dot{q}_{' this '} \left(\bar\omega_{' this '} \times \bar{e}_{' this '}\right)']);
    
    alphaTmp = Rot(f, prev, this)*f(prev).alpha + f(this).ddq*f(this).e ...
        + f(this).dq*cross(wi, f(this).e);
    alpha = sym(zeros(3,1));
    fprintf(fout, '%s', ['% \bar\alpha_{' this '} &= ']); mat2texMat(alphaTmp, fout); fprintf(fout, ' \\nonumber \\\\ \n');
    for j=1:3
        alphaRem = alphaTmp(j);
        for k=1:length(ddq)
            dalpha = diff(alphaTmp(j), ddq(k));
            alpha(j) = alpha(j) + z.create(dalpha, this)*ddq(k);
            alphaRem = simplify(alphaRem - dalpha*ddq(k));
        end
        alpha(j) = alpha(j) + z.create(alphaRem, this);
    end   
    fprintf(fout, '%s', ['% \bar\alpha_{' this '} &= ']); mat2texMat(alpha, fout); fprintf(fout, ' \\nonumber \\\\ \n');
    
    % >>>>>>> Linear Accelerations
    disp(['acc_' this]);
    fprintf(fout, '%s \\nonumber \\\\ \n', ['% \bar{a}_{' this '} &= ' ...
        '{}^{' this '}A_{' prev '} \left(\bar{a}_{' prev '} + '...
        '\bar\alpha_{' prev '} \times \bar{P}_{' this '} + ' ...
        '\bar\omega_{' prev '} \times \left(\bar\omega_{' prev '} \times \bar{P}_{' this '}\right)\right)']);
    
    accTmp = Rot(f, prev, this) * (f(prev).acc + cross(f(prev).alpha, f(this).P) ... 
        + cross(f(prev).wi, cross(f(prev).wi, f(this).P)));     
    fprintf(fout, '%s', ['% \bar\alpha_{' this '} &= ']); mat2texMat(accTmp, fout); fprintf(fout, ' \\nonumber \\\\ \n');
    acc = sym(zeros(3,1));
    for j=1:3
        accRem = accTmp(j);
        for k=1:length(ddq)
            dacc = diff(accTmp(j), ddq(k));
            acc(j) = acc(j) + z.create(dacc, this)*ddq(k);
            accRem = simplify(accRem - dacc*ddq(k));
        end
        acc(j) = acc(j) + z.create(accRem, this);
    end  
    fprintf(fout, '%s', ['% \bar{a}_{' this '} &= ']); mat2texMat(acc, fout); fprintf(fout, ' \\nonumber \\\\ \n');
    
    % >>>>>>> gVector
    disp(['g_' this]);
    fprintf(fout, '%s \\nonumber \\\\ \n', ['% \bar{g}_{' this '} &= ' ...
        '{}^{' this '}A_{' prev '} \bar{g}_{' prev '}']);
    
    gTmp = Rot(f, prev, this)*f(prev).g;
    fprintf(fout, '%s', ['% \bar{g}_{' this '} &= ']); mat2texMat(gTmp, fout); fprintf(fout, ' \\nonumber \\\\ \n');
    gVec = sym(zeros(3,1));
    for j=1:3
        gVec(j) = z.create(diff(gTmp(j),g), this)*g;
    end
    fprintf(fout, '%s', ['% \bar{g}_{' this '} &= ']); mat2texMat(gVec, fout); fprintf(fout, ' \\nonumber \\\\ \n');
    
    % >>>>>>>> mSxg
    disp(['mSxg_' this]);
    fprintf(fout, '%s \\nonumber \\\\ \n', ['% m_{' this '}\bar{S}_{' this '}^{\times}\bar{g}_{' this '} &= ' ...
        '\mathbf{MS}_{' this '} \times \bar{g}_{' this '}']);

    mS = mCOM(f, this);
    mSxgTmp = cross(mS, gVec);
    fprintf(fout, '%s', ['% m_{' this '}\bar{S}_{' this '}^{\times}\bar{g}_{' this '} &= ']); mat2texMat(mSxgTmp, fout); fprintf(fout, ' \\nonumber \\\\ \n');
    mSxg = sym(zeros(3,1));
    for j=1:3
        mSxg(j) = Z.create(diff(mSxgTmp(j),g), this, 0)*g;
    end
    fprintf(fout, '%s', ['% m_{' this '}\bar{S}_{' this '}^{\times}\bar{g}_{' this '} &= ']); mat2texMat(mSxg, fout); fprintf(fout, ' \\nonumber \\\\ \n');
    
    % >>>>>>>> maG
    disp(['maG_' this]);
    fprintf(fout, '%s \\nonumber \\\\ \n', ['% m_{' this '}\bar{a}_{G(' this ')} &= ' ...
        'm_{' this '}\bar{a}_{' this '} + '...
        '\bar\alpha_{' this '} \times \mathbf{MS}_{' this '} + ' ...
        '\bar\omega_{' this '} \times \left(\bar\omega_{' this '} \times \mathbf{MS}_{' this '}\right)']);
    m = mass(f, this);
    maGTmp = m*acc + cross(alpha,mS) + cross(wi,cross(wi,mS));
    fprintf(fout, '%s', ['% m_{' this '}\bar{a}_{G(' this ')} &= ']); mat2texMat(maGTmp, fout); fprintf(fout, ' \\nonumber \\\\ \n');
    maG = sym(zeros(3,1));
    for j=1:3
        maGRem = maGTmp(j);
        for k=1:length(ddq)
            dmaG = diff(maGTmp(j), ddq(k));
            maG(j) = maG(j) + Z.create(dmaG, this, 0)*ddq(k);
            maGRem = simplify(maGRem - dmaG*ddq(k));
        end
        maG(j) = maG(j) + Z.create(maGRem, this, 0);
    end 
    fprintf(fout, '%s', ['% m_{' this '}\bar{a}_{G(' this ')} &= ']); mat2texMat(maG, fout); fprintf(fout, ' \\nonumber \\\\ \n');
    
    % >>>>>>>>>>> dHnew
    disp(['dHnew_' this]);
    fprintf(fout, '%s \\nonumber \\\\ \n', ['% \dot{\bar{H}}_{' this '} &= ' ...
        '\mathbf{MS}_{' this '} \times \bar{a}_{' this '} + ' ...
        'J_{' this '}\bar{\alpha}_{' this '} + '...
        '\bar\omega_{' this '} \times J_{' this '}\bar{\omega}_{' this '}']);
    
    J = inertiaMat(f, this);
    dHnewTmp = cross(mS, acc) + J*alpha + cross(wi,J*wi);
    dHnew = sym(zeros(3,1));
    fprintf(fout, '%s', ['% \dot{\bar{H}}_{' this '} &= ']); mat2texMat(dHnewTmp, fout); fprintf(fout, ' \\nonumber \\\\ \n');
    for j=1:3
        dHnewRem = dHnewTmp(j);
        for k=1:length(ddq)
            ddHnew = diff(dHnewTmp(j), ddq(k));
            dHnew(j) = dHnew(j) + Z.create(ddHnew, this, 0)*ddq(k);
            dHnewRem = simplify(dHnewRem - ddHnew*ddq(k));
        end
        dHnew(j) = dHnew(j) + Z.create(dHnewRem, this, 0);
    end     
    fprintf(fout, '%s', ['% \dot{\bar{H}}_{' this '} &= ']); mat2texMat(maG, fout); fprintf(fout, ' \\nonumber \\\\ \n');
   
    frame = f(this);
    frame.wi = wi;
    frame.we = we;
    frame.vi = vi;
    frame.ve = ve;
    frame.alpha = alpha;
    frame.acc = acc;
    frame.g = gVec;
    frame.mSxg = mSxg;
    frame.maG = maG;
    frame.dHnew = dHnew;
    f(this) = frame;
end

% Left-Hand Side
syms ddx ddpsi ddq_imu ddq_w ddq_torso ddq_1l ddq_2l ddq_3l ddq_4l ddq_5l ddq_6l ddq_7l real
syms ddq_1r ddq_2r ddq_3r ddq_4r ddq_5r ddq_6r ddq_7r real

zL = ZGen('X', fout);
syms g mw YYw ZZw ddx ddpsi R L real
LHS = sym(zeros(19,1));
LHS(1) = (2*mw + 2*YYw/R^2)*ddx;
LHS(2) = (mw*L^2/2 + YYw*L^2/(2*R^2) + 2*ZZw)*ddpsi;

for i=1:length(dq)
    fprintf(fout, '%s \\nonumber \\\\ \n', ['% LHS_{' char(dq(i)) '} &= '...
        '\sum_k \left(m_k\bar{a}_{Gk}^T\frac{\partial \bar{v}_k}{\partial ' char(dq(i)) '} + '...
        '\dot\bar{H}_{Gk}^T\frac{\partial \bar{\omega}_k}{\partial ' char(dq(i)) '}\right)']);
    LHSTmp = LHS(i);
    fprintf(fout, '%s \\nonumber \\\\ \n', ['% \dot{\bar{H}}_{' this '} &= \\']);
    plus = ' ';
    for j=1:length(keys)
        b = keys{j};
        LHSTerm = f(b).maG'*diff(f(b).ve, dq(i)) + f(b).dHnew'*diff(f(b).we, dq(i));
        LHSTmp = LHSTmp + LHSTerm;
        if(~isequal(LHSTerm,0)
          fprintf(fout, '%s \\nonumber \\\\ \n', ...
            ['% &' plus char(collect(LHSTerm,[ddx, ddpsi, ddq_imu, ddq_w, ddq_torso,...
            ddq_1l, ddq_2l, ddq_3l, ddq_4l, ddq_5l, ddq_6l, ddq_7l, ...
            ddq_1r, ddq_2r, ddq_3r, ddq_4r, ddq_5r, ddq_6r, ddq_7r]))]);
          plus = '+';
        end
    end
    
    LHSRem = LHSTmp;
    for k=1:length(ddq)
        disp(['LHS(' num2str(i) ') ' char(ddq(i))]);
        dLHS = diff(LHSTmp, ddq(k));
        LHS(i) = LHS(i) + zL.create(dLHS, char(dq(i)), 0)*ddq(k);
        LHSRem = simplify(LHSRem - dLHS*ddq(k));
    end
    LHS(i) = LHS(i) + zL.create(LHSRem, char(dq(i)), 0);
    fprintf(fout, '%s \\nonumber \\\\ \n', ...
            ['% LHS_{' char(dq(i)) '} &= ' char(collect(LHSTerm,[ddx, ddpsi, ddq_imu, ddq_w, ddq_torso,...
            ddq_1l, ddq_2l, ddq_3l, ddq_4l, ddq_5l, ddq_6l, ddq_7l, ...
            ddq_1r, ddq_2r, ddq_3r, ddq_4r, ddq_5r, ddq_6r, ddq_7r]))]);
end

%% RHS EEff

syms Flx Fly Flz Frx Fry Frz Tlx Tly Tlz Trx Try Trz real
Fl = [Flx Fly Flz]'; Tl = [Tlx Tly Tlz]'; % expressed in frame 10l
Fr = [Frx Fry Frz]'; Tr = [Trx Try Trz]'; % expressed in frame 10r

eComp = [Flx Fly Flz Tlx Tly Tlz Frx Fry Frz Tlx Tly Tlz];
EE = sym(zeros(19,1));
for i=1:length(dq)
    fprintf(fout, '%s \\nonumber \\\\ \n', ['% E_{' char(dq(i)) '} &= '...
        '\bar{F}_{el}^T\frac{\partial \bar{v}_{10l}}{\partial ' char(dq(i)) '} + '...
        '\bar{\tau}_{el}^T\frac{\partial \bar{\omega}_{10l}}{\partial ' char(dq(i)) '} + ' ...
        '\bar{F}_{er}^T\frac{\partial \bar{v}_{10r}}{\partial ' char(dq(i)) '} + '...
        '\bar{\tau}_{er}^T\frac{\partial \bar{\omega}_{10r}}{\partial ' char(dq(i)) '} + ' ]);
   
    disp(['EE(' num2str(i) ')']);
    ETmp = Fl'*diff(f('10l').ve, dq(i)) + Tl'*diff(f('10l').we, dq(i)) ...
        + Fr'*diff(f('10r').ve, dq(i)) + Tr'*diff(f('10r').we, dq(i));
    fprintf(fout, '%s \\nonumber \\\\ \n', ['% E_{' char(dq(i)) '} &= ' char(collect(ETmp, ...
        [Flx Fly Flz Tlx Tly Tlz Frx Fry Frz Tlx Tly Tlz]))]); 
    for j=1:length(eComp)
        side = sel(char(eComp(j)),1,2); % right or left selection
        EE(i) = EE(i) + z.create(diff(ETmp, eComp(j)), side)*eComp(j);
    end
    fprintf(fout, '%s \\nonumber \\\\ \n', ['% E_{' char(dq(i)) '} &= ' char(collect(EE(i), ...
        [Flx Fly Flz Tlx Tly Tlz Frx Fry Frz Tlx Tly Tlz]))]); 
end

%% RHS Gravitational
zG = ZGen('G', fout);
G = sym(zeros(19,1));
for i=1:length(dq)
    fprintf(fout, '%s \\nonumber \\\\ \n', ['% G_{' char(dq(i)) '} &= '...
        '\sum_k \left(m_k\bar{g}_{k}^T\frac{\partial \bar{v}_k}{\partial ' char(dq(i)) '} + '...
        'm_k\bar{S}_{k}^{\times}\bar{g}_{k}^T\frac{\partial \bar{\omega}_k}{\partial ' char(dq(i)) '}\right)']);
    
    disp(['G(' num2str(i) ')']);
    GTmp = sym(0);
    fprintf(fout, '%s \\nonumber \\\\ \n', ['% G_{' char(dq(i)) '} &= ' char(collect(G(i),g))]); 
    plus = ' ';
    for j=1:length(keys)
        b = keys{j};
        GTerm = mass(f, b)*f(b).g'*diff(f(b).ve, dq(i)) + f(b).mSxg'*diff(f(b).we, dq(i));
        GTmp = GTmp + GTerm;
        if(~isequal(GTerm,0))
            fprintf(fout, '%s \\nonumber \\\\ \n', ...
                ['% &' plus char(collect(GTerm,g))]);
            plus = '+';
        end
    end
    
    G(i) = zG.create(diff(GTmp, g), char(dq(i)), 0)*g;
    fprintf(fout, '%s \\nonumber \\\\ \n', ['% G_{' char(dq(i)) '} &= ' char(collect(G(i),g))]); 
end
