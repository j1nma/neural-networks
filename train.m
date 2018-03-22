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
grid on
hold on

% Load files
terrainConfig

derivatives

errorFunctions

multiLayerPerceptron

% Random subset for training and testing
trainSet = randomSubset(A.data(:,:), setSizePercentage);
testSet = randomSubset(A.data(:,:), setSizePercentage);

trainPatterns = trainSet(:,1:2);
trainTargets = trainSet(:,3);

testPatterns = testSet(:,1:2);
testTargets = testSet(:,3);


% Consider normalizing for exponentialSigmoid activation function
trainPatterns = preprocessing(trainPatterns);
testPatterns = preprocessing(testPatterns);

if(logical(normalizedPatterns))
	[trainPatterns, mP, sP] = normalizePatterns(trainPatterns);
	testPatterns = normalizeWithParameters(testPatterns, mP, sP);
endif

trainW = mlp(trainPatterns, trainTargets, activationFunction, hiddenLayers, learningRate, limitEpochs, epsilon, trainingType, momentum);

% TEST %
testCalculatedOutputs = evaluateNetwork(testPatterns, testTargets, activationFunction, trainW, hiddenLayers);

successRate = ((sum(abs(testTargets - testCalculatedOutputs)<=epsilon))/rows(testPatterns))*100;

printf('Batch success rate: %d%%\n', successRate);

x = testPatterns(:,2);
y = testPatterns(:,3);
z = testCalculatedOutputs;

% ti = -3:.1:3; 
% [XI,YI] = meshgrid(ti,ti);
% ZI = griddata(x,y,z,XI,YI);

% mesh(XI,YI,ZI), hold
% plot3(x,y,z,'gx')


% plot3(testPatterns(:,2), testPatterns(:,3), testCalculatedOutputs, 'rx');
% END TEST %

% INCREMENTAL TRAINING
terrainConfig

trainingType = 'incremental';

trainW = mlp(trainPatterns, trainTargets, activationFunction, hiddenLayers, learningRate, limitEpochs, epsilon, trainingType, momentum);

% TEST %
testCalculatedOutputs = evaluateNetwork(testPatterns, testTargets, activationFunction, trainW, hiddenLayers)

successRate = ((sum(abs(testTargets - testCalculatedOutputs) <= sqrt(epsilon*2)))/rows(testPatterns))*100;

printf('Incremental success rate: %d%%\n', successRate);
% END TEST %








