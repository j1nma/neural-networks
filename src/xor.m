1;

clc
clear all
close all

page_screen_output(0);
page_output_immediately(1);

addpath('./loadFiles')
addpath('../config')

% Load file
xorLoadFiles

% Config files
xorConfig

% Extra parameters
bits = 2;

% Keep random subset for training and testing
patterns = entryCombinations(bits);
testPatterns = randomSubset(patterns, setSizePercentage)
testTargets = calcWantedOutputs(testPatterns, @bitxor);

% Parameters
trainPatterns = randomSubset(patterns, setSizePercentage);
trainTargets = calcWantedOutputs(trainPatterns, @bitxor);
trainPatterns = preprocessing(trainPatterns);
testPatterns = preprocessing(testPatterns);

if(logical(normalizedPatterns))
	[trainPatterns, mP, sP] = normalizePatterns(trainPatterns);
	testPatterns = normalizeWithParameters(testPatterns, mP, sP);
endif

trainPatterns

trainW = mlp(trainPatterns, trainTargets, activationFunction, hiddenLayers, learningRate, limitEpochs, epsilon, 
	trainingType, momentum, adaptativeLearningRate, limitEpochsForLearningRate, 
	learningRateIncrement, learningRateGeometricDecrement);

whos global


% TEST %
testCalculatedOutputs = evaluateNetwork(testPatterns, testTargets, activationFunction, trainW, hiddenLayers)

successRate = ((sum(abs(testTargets - testCalculatedOutputs) <= 0.15))/rows(testPatterns))*100;

printf('%s success rate: %d%%\n', trainingType, successRate);
% END TEST %

% OTHER TRAINING
clear -global

% xorConfig

% trainingType = 'batch';

% trainW = mlp(trainPatterns, trainTargets, activationFunction, hiddenLayers, learningRate, limitEpochs, epsilon, 
% 	trainingType, momentum, adaptativeLearningRate, limitEpochsForLearningRate, 
% 	learningRateIncrement, learningRateGeometricDecrement);

% clear -global

% % TEST %
% testCalculatedOutputs = evaluateNetwork(testPatterns, testTargets, activationFunction, trainW, hiddenLayers)

% successRate = ((sum(abs(testTargets - testCalculatedOutputs) <= 0.15))/rows(testPatterns))*100;

% printf('%s success rate: %d%%\n', trainingType, successRate);
% % END TEST %