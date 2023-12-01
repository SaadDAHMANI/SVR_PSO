function [r2l, r2t] = plot_bestSVR(L)
  
g_value=L(1);
c_value=L(2);
eps_value=L(3);
  
[x, z, xt, zt, labell, labelt] = load_data();

 origin_cmd = "-s 3 -t 2 -g gamma -c complexity -p epsilon";
 %origin_cmd = "s 3 -t 2 -g 5.4155 -c 29605.6786 -p 1.0027e-05";

newcmd =strrep(origin_cmd, "gamma", num2str(g_value));
newcmd=strrep(newcmd, "complexity", num2str(c_value));
newcmd =strrep(newcmd, "epsilon", num2str(eps_value)); 

disp('SVR evaluation with :');
disp(newcmd);

model = svmtrain(z,x, newcmd); %%'-s 3 -t 2 -p 0.01 -c 10');

% predict using learning data :

[pl] = svmpredict(labell,x, model);

% Compute RMSE for learning step :
rmsel = rmse(z,pl);
% compute correlation for learning :

rl= corr(z,pl);

r2l=rl*rl;

disp('* RMSE_Learning -->'); 
disp("* R2_Learning -->"); disp(r2l);

% predict using testing data:
[pt] = svmpredict(labelt,xt, model);

% Compute RMSE for testing step :
rmset = rmse(zt,pt);
% compute correlation for testing :

rt=corr(zt,pt);

r2t =rt*rt;

disp("* RMSE_Testing -->"); disp(rmset);
disp("* R2_Testing -->"); disp(r2t);

soltn=[rmsel, rmset, r2l, r2t];
disp(soltn);

fit = rmset;
%disp('The best fintness value = ');
%disp(fit);


%subplot (2, 1, 1)
%i =1: size(z,1);
%plot(i, z, pl);

%subplot (2, 1, 2)
%j =1: size(zt,1);
%plot(j, zt, pt);

%disp(rmsel); disp(rmset); disp(r2l); disp(r2t);                              

save learn_out_model_6.mat pl;
save test_out_model_6.mat pt;
endfunction

