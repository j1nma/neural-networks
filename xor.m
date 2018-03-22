1;

clc
clear all
close all

% Load files
xorConfig

singlePerceptron

derivatives

errorFunctions

learningRateFunctions

multiLayerPerceptron

% Extra parameters
bits = 2;

% Keep random subset for training and testing
patterns = entryCombinations(bits);
testPatterns = randomSubset(patterns, setSizePercentage);
testTargets = calcWantedOutputs(testPatterns, @bitxor);

% Parameters
trainPatterns = randomSubset(patterns, setSizePercentage);
trainTargets = calcWantedOutputs(trainPatterns, @bitxor);
trainPatterns = preprocessing(trainPatterns)

trainW = mlp(trainPatterns, trainTargets, activationFunction, hiddenLayers, learningRate, limitEpochs, epsilon, trainingType, momentum);

% TEST %;
testPatterns = preprocessing(testPatterns);

testCalculatedOutputs = evaluateNetwork(testPatterns, testTargets, activationFunction, trainW, hiddenLayers)

successRate = ((sum(abs(testTargets - testCalculatedOutputs) <= sqrt(epsilon*2)))/rows(testPatterns))*100;

printf('Batch success rate: %d%%\n', successRate);
% END TEST %


% INCREMENTAL TRAINING
xorConfig

trainingType = 'incremental';

trainW = mlp(trainPatterns, trainTargets, activationFunction, hiddenLayers, learningRate, limitEpochs, epsilon, trainingType, momentum);

% TEST %
testCalculatedOutputs = evaluateNetwork(testPatterns, testTargets, activationFunction, trainW, hiddenLayers)

successRate = ((sum(abs(testTargets - testCalculatedOutputs) <= sqrt(epsilon*2)))/rows(testPatterns))*100;

printf('Incremental success rate: %d%%\n', successRate);
% END TEST %
