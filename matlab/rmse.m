%% compute RMSE
function [rmse] = rmse(x, y)
  rmse = -1; 
  sum = 0;
  count1 = min(size(x,1), size(y,1));
  count2 = min(size(x,2), size(y,2));
  count = max(count1, count2);
  
  if count > 0 
      for i =1 : count 
          sum = sum + (x(i)-y(i))^2;
      endfor
  rmse = sum/count;
  rmse = sqrt(rmse);  
  endif
 
endfunction
