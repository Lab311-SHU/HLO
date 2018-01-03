# HLO
%% Description
% 1.A MATLAB code for Human Learning Optimization(HLO) algorithm [1] is developed for a simple test problems in this file.
% 2.Main program of HLO which is "SHLO.m",and HLO code is tested and verified for a simple problem.
% 3.Anybody can use this code for their application, by developing their own fitness function for the unique problems.
% 4.For any new test problem (application), the following modifications are sufficient.They are listed down.
% 5.For complicated problems, it is better to introudce the re-learning operator given in [2] to obtain better results.
% 6.There is an adaptive simplified HLO in [3],which change the mode of 'pr'and 'pi'.

%% Problem Dependent variables
% popsize                       % Population size
% runtimes                      % Number of runs
% Gmax                          % Mzx number of generations - stopping criteria
% Dim=2;                        %Variable number
% bit=30;                       %Bits numbers
% Xmax=100;                     %Vaiable range
% Xmin=-100;                    %Vaiable range   
% load sphere_func_data.mat     %Test different function need change this files
%% Test problem 
% Evfit                         %Fitness function                    

%% References:
% 1.Ling Wang, Haoqi Ni, Ruixin Yang, Minrui Fei, Wei Ye. A Simple Human Learnibg Optimization Algorithm. 
% Communications in Computer and Information Science. 2014,v462:56-65
% 2.Ling Wang, Ruixin Yang, Haoqi Ni, Wei Ye, Minrui Fei, and Panos M. Pardalos. A Human Learning Optimization 
% Algorithm and Its Application to Multi-dimensional Knapsack Problems. Applied Soft Computing. 2015,34:736-743
% 3.Ling Wang, Haoqi Ni, Ruixin Yang, Panos M. Pardalos, Xin Du, Minrui Fei. An Adaptive Simplified Human 
% Learning Optimization Algorithm. Information Sciences. 2015,320:126-139
