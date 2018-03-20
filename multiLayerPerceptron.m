1;

function w = mlp(patterns, targets, activationFunction, hiddenLayers, learningRate, limitEpochs, epsilon, trainingType)

	global calculatedOutputs;

	global w;

	global learningRate;

	global epsilon;

	global numberOfLayers;

	global targets;

	derivativeFunction = setDerivative(activationFunction);

	% Add bias to patterns
	bias = -1 * ones(rows(patterns),1);
	patterns = [bias, patterns];

	if(isrow(hiddenLayers))
		hiddenLayers = hiddenLayers';
	endif

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

		until((limitError() == 0) || epochs == limitEpochs)

		
		calculatedOutputs

	elseif (strcmp(trainingType,'incremental'))

		do
			w = backpropagation(patterns, targets, activationFunction, hiddenLayers, derivativeFunction);

			epochs += 1;

			updateLearningRate(calcError());

		until((limitError() == 0) || epochs == limitEpochs)

	

		calculatedOutputs
	else
		error('Wrong training type');
	endif		


	% epochs

	% limitError()

	% error = calcError()

	% plot(1:epochs,totalLearningError,'g.');



	% plots for train.m
	% x = patterns(:, 2);
	% y = patterns(:, 3);
	% plot3(x, y, calculatedOutputs, '.');

endfunction