1;

clc
clear all
close all

page_screen_output(0);
page_output_immediately(1);

addpath('./loadFiles')
addpath('../config')

% Load file
terrainLoadFiles

% Config files
terrainConfig

% Parse data
filename = '../res/terrain01.data';
delimiterIn = ' ';
headerlinesIn = 1;
A = importdata(filename, delimiterIn, headerlinesIn);

x = A.data(:,1);
y = A.data(:,2);
z = A.data(:,3);

% Random subset for training and testing
trainSet = randomSubset(A.data(:,:), setSizePercentage);
testSet = randomSubset(A.data(:,:), setSizePercentage);

trainPatterns = trainSet(:,1:2);
trainTargets = trainSet(:,3);

testPatterns = testSet(:,1:2);
testTargets = testSet(:,3);

[trainTargets, mP, sP] = normalizePatterns(trainTargets);
testTargets = normalizeWithParameters(testTargets, mP, sP);

rawTestPatterns = testPatterns;
trainPatterns = preprocessing(trainPatterns);
testPatterns = preprocessing(testPatterns);

testPatterns(1:3,:)

if(logical(normalizedPatterns))
	[trainPatterns, mP, sP] = normalizePatterns(trainPatterns);
	testPatterns = normalizeWithParameters(testPatterns, mP, sP);
endif

testPatterns(1:3,:)

trainW = mlp(trainPatterns, trainTargets, activationFunction, hiddenLayers, learningRate, limitEpochs, epsilon, 
	trainingType, momentum, adaptativeLearningRate, limitEpochsForLearningRate, learningRateIncrement, 
	learningRateGeometricDecrement);

% TEST %
testCalculatedOutputs = evaluateNetwork(testPatterns, testTargets, activationFunction, trainW, hiddenLayers);

successRate = ((sum(abs(testTargets - testCalculatedOutputs) <= 0.10))/rows(testPatterns))*100;

printf('%s success rate: %d%%\n', trainingType, successRate);

% x = testPatterns(:,2);
% y = testPatterns(:,3);
% z = testCalculatedOutputs;

% ti = -3:.1:3; 
% [XI,YI] = meshgrid(ti,ti);
% ZI = griddata(x,y,z,XI,YI);

% mesh(XI,YI,ZI), hold
% plot3(x,y,z,'gx')


% plot3(testPatterns(:,2), testPatterns(:,3), testCalculatedOutputs, 'rx');
% END TEST %

% OTHER TRAINING
% terrainConfig

% trainingType = 'batch';

% trainW = mlp(trainPatterns, trainTargets, activationFunction, hiddenLayers, learningRate, limitEpochs, epsilon, 
	% trainingType, momentum, adaptativeLearningRate, limitEpochsForLearningRate, learningRateIncrement, 
	% learningRateGeometricDecrement);

% TEST %
% testCalculatedOutputs = evaluateNetwork(testPatterns, testTargets, activationFunction, trainW, hiddenLayers)

% successRate = ((sum(abs(testTargets - testCalculatedOutputs) <= sqrt(epsilon*2)))/rows(testPatterns))*100;

% printf('%s success rate: %d%%\n', trainingType, successRate);
% END TEST %

figure(1)
grid on
hold on
plot3(x,y,z,'.');
plot3(rawTestPatterns(:,1), rawTestPatterns(:,2), testCalculatedOutputs, 'rx');
axis equal;








