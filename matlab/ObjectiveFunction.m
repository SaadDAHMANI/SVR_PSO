%% Custum Objective function to perform SVR-PSO
function [fit] = ObjectiveFunction (L, x, z, xt, zt, labell, labelt)
  
g_value=L(1);
c_value=L(2);
eps_value=L(3);

origin_cmd = "-s 3 -t 2 -h 0 -g gamma -c complexity -p epsilon";

% The decision variables for SVR hyperparameters tuning.
newcmd =strrep(origin_cmd, "gamma", num2str(g_value));
newcmd=strrep(newcmd, "complexity", num2str(c_value));
newcmd =strrep(newcmd, "epsilon", num2str(eps_value));

disp("|_______");
disp('----- > SVR evaluation with :');
disp(newcmd);

model = svmtrain(z,x, newcmd); 

% predict using learning data :

[pl] = svmpredict(labell,x, model);

% Compute RMSE for learning step :
rmsel = rmse(z,pl);
% compute correlation for learning :

rl= corr(z,pl);

r2l=rl*rl;

disp("* R2_Learning -->"); disp(r2l);
disp('* RMSE_Learning -->'); disp(rmsel);

% predict using testing data:
[pt] = svmpredict(labelt,xt, model);

% Compute RMSE for testing step :
rmset = rmse(zt,pt);
% compute correlation for testing :

rt=corr(zt,pt);

r2t =rt*rt;

disp("* R2_Testing -->"); disp(r2t);
disp("* RMSE_Testing -->"); disp(rmset);

disp("_______|");

%% Make RMSE_Learning as fitness. 
fit = rmsel;
end