setSizePercentage = 100.0;

activationFunction = @leakyRELU;

hiddenLayers = [15 15];

learningRate = 0.1;

limitEpochs = 350;

epsilon = 0.01;

trainingType = 'incremental';

momentum = 0.7;

normalizedPatterns = 1;

adaptativeLearningRate = 0;

limitEpochsForLearningRate = 3;

learningRateIncrement = 0.001; 

learningRateGeometricDecrement = 0.01;

outputError = 0.1;

dataFile = '../res/terrain11.data';