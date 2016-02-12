fstr = {'cos(thetaL)', 'sin(thetaL)', 'cos(thetaR)', 'sin(thetaR)', ...
    'cos(q_imu)', 'sin(q_imu)', 'cos(q_w)', 'sin(q_w)', 'cos(q_torso)', 'sin(q_torso)', ...
    'cos(q_1l)', 'sin(q_1l)', 'cos(q_2l)', 'sin(q_2l)', 'cos(q_3l)', 'sin(q_3l)', 'cos(q_4l)', 'sin(q_4l)', 'cos(q_5l)', 'sin(q_5l)', 'cos(q_6l)', 'sin(q_6l)', 'cos(q_7l)', 'sin(q_7l)', ...
    'cos(q_1r)', 'sin(q_1r)', 'cos(q_2r)', 'sin(q_2r)', 'cos(q_3r)', 'sin(q_3r)', 'cos(q_4r)', 'sin(q_4r)', 'cos(q_5r)', 'sin(q_5r)', 'cos(q_6r)', 'sin(q_6r)', 'cos(q_7r)', 'sin(q_7r)', ...
    '_imu', '_w', '_torso', '_1l', '_2l', '_3l', '_4l', '_5l', '_6l', '_7l', '_8l', '_9l', '_10l', '_1r', '_2r', '_3r', '_4r', '_5r', '_6r', '_7r','_8r', '_9r', '_10r', ...
    'ddx', 'ddpsi', 'ddq', 'dx', 'dpsi', 'dq', 'L1', 'L2', 'L3', 'L4', 'L5', 'L6', 'L7', 'L8', 'L9', ...
    'mw', 'MX', 'MY', 'MZ', 'XX', 'YY', 'ZZ', 'XY', 'XZ', 'YZ', '*'};
rstr = {'c_L', 's_L', 'c_R', 's_R', ...
    'c_{imu}', 's_{imu}', 'c_{w}', 's_{w}', 'c_{torso}', 's_{torso}', ...
    'c_{1l}', 's_{1l}', 'c_{2l}', 's_{2l}', 'c_{3l}', 's_{3l}', 'c_{4l}', 's_{4l}', 'c_{5l}', 's_{5l}', 'c_{6l}', 's_{6l}', 'c_{7l}', 's_{7l}', ...
    'c_{1r}', 's_{1r}', 'c_{2r}', 's_{2r}', 'c_{3r}', 's_{3r}', 'c_{4r}', 's_{4r}', 'c_{5r}', 's_{5r}', 'c_{6r}', 's_{6r}', 'c_{7r}', 's_{7r}', ...
    '_{imu}', '_{w}', '_{torso}', '_{1l}', '_{2l}', '_{3l}', '_{4l}', '_{5l}', '_{6l}', '_{7l}', '_{8r}', '_{9r}', '_{10r}', '_{1r}', '_{2r}', '_{3r}', '_{4r}', '_{5r}', '_{6r}', '_{7r}', '_{8r}', '_{9r}', '_{10r}', ...
    '\ddot{x}', '\ddot{\psi}', '\ddot{q}', '\dot{x}', '\dot{\psi}', '\dot{q}', 'L_1', 'L_2', 'L_3', 'L_4', 'L_5', 'L_6', 'L_7', 'L_8', 'L_9', ...
    'm_w', '\mathbf{MX}', '\mathbf{MY}', '\mathbf{MZ}', '\mathbf{XX}', '\mathbf{YY}', '\mathbf{ZZ}', '\mathbf{XY}', '\mathbf{XZ}', '\mathbf{YZ}', ''};

fin = fopen('dynamicModelAuto2.m','r');
fout = fopen('dynamicModelAuto2.tex','w');
fprintf(fout,'\\begin{multicols}{2}\n');
fprintf(fout,'\\begin{align}\n');
s_in = fgetl(fin);
s_out = [];
zChar = 'KDXG';
while ischar(s_in)
    if(length(s_in)>0 && (sum(s_in(1)==zChar)>0 || s_in(1)=='%'))
        i = 0;
        o = 0;
        termCount = 0;
        comment = s_in(1)=='%';
        while i<length(s_in)
            i = i + 1;
            o = o + 1;
            if(sum(s_in(i)==zChar)>0 && s_in(i+1)<= '9' && s_in(i+1)>='0')
                s_out(o:o+2) = [s_in(i) '_{']; o = o + 3; 
                i = i + 1; 
                while (i<=length(s_in) && ((s_in(i)<= '9' && s_in(i)>='0') || s_in(i)=='l' || s_in(i)=='r'))
                    s_out(o) = s_in(i);
                    i = i + 1;
                    o = o + 1;
                end
                s_out(o) = '}';
                i = i - 1;
            elseif(s_in(i) == ';')
                s_out(o:o+12) = ' \nonumber \\';o=o+12;
            elseif(s_in(i) == '=' && ~comment)
                s_out(o:o+1) = '&='; o=o+1;
            elseif((s_in(i) == '+' || s_in(i) == '-') && ~comment)
                termCount = termCount + 1;
                if(termCount > 5)
                    s_out(o:o+15) = [' \nonumber \\' char(10) '&' s_in(i)]; o=o+15;
                    termCount = 0;
                else
                    s_out(o) = s_in(i);
                end
            elseif(s_in(i) == '%')
                o = o - 1;
            else
                if(s_in(i) == '*') termCount = termCount + 1; end;
                s_out(o) = s_in(i);
            end
        end
        s_out = sprintf('%s\n',s_out);
        for i=1:length(fstr)
            s_out = strrep(s_out, fstr{i}, rstr{i});
        end
        fwrite(fout,s_out);
        s_out = [];
    end
    s_in = fgetl(fin);
end
fprintf(fout,'\\end{align}\n');
fprintf(fout,'\\end{multicols}\n');
fclose(fin);
fclose(fout);