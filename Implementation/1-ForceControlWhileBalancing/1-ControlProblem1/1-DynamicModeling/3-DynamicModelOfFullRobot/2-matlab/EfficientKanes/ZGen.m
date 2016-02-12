classdef ZGen < handle
    properties
        n
        nl
        nr
        ZZ
        ZZl
        ZZr
        charZ
        fout
        toPrint
    end
    methods
        function obj = ZGen(charZ, varargin)
            obj.n = 0;
            obj.nl = 0;
            obj.nr = 0;
            obj.ZZ = cell(1);
            obj.ZZl = cell(1);
            obj.ZZr = cell(1);
            obj.ZZ{1} = sym(0);
            obj.ZZl{1} = sym(0);
            obj.ZZr{1} = sym(0);
            obj.charZ = charZ;
            if(~isempty(varargin))
                obj.fout = varargin{1};
                obj.toPrint = true;
            else
                obj.toPrint = false;
            end
        end
        function Z = create(obj, expn, key, varargin)
            check = 1; % by default new Z should be unique (so check against those already created)
            if(~isempty(varargin))
                check = varargin{1}; 
            end
            if(isequal(expn,0) || length(symvar(expn)) < 2)
                Z = expn;
            else
                if(key(end) == 'l')
                    alreadyExists = false;
                    if(check)
                        for i=1:obj.nl
                            if(isequal(expn,obj.ZZl{i}))
                                alreadyExists = true;
                                Z = sym([obj.charZ num2str(i) 'l'], 'real');
                                break;
                            end
                        end
                    end
                    if(~alreadyExists)
                        obj.nl = obj.nl + 1;
                        Z = sym([obj.charZ num2str(obj.nl) 'l'], 'real');
                        if(obj.toPrint); fprintf(obj.fout, '%s\n', [obj.charZ num2str(obj.nl) 'l = ' char(expn) ';']); end;
                        obj.ZZl{obj.nl} = expn;
                    end
                elseif(key(end) == 'r')
                    alreadyExists = false;
                    if(check)
                        for i=1:obj.nr
                            if(isequal(expn,obj.ZZr{i}))
                                alreadyExists = true;
                                Z = sym([obj.charZ num2str(i) 'r'], 'real');
                                break;
                            end
                        end
                    end
                    if(~alreadyExists)
                        obj.nr = obj.nr + 1;
                        Z = sym([obj.charZ num2str(obj.nr) 'r'], 'real');
                        if(obj.toPrint); fprintf(obj.fout, '%s\n', [obj.charZ num2str(obj.nr) 'r = ' char(expn) ';']); end;
                        obj.ZZr{obj.nr} = expn;
                    end
                else
                    alreadyExists = false;
                    if(check)
                        for i=1:obj.n
                            if(isequal(expn,obj.ZZ{i}))
                                alreadyExists = true;
                                Z = sym([obj.charZ num2str(i)], 'real');
                                break;
                            end
                        end
                    end
                    if(~alreadyExists)
                        obj.n = obj.n + 1;
                        Z = sym([obj.charZ num2str(obj.n)], 'real');
                        if(obj.toPrint); fprintf(obj.fout, '%s\n', [obj.charZ num2str(obj.n) ' = ' char(expn) ';']); end;
                        obj.ZZ{obj.n} = expn;
                    end
                end
            end
        end
        function print(obj, fid)
            for i=1:obj.n
                fprintf(fid, '%s\n', [obj.charZ num2str(i) ' = ' char(obj.ZZ{i}) ';']);
            end
            for i=1:obj.nl
                fprintf(fid, '%s\n', [obj.charZ num2str(i) 'l = ' char(obj.ZZl{i}) ';']);
            end
            for i=1:obj.nr
                fprintf(fid, '%s\n', [obj.charZ num2str(i) 'r = ' char(obj.ZZr{i}) ';']);
            end
        end
    end
end

