function Rpopus= B2R(popus,dim,Xmax,Xmin)
%% Description
% 1.This function is to transform the binary code to real code to caculate
% the fitness function.
% 2.Input is the binary matrix popus with size [popsize,m].
% 3.Output is the real matrix Rpopus with size [popsize,1].

%% code starts
[popsize m] = size(popus);
bit = m / dim;
Rpopus = zeros(popsize,dim);
for i = 1:popsize
    for d = 1:dim
       for j = 1 + (d-1) * bit:d * bit
           Rpopus(i,d) = Rpopus(i,d) + (popus(i,j) * 2^( d * bit -j));
       end
        Rpopus(i,d) = Xmin + (Xmax - Xmin) * (Rpopus(i,d) / ( 2^bit - 1));             
    end
end
end

