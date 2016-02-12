fin = fopen('gLtoR.m','r');
fout = fopen('gLtoRconverted.m','w');

addw = 105; 
addv = 124; 
addalpha = 14;
adda = 18;
s_in = fgetl(fin);
s_out = [];
while ischar(s_in)
    i = 0;
    o = 0;
    while i<length(s_in)
        i = i + 1;
        o = o + 1;
        if(s_in(i) == 'l')
            s_out(o) = 'r';
        elseif(s_in(i) == 'Z')
            s_out(o) = 'Z'; o = o + 1;
            s=char([]); 
            j = 1;
            while ((i+j)<=length(s_in) && s_in(i+j)<= '9' && s_in(i+j)>='0')
                s(j) = s_in(i+j);
                j = j + 1;
            end
            n = str2num(s(1:end));
            if(n < 29)
                add = 0;
            elseif(n < 134)
                add = addw;
            elseif(n < 266)
                add = 0;
            elseif(n < 390)
                add = addv;
            elseif(n < 524)
                add = 0;
            elseif(n < 538)
                add = addalpha;
            elseif(n < 565)
                add = 0;
            else
                add = adda;
            end
            s = num2str(n + add);
            len = length(s);
            s_out(o:o+len-1) = s;
            i = i + j - 1;
            o = o + len - 1;
        else
            s_out(o) = s_in(i);
        end
    end
    s_out = sprintf('%s\n',s_out);
    fwrite(fout,s_out);
    s_in = fgetl(fin);
    s_out = [];
end
fclose(fin);
fclose(fout);