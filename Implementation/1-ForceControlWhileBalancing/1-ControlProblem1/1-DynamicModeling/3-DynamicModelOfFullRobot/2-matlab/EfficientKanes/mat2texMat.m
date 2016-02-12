function mat2texMat(s, fout)

fprintf(fout, '%s', '\left[\begin{matrix} ');

for i = 1:size(s,1)
    for j=1:size(s,2)
        fprintf(fout, '%s', char(s(i,j)));
        if(j==size(s,2))
            fprintf(fout, '%s', ' & ');
        elseif(i~=size(s,1))
            fprintf(fout, '%s', ' \\');
        end
    end
end

fprintf(fout, '%s', ' \end{matrix}\right]');