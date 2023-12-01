clear;
close all;
clc;

%% Load statistics package for Octave (Add by self-SaadDAHMANI)-----
pkg load statistics;

%-------------------------------------------------------------------------
 make; %load LibSVM for Octave
 disp("LibSVM for Octave is loaded.");
 %pkg load statistics
 %-------------------------------------------------------------------------

format short;

 %%---------------Load Data
[xlearn, zlearn, xtest, ztest, labellearn, labeltest] = load_data();

 tic();             % Start time computation
%%--------------------------------------------------------------------



% Problem preparation
dim =3;
problem.nVar = dim;
problem.ub = [0.01, 50000, 0.01]; %%10 * ones(1, dim);
problem.lb =  [0.00001, 0.00001, 0.00001]; %%0.00001 * ones(1, dim);
problem.fobj = @ObjectiveFunction;

% PSO parameters
noP = 30;
maxIter = 100;
visFlag = 0; % set this to 0 if you do not want visualization

RunNo  = 1;

BestSolutions_PSO = zeros(1 , RunNo);

[ GBEST , cgcurve ] = PSO( noP , maxIter, problem , visFlag, xlearn, zlearn, xtest, ztest, labellearn, labeltest) ;

 disp('Best solution found')
 bestSolution = GBEST.X
 disp('Best objective value')
 GBEST.O

 save result_svr_pso_BS_20.mat bestSolution;
 save result_svr_pso_BC_20.mat cgcurve;
 quit;
 
%plot(cgcurve);
