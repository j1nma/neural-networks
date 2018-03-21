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
global trainPatterns = trainSet(:,1:2);

global trainTargets = trainSet(:,3);

global activationFunction = @tanh;

global hiddenLayers = [6 2];

global learningRate = 0.1;

global epochs = 200;

global epsilon = 0.001;

global trainingType = 'incremental';

% Consider normalizing for exponentialSigmoid activation function
global normalizedPatterns = 1;

trainPatterns = preprocessing(trainPatterns);
testPatterns = preprocessing(testPatterns);

% Normalize patterns if activationFunction == @exponentialSigmoid
if(logical(normalizedPatterns))
	[trainPatterns, mP, sP] = normalizePatterns(trainPatterns);
	testPatterns = normalizeWithParameters(testPatterns, mP, sP);
endif

global trainW = mlp(trainPatterns, trainTargets, activationFunction, hiddenLayers, learningRate, epochs, epsilon);

% TEST %
testCalculatedOutputs = evaluateNetwork(testPatterns, testTargets, activationFunction, trainW, hiddenLayers);

plot3(testPatterns(:,2),testPatterns(:,3),testCalculatedOutputs,'rx');
% END TEST %