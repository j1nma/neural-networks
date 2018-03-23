clc
clear all
close all

page_screen_output(0);
page_output_immediately(1);

% Parse data
filename = 'terrain01.data';
delimiterIn = ' ';
headerlinesIn = 1;
A = importdata(filename, delimiterIn, headerlinesIn);

setSizePercentage = 1.0;

activationFunction = @tanh;

hiddenLayers = [7 7];

learningRate = 0.1;

limitEpochs = 1000;

epsilon = 0.015 ;

trainingType = 'incremental';

momentum = 0.9;

normalizedPatterns = 0;