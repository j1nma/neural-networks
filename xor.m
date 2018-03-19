1;

clc
clear all
close all

singlePerceptron

derivatives

multiLayerPerceptron

% Parameters
global hiddenLayers = [2];

global learningRate = 0.1;

global activationFunction = @tanh;

global bits = 2;

global patterns = entryCombinations(bits)

global withbias = horzcat(-1*ones(4,1), patterns)

global targets = calcWantedOutputs(patterns, @bitxor)

finalW = mlp(patterns, targets, activationFunction, hiddenLayers, learningRate)