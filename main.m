% run this code to get figures displaying non-monotone behaviour for all
% off the losses below
% the code was tested with Matlab R2019b

clc;
close all;

% we optimize the empirical loss, as defined by:
% 1/n * sum_i loss_i + lambda/n * reg
% the true risk is computed by
% sum_i p_i loss_i
% where p_i is the probability of observing point i

%% set to 1 to generate figures of the paper
% you need the export_fig package to generate the pdf's

save_to_file = 0;

%% fig 1a

n = 40; % max number of training samples 
q = 0.00001; % probability of observing a
lambda = 0; % regularizer

[Rsq1,Rbest1] = do_exp_general(n, q, lambda, 'sqr');
topright = 0;
plot1(Rsq1,Rbest1,save_to_file,'fig1a',topright)

%% fig 1b

n = 40; 
q = 0.1;
lambda = 0;

[R, Rbest] = do_exp_general(n, q, lambda, 'abs');
topright = 1;
plot1(R,Rbest,save_to_file,'fig1b',topright)

%% fig1c

n = 40; 
q = 0.01;
lambda = 0.01;

R1 = do_exp_general(n, q, 0, 'sqr');      % no regularizer
R2 = do_exp_general(n, q, lambda, 'sqr'); % with small regularizer
plot2(R1,R2,save_to_file,'fig1c')

%% fig1d

n = 40; 
%    a  b    c
X = [1, 0.1, -1]; % x-values
Y = [1, -1,   1]; % y-values
P12 = [0.01, 0.01];
P3 = 1 - sum(P12);
P = [P12, P3]; % corresponding probabilities

lambda = 0;
[R,Rbest] = do_exp_general_withbias(n, X, Y, P);
topright = 1;
plot1(R,Rbest,save_to_file,'fig1d',topright)
