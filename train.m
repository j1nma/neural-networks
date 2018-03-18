1;

clc
clear all
close all

% Parse data
filename = 'terrain11.data';
delimiterIn = ' ';
headerlinesIn = 1;
A = importdata(filename, delimiterIn, headerlinesIn);

figure(1)
x=A.data(:,1);
y=A.data(:,2);
z=A.data(:,3);
plot3(x,y,z,'.')

% Keep random subset for training
v = randperm(length(x)); 
trainingSetSize = length(x);
v1 = v(1:trainingSetSize);
p = A.data(v1, :);


% Parameters
patterns = p(:,1:2);

targets = p(:,3);

activationFunction = @exponentialSigmoid;

hiddenLayers = [6 6 6 6 6];

learningRate = 0.1;

limitEpochs = 100;

% w = mlp(patterns, targets, activationFunction, hiddenLayers, learningRate)