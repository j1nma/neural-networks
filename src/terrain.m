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
filename = dataFile;
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

if(logical(normalizedPatterns))
	[trainPatterns, mP, sP] = normalizePatterns(trainPatterns);
	testPatterns = normalizeWithParameters(testPatterns, mP, sP);
endif

trainW = mlp(trainPatterns, trainTargets, activationFunction, hiddenLayers, learningRate, limitEpochs, epsilon, 
	trainingType, momentum, adaptativeLearningRate, limitEpochsForLearningRate, learningRateIncrement, 
	learningRateGeometricDecrement, testPatterns, testTargets);

% TEST %
testCalculatedOutputs = evaluateNetwork(testPatterns, testTargets, activationFunction, trainW, hiddenLayers);

successRate = ((sum(abs(testTargets - testCalculatedOutputs) <= outputError))/rows(testPatterns))*100;

printf('%s success rate: %d%%\n', trainingType, successRate);

% xt = testPatterns(:,2);
% yt = testPatterns(:,3);
% zt = testCalculatedOutputs;
% ti = -5:.1:5; 
% [XI,YI] = meshgrid(ti,ti);
% ZI = griddata(xt,yt,zt,XI,YI);
% figure(4)
% mesh(XI,YI,ZI)
% grid on

figure(5)
plot3(x,y,z,'.');
hold on
plot3(rawTestPatterns(:,1), rawTestPatterns(:,2), testCalculatedOutputs, 'rx');
grid on
axis equal;

% END TEST %








