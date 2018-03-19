1;

clc
clear all
close all

singlePerceptron

derivatives

multiLayerPerceptron

errorFunctions

% Parameters
global hiddenLayers = [2];

global learningRate = 0.1;

global activationFunction = @tanh;

global bits = 2;

global patterns = entryCombinations(bits)

global withbias = horzcat(-1*ones(pow2(bits),1), patterns)

global targets = calcWantedOutputs(patterns, @bitxor)

global limitEpochs = 6500;

global epsilon = 0.1; 

finalW = mlp(patterns, targets, activationFunction, hiddenLayers, learningRate, limitEpochs, epsilon)