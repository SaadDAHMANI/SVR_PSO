function [learnIn, learnOut, testIn, testOut, labellearn, labeltest] = load_data()
 % Loadin data
 
 file='/home/sd/Documents/Octave/SVR_PSO/matlab/Datasets/Coxs_data_example.csv';

 %in_cols =[8]; %% Model 1
 in_col = [7, 8, 12, 13, 18, 19]; %% Model of input combination from the dataset.
 
 in_cols = in_col + 1; 
 disp("inputs = ");
 disp(in_cols);
 
 out_cols= [2]; %% The output column.

 data = csvread(file);

 records = size(data,1)-1;
 cols = size(data,2);

 learnRate = 70
 learnCount = round((records*learnRate)/100)
 testCount = records-learnCount;

 %Create data matrices
 labellearn = 1 : learnCount;

 %learnIn = zeros(learnCount, (cols-2));
 learnIn = zeros(learnCount, size(in_cols,2));
 learnOut = 1 : learnCount;

 labellearn = labellearn';
 learnOut = learnOut';

 labeltest = 1 : testCount;
 %testIn = zeros(testCount, (cols-2));
 testIn = zeros(testCount, size(out_cols,2));
 testOut = 1 : testCount;

 labeltest = labeltest';
 testOut = testOut';

 for i = 1 : learnCount

    learnOut(i)=data((i+1), out_cols(1));

    for j = 1 : size(in_cols, 2)
          learnIn(i,j) = data((i+1), in_cols(j));
    end
 end

 for i = 1 : testCount

      testOut(i)=data((i+1+learnCount), out_cols(1));

      for j = 1 : size(in_cols,2)
             testIn(i,j) = data((i+1+learnCount), in_cols(j));
      end
 end

 disp("---- learnIn : "); disp(size(learnIn,1));

 disp("---- learnOut : "); disp(size(learnOut,1));

 disp("---- TestIn : "); disp(size(testIn,1));

 disp("---- TestOut : "); disp(size(testOut,1));

 disp("**** Data is loaded ...");

endfunction
