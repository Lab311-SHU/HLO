%% A demo of HLO
% Coded by Panpan Li, Ji Pei, Yalan Wen; reviewed by Ling Wang
% revised on 2017-12-8 
% 1. This is a simple demo of HLO [1]. It is just tested by a simple function
% which is y = x1^2 + x2^2.
% 2.This code defines the population size in 'popsize', number of design 
% variables in 'Dim', number of runs in 'runtimes', maximum number of
% generations in 'Gmax',current generation in 't'and bit number for each
% variable is 'bit'.
% 3.'Xmin' and 'Xmax' are the lower and upper bounds of the design variables.
% 4.'pr'is the probability of random learning ,the values of (pi-pr) and
% (1-pi) represents the probabilities of performing individual learning and
% social learning, respectiely.
% 5.'IKD' is the individual knowledge database since the size of IKD=1 here;
% 'SKD' is the social knowledge database and the size of SKD is 1 in this demo.
% 6.For complicated problems, it highly recommends to introudce the re-learning
% operator given in [2] to obtain much better results.
% 7.HLO is sensitive to the parameters p_r and pi. A simple adaptive strategy 
% is given in [3] to relieve the effort of parameter setting.

%% References:
% 1.Ling Wang, Haoqi Ni, Ruixin Yang, Minrui Fei, Wei Ye. A Simple Human Learnibg Optimization Algorithm. 
% Communications in Computer and Information Science. 2014 v462: 56-65
% 2.Ling Wang, Ruixin Yang, Haoqi Ni, Wei Ye, Minrui Fei, and Panos M. Pardalos. A Human Learning Optimization 
% Algorithm and Its Application to Multi-dimensional Knapsack Problems. Applied Soft Computing. 2015, 34: 736-743
% 3.Ling Wang, Haoqi Ni, Ruixin Yang, Panos M. Pardalos, Xin Du, Minrui Fei. An Adaptive Simplified Human 
% Learning Optimization Algorithm. Information Sciences. 2015, 320: 126-139

%% Code starts
clear;
clc;
format long;
popsize = 50;            
runtimes = 1;           %Number of runs
Gmax = 3000;            %Max number of generations - stopping criteria
Dim = 2;                %Variable number
bit = 32;               %Bits numbers
m = bit * Dim;          %Individual lenth
Xmax = 100;             %Vaiable range
Xmin = -100;            %Vaiable range           
p_r = 5.0 / m;               
p_i = 0.85 + 2.0 / m;          

load sphere_func_data.mat;  %Transfer the data of the F1:Shifted Sphere Function in CEC2005

for cn=1:runtimes
%% Initial population 
    popus = inipop(popsize,m);    
    Rpopus = B2R(popus,Dim,Xmax,Xmin);                      %Transform binary to real code
    
%% Evaluate fitness function and initial the IKD and SKD
    Fits = Evfit(Rpopus,popsize,o);                         % Fitness function evaulation 
    IKDfits = Fits;                                         % the best individual fitness    
    IKD = popus;           
    
%% Initial the SKD
    [arrange,position] = sort(IKDfits,1);               
    SKDfit = IKDfits(position(1,1),1);                    
    SKD = IKD(position(1,1),:);                           % the best individual (binary)
    
%% Generation Starts
    for t = 1:Gmax
        for i = 1:popsize
            for j = 1:m
             prob = rand;
                if  prob < p_r && prob > 0                     	%random learning
                    if rand < 0.5
                        popus(i,j) = 1;
                    else
                        popus(i,j) = 0;
                    end
                elseif prob >= p_r && prob < p_i                %individual learning
                    popus(i,j) = IKD(i,j);
                elseif prob >= p_i  && prob < 1               	%social learning
                    popus(i,j) = SKD(1,j);   
                end
            end
        end
%% Evaluate fitness function
        Rpopus = B2R(popus,Dim,Xmax,Xmin);                	%transform binary-string to real variables
        Fits = Evfit(Rpopus,popsize,o);                  	%Fitness function evaulation 
%% Evaluate IKD
        for i = 1:popsize
            if Fits(i) < IKDfits(i)
                IKDfits(i) = Fits(i);
                IKD(i,:) = popus(i,:);
            end
        end
%% Evaluate SKD
        [arrange,postion] = sort(IKDfits,1);                           
        if arrange(1,1) < SKDfit   	% when the best fitness of this generation is better than gloabl best fitness, then update
            SKDfit = arrange(1,1);
            SKD = IKD(postion(1,1),:);
        end
        if (mod(t,200))==0
        fprintf('the %d round\n',t);
        end
        
    end
    fprintf('runtimes = %d\n the best value is:',cn);
    disp(SKDfit);
end
