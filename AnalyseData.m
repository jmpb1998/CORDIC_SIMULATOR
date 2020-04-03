% Set samples and variance vectors 
%load arrdata.mat
load arrdataFinal2.mat

N = 1:50:1001;
var = 1:50:1001;
estimatorVariance = 2*(var.^4)'./N;


hi = arr(1:7, 1); 
stages = 18;
bits   = 16:4:40;
% Plot estimator variance heatmap 
figure;
%map=heatmap(arr); 
%map=heatmap({'A','B','C'},[5 6 7],rand(3))
map=heatmap(stages, bits, hi);
map.Colormap=jet;
map.ColorScaling='log';
title('Upper MSE for CORDIC implementations with 95% confidence and varied bit length');
ylabel('Bit length');
xlabel('CORDIC stages');
ax = gca;
ax.FontSize = 16;


% Plot confidence in result 
%load arrdataConfidence.mat

hi = arr(1:14, 1:13); 
stages = 6:2:31;
bits   = 8:4:63;
% Plot estimator variance heatmap 
figure;
%map=heatmap(arr); 
%map=heatmap({'A','B','C'},[5 6 7],rand(3))
map=heatmap(stages, bits, hi);
map.Colormap=jet;
map.ColorScaling='log';
title('Worst MSE with 95% confidence for CORDIC implementations with varied bit length and stages');
ylabel('Bit length');
xlabel('CORDIC stages');
ax = gca;
ax.FontSize = 12;



%% Analysed Fixed Point Error

%%%%%%%%%%%%       RANDOM   INPUTS       %%%%%%%%%%%%%
load RandomInputsMSE.mat
inputArrayMSE = arr(2, :);
ArrayMSE      = arr(1, :);

load RandomInputsABS.mat
inputArrayABS = arr(2, :); 
ArrayABS      = arr(1, :); 


figure; 
subplot(2,1,1)
stem  (inputArrayMSE, ArrayMSE) 
ylim  ([0 1])
xlim  ([0 255])
title ('Random Uniform Inputs vs MSE for Q17.15')
xlabel('Floating-Point Input')
ylabel('MSE')
set(gca, 'YScale', 'log')
ax = gca;
ax.FontSize = 14; 

subplot(2,1,2)
stem  (inputArrayABS, ArrayABS) 
ylim  ([0 1])
xlim  ([0 255])
title ('Random Uniform Inputs vs Absolute Error for Q17.15')
xlabel('Floating-Point Input')
ylabel('Absolute Error')
set(gca, 'YScale', 'log')
ax = gca;
ax.FontSize = 14; 

figure; 
subplot(2,1,1)
stem  (inputArrayMSE, ArrayMSE) 
ylim  ([0 1])
xlim  ([0 255])
title ('Random Uniform Inputs vs MSE for Q17.15')
xlabel('Floating-Point Input')
ylabel('MSE')
ax = gca;
ax.FontSize = 14; 

subplot(2,1,2)
stem  (inputArrayABS, ArrayABS) 

xlim  ([0 255])
title ('Random Uniform Inputs vs Absolute Error for Q17.15')
xlabel('Floating-Point Input')
ylabel('Absolute Error')
ax = gca;
ax.FontSize = 14; 


%%%%%%%%%%%%%%%%%%%     Random Inputs with Varying Ranges Bar Graph 
load RandomInputsVaryingRangesMSE.mat
ArrayVaryRangeMSE = arr(:, 1);
load RandomInputsVaryingRangesABS.mat
ArrayVaryRangeABS = arr(:, 1);

barData = [ArrayVaryRangeMSE'; ArrayVaryRangeABS']; 

axis = categorical({'0 - 0.00001','0.00001 - 0.0001','0.0001 - 0.001', '0.001 - 0.01', '0.01 - 0.1','0.1 - 1','1 - 10','10 - 100', '100 - 255'});
%axis = reordercats(axis,{'0 - 0.01','0 - 0.1','0.1 - 1','1 - 10','10 - 100', '100 - 255'});
data = arr(:, 1); 
figure; 
bar (axis, barData')
legend('MSE', 'Absolute Error')
xlabel('Range Brackets')
ylabel('Error')
title('Bar Graph with Absolute Error and MSE for varying Input Ranges for Q17.15')
set(gca, 'YScale', 'log')
ax = gca;
ax.FontSize = 14; 


%% Accumulator data

load AccumulatorData.mat

FixedPoint = arr(1,:);
FloatPoint = arr(2,:);

testCases = [932.88, 35276.45, 4513207.72]; 

% Calculate Error
error1 = abs(FixedPoint(1) - testCases(1)*1024)/(testCases(1)*1024)/1024; 
error2 = abs(FixedPoint(2) - testCases(2)*1024)/(testCases(1)*1024)/1024; 
error3 = abs(FixedPoint(3) - testCases(3)*1024)/(testCases(1)*1024)/1024;

%[0.03310563 0.003587379 0.003593737; 0.047040915 0.008828836 0.008723002; 0.047040915 0.008828836 0.008723002]
% Plot bar graph 

axis = categorical({'Test 1', 'Test 2', 'Test 3'});
%axis = reordercats(axis,{'0 - 0.01','0 - 0.1','0.1 - 1','1 - 10','10 - 100', '100 - 255'});

barData = [error1*1024, error2, error3; 0.03310563 0.003587379 0.003593737]; 
figure; 
bar (axis, barData')
legend('Custom Instruction', 'Task 4', 'Task 4 - Cos', 'Task 4 - Final Cos')
ylabel('Error')
title('Bar Graph with Absolute Error for Q17.19 vs Error Task 4')
ax = gca;
ax.FontSize = 12; 
set(gca, 'YScale', 'log')
grid on 
grid minor

%% Accumulator data with varying bits 



clear all 
load AccumulatorErrorVaryingBitsRandom.mat
FixedPoint = arr(1);
%FloatPoint = arr(2,:);

load AccumulatorErrorVaryingBitsRandomTestbench.mat 
test       = arr; 

load NIOS2_TESTBENCH_ABS_VARYING.mat
absError = arr;

load AccumulatorErrorVaryingBitsRandomInput.mat
input = arr;
error = zeros(13, 1000); 
% Calculate Error

for i = 1 : 13
   error(i, :) = abs(absError(i,:) - test(1,:))./test(1,:) ;
end

figure; 
hold on 
plot(input, absError(1,:), '*')
plot(input, absError(2,:), '*')
plot(input, absError(3,:), '*')
plot(input, absError(4,:), '*')
plot(input, absError(5,:), '*')
plot(input, absError(6,:), '*')
plot(input, absError(7,:), '*')
plot(input, absError(8,:), 'y*')
plot(input, absError(9,:), 'g*')
plot(input, absError(10,:), 'r*')
plot(input, absError(11,:), 'b*')
plot(input, absError(12,:), 'c*')
plot(input, absError(13,:), 'm*')
title('Absolute Error as a function of x input for varying bit Fixed-Point formats')
leg = legend('16', '20', '24', '28', '32', '36', '40', '44', '48', '52', '56', '60', '64')
title(leg,'Bit length')
leg.Title.Visible = 'on';
set(gca, 'YScale', 'log') 
xlim([0 255])
ax = gca; 
ax.FontSize = 14; 
grid on 
grid minor





 