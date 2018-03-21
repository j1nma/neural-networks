1;

clc
clear all
close all

% Parse data
filename = 'terrain11.data';
delimiterIn = ' ';
headerlinesIn = 1;
A = importdata(filename, delimiterIn, headerlinesIn);

% figure(1)
x=A.data(:,1);
y=A.data(:,2);
z=A.data(:,3);
plot3(x,y,z,'.');

hold on

% Load files
derivatives

errorFunctions

multiLayerPerceptron

% Keep random subset for training and testing
setSizePercentage = 0.50;
trainSet = randomSubset(A.data(:,:), setSizePercentage);
testSet = randomSubset(A.data(:,:), setSizePercentage);
testPatterns = testSet(:,1:2);
testTargets = testSet(:,3);

% Parameters
global patterns = trainSet(:,1:2);

global targets = trainSet(:,3);

global activationFunction = @tanh;

global hiddenLayers = [6 2];

global learningRate = 0.1;

global epochs = 1000;

global epsilon = 0.001;

global trainingType = 'incremental';

global normalizedPatterns = (activationFunction == @exponentialSigmoid);

patterns = preprocessing(patterns);
testPatterns = preprocessing(testPatterns);

% Normalize patterns if activationFunction == @exponentialSigmoid
if(logical(normalizedPatterns))
	[patterns, mP, sP] = normalizePatterns(patterns);
	testPatterns = normalizeWithParameters(testPatterns, mP, sP)
endif

global trainW = mlp(patterns, targets, activationFunction, hiddenLayers, learningRate, epochs, epsilon);

% TEST %
testCalculatedOutputs = evaluateNetwork(testPatterns, testTargets, activationFunction, trainW, hiddenLayers);

plot3(testPatterns(:,2),testPatterns(:,3),testCalculatedOutputs,'rx');
% END TEST %