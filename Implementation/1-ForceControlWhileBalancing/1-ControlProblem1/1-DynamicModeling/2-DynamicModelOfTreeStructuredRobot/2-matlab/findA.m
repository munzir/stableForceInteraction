function A = findA(f, E)

% Compute the matrix A from the kinetic energy expression  
% 'f' contains map of the frames
% 'E' contains the symbolic expression for the kinetic energy

% Declaring an empty A matrix
key = keys(f);
A=sym(zeros(length(key)-1, length(key)-1));

% Process for each frame one by one
for x=1:length(key)
    if(~isequal(key{x},'0')) % Don't do anything for frame 0
        
        % load the frame
        F=f(key{x});
        i=F.o; % i denotes the current row of the A matrix
        
        % compute all coefficients of the dq associated with the frame (say
        % dq_i)
        c = coeffs(E, F.dq); 
        
        % last coefficient in c corresponds to the coeff of (dq_i)^2 and
        % the respective diagonal element of A is defined as coeff of 
        % ((dq_i)^2)/2). hence we multiply it by 2 and store it in A
        A(i, i) = 2*c(end);
        
        % The second last coeff in c contains coeff of dq_i. It contains 
        % terms with dq of other frames.
        E2 = c(end-1);
        
        % We find the coeff of each dq within E2 to find other elements of 
        % A in the ith row
        for y=1:length(key)
            
            % don't do anything for frame 0 and the frame i (key{x})
            if(~isequal(key{y}, '0') && ~isequal(key{y}, key{x})) 
               
               % current column of the A matrix
               j = f(key{y}).o;
                
               % compute all coeffs in E2 of dq_j
               c2=coeffs(E2, f(key{y}).dq); 
               
               % the last element of c2 contains the coeff of dq_j wihin E2
               % which is the same as the coeff of dq_idq_j in E
               A(i, j)=c2(end);
            end
        end
    end
end