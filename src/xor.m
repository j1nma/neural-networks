1;

clc
clear all
close all

page_screen_output(0);
page_output_immediately(1);

addpath('../config')
addpath('./loadFiles')

% Config files
xorConfig

% Load file
xorLoadFiles

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

trainW = mlp(trainPatterns, trainTargets, activationFunction, hiddenLayers, learningRate, adaptativeLearningRate, limitEpochsForLearningRate, limitEpochs, epsilon, trainingType, momentum);

% TEST %;
testPatterns = preprocessing(testPatterns);

testCalculatedOutputs = evaluateNetwork(testPatterns, testTargets, activationFunction, trainW, hiddenLayers)

successRate = ((sum(abs(testTargets - testCalculatedOutputs) <= 0.15))/rows(testPatterns))*100;

printf('%s success rate: %d%%\n', trainingType, successRate);
% END TEST %


% OTHER TRAINING
xorConfig

trainingType = 'batch';

trainW = mlp(trainPatterns, trainTargets, activationFunction, hiddenLayers, learningRate, adaptativeLearningRate, limitEpochsForLearningRate, limitEpochs, epsilon, trainingType, momentum);

% TEST %
testCalculatedOutputs = evaluateNetwork(testPatterns, testTargets, activationFunction, trainW, hiddenLayers)

successRate = ((sum(abs(testTargets - testCalculatedOutputs) <= 0.15))/rows(testPatterns))*100;

printf('%s success rate: %d%%\n', trainingType, successRate);
% END TEST %
