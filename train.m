1;

clc
clear all
close all

% hold off

% Parse data
filename = 'terrain11.data';
delimiterIn = ' ';
headerlinesIn = 1;
A = importdata(filename, delimiterIn, headerlinesIn);

% figure(1)
x=A.data(:,1);
% y=A.data(:,2);
% z=A.data(:,3);
% plot3(x,y,z,'.');

% hold on

% Keep random subset for training
rp = randperm(length(x)); 
trainingSetSize = length(x)/2;
rts = rp(1:trainingSetSize);
p = A.data(rts, :);

derivatives

multiLayerPerceptron

errorFunctions

% Parameters
global patterns = p(:,1:2);

global targets = p(:,3);

global hiddenLayers = [6 2];

global learningRate = 0.1;

global activationFunction = @tanh;

global epochs = 6500;

global epsilon = 0.1;

global w = mlp(patterns, targets, activationFunction, hiddenLayers, learningRate, epochs, epsilon);