1;

clc
clear all
close all

% Load files
singlePerceptron

derivatives

errorFunctions

learningRateFunctions

% Extra parameters
bits = 2;

% Keep random subset for training and testing
setSizePercentage = 0.5;
patterns = entryCombinations(bits);
trainSet = randomSubset(patterns, setSizePercentage);
testPatterns = randomSubset(patterns, setSizePercentage);
testTargets = calcWantedOutputs(testPatterns, @bitxor);

% Parameters
global patterns = trainSet

global targets = calcWantedOutputs(patterns, @bitxor);

global activationFunction = @tanh;

global hiddenLayers = [2];

global learningRate = 0.1;

global limitEpochs = 6500;

global epsilon = 0.001;

global trainingType = 'incremental';

patterns = preprocessing(patterns);
testPatterns = preprocessing(testPatterns);

global trainW = mlp(patterns, targets, activationFunction, hiddenLayers, learningRate, limitEpochs, epsilon, trainingType);

% TEST %
testCalculatedOutputs = evaluateNetwork(testPatterns, testTargets, activationFunction, trainW, hiddenLayers)

successRate = (sum(sign(testCalculatedOutputs) == testTargets)/rows(testPatterns))*100;

printf("Success rate: %d%%\n", successRate);
% END TEST %