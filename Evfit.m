%% y=x1*x1+x2*x2
function f = Evfit(fx,popsize,o)
% 1. This function returns the fitness functions with the vectors in the
% real code.
% 2.'o' is variables from the files 'sphere_func_data.mat'
% 3.Different problems can modify the form of fitness function 'f'.
f = zeros(popsize,1);
f = (fx(:,1)-o(1,1)).^2 + (fx(:,2)-o(1,2)).^2;

