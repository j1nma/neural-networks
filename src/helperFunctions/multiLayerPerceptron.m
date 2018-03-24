1;

function w = mlp(patterns, targets, activationFunction, hiddenLayers, learningRate, limitEpochs, 
	epsilon, trainingType, momentum, adaptativeLearningRate, limitEpochsForLearningRate)

	global calculatedOutputs;

	global w;

	if(isrow(hiddenLayers))
		hiddenLayers = hiddenLayers';
	endif

	derivativeFunction = setDerivative(activationFunction);

	epochs = 0;

	calculatedOutputs = zeros(rows(targets),1);

	previousEpochError = 0;

	global k = 0;

	% 1. Initialize weights with small random values
	numberOfInputsIncludedBias = columns(patterns);
	numberOfOutputs = columns(targets);
	w = randomInitialWeights(hiddenLayers, numberOfInputsIncludedBias, numberOfOutputs);

	previousWeights = w;

	if(strcmp(trainingType,'batch'))
		do
			w = backpropagationBatch(patterns, targets, activationFunction, hiddenLayers, 
				learningRate, derivativeFunction, momentum); 
	
			epochs += 1;

			currentEpochError = (sum((targets - calculatedOutputs) .^ 2))/rows(patterns);
			epochError(epochs, :) = currentEpochError;

			if(adaptativeLearningRate == 1) 
				
				deltaError =  currentEpochError - previousEpochError;

				deltalr = deltaLearningRate(deltaError, learningRate, k, limitEpochsForLearningRate);

				learningRate += deltalr;

				if(deltaError > 0)
					w = previousWeights;
					momentum = 0;
				else
					previousWeights = w;
				endif

 			endif

 			previousEpochError = currentEpochError;

 			plotEpochs(epochs, epochError, 'o-g', 2);

 		% 	epochAccuracy(epochs, :) = ((sum(abs(targets - calculatedOutputs) <= 0.3))/rows(patterns));
			% epochAccuracy(epochs);
 		% 	plotEpochs(epochs, epochAccuracy, 'k', 3);

		until(epochError(epochs) <= epsilon || epochs == limitEpochs)

	elseif (strcmp(trainingType,'incremental'))

		do
			w = backpropagation(patterns, targets, activationFunction, hiddenLayers, 
				learningRate, derivativeFunction, momentum);
	
			epochs += 1;

			currentEpochError = (sum((targets - calculatedOutputs) .^ 2))/rows(patterns);
			epochError(epochs, :) = currentEpochError;

			if(adaptativeLearningRate == 1) 
				
				deltaError =  currentEpochError - previousEpochError;

				deltalr = deltaLearningRate(deltaError, learningRate, k, limitEpochsForLearningRate);

				learningRate += deltalr

				if(deltaError > 0)
					w = previousWeights;
					momentum = 0;
				else
					previousWeights = w;
				endif

 			endif

 			previousEpochError = currentEpochError;

 			plotEpochs(epochs, epochError, 'o-b', 2);

 		% 	epochAccuracy(epochs, :) = ((sum(abs(targets - calculatedOutputs) <= 0.3))/rows(patterns));
			% epochAccuracy(epochs);
 		% 	plotEpochs(epochs, epochAccuracy, 'm', 3);
		
		until(epochError(epochs) <= epsilon || epochs == limitEpochs)

	else
		error('Wrong training type.');
	endif		

endfunction