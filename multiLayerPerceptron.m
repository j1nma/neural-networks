1;

learningRateFunctions

function w = mlp(patterns, targets, activationFunction, hiddenLayers, learningRate, limitEpochs, epsilon, trainingType)

	global calculatedOutputs;

	global w;

	global learningRate;

	global epsilon;

	global numberOfLayers;

	global trainingType;

	if(isrow(hiddenLayers))
		hiddenLayers = hiddenLayers';
	endif

	derivativeFunction = setDerivative(activationFunction);

	epochs = 0;

	calculatedOutputs = zeros(rows(targets),1);

	% 1. Initialize weights with small random values
	numberOfInputsIncludedBias = columns(patterns);
	numberOfOutputs = columns(targets);
	w = randomInitialWeights(hiddenLayers, numberOfInputsIncludedBias, numberOfOutputs);

	if(strcmp(trainingType,'batch'))
		do
			w = backpropagationBatch(patterns, targets, activationFunction, hiddenLayers, derivativeFunction);

			epochs += 1;

		until((limitError(targets) == 0) || epochs == limitEpochs)

		
		calculatedOutputs

	elseif (strcmp(trainingType,'incremental'))

		do
			w = backpropagation(patterns, targets, activationFunction, hiddenLayers, derivativeFunction);

			epochs += 1;

			updateLearningRate(calcError(targets));

		until((limitError(targets) == 0) || epochs == limitEpochs)

		% calculatedOutputs

		% finalW = w
	else
		error('Wrong training type');
	endif		


	% epochs

	% limitError(targets)

	% error = calcError(targets)

	% plot(1:epochs,totalLearningError,'g.');
	% plot3(patterns(:,2),patterns(:,3),calculatedOutputs,'b*');

endfunction