1;

function trainW = mlp(patterns, targets, activationFunction, hiddenLayers, learningRate, limitEpochs, 
	epsilon, trainingType, momentum, adaptativeLearningRate, limitEpochsForLearningRate, 
	learningRateIncrement, learningRateGeometricDecrement, testPatterns, testTargets)

	if(isrow(hiddenLayers))
		hiddenLayers = hiddenLayers';
	endif
	
	derivativeFunction = setDerivative(activationFunction);
	
	epochs = 0;
	
	global calculatedOutputs = zeros(rows(targets),1);
	
	previousEpochError = 0;
	
	global k = 0; 

	% 1. Initialize weights with small random values
	numberOfInputsIncludedBias = columns(patterns);
	numberOfOutputs = columns(targets);

	global w;
	randomInitialWeights(hiddenLayers, numberOfInputsIncludedBias, numberOfOutputs);
	previousWeights = w;

	global t = 0;

	global deltaW = cell(rows(hiddenLayers) + 1, 1);

	if(strcmp(trainingType,'batch'))
		do
		
			backpropagationBatch(patterns, targets, activationFunction, hiddenLayers, 
				learningRate, derivativeFunction, momentum); 
	
 			epochs += 1;
	
 			currentEpochError = mean(0.5 * ((targets - calculatedOutputs) .^ 2));
 			epochError(epochs, :) = currentEpochError;

 			if(epochs == 1)
 				deltaError = 0;
 			else
 				deltaError =  currentEpochError - previousEpochError;
 			endif
	
 			if(adaptativeLearningRate == 1) 
	
 				deltalr = deltaLearningRate(deltaError, learningRate, limitEpochsForLearningRate, 
 					learningRateIncrement, learningRateGeometricDecrement);
	
 				learningRate += deltalr;
	
 				if(deltaError > 0)
 					w = previousWeights;
 					momentum = 0;
 				else
 					previousWeights = w;
 				endif
	
 			endif

 			epochLearningRate(epochs, :) = learningRate;
	
 			previousEpochError = currentEpochError;

 			testOutputs = evaluateNetwork(testPatterns, testTargets, activationFunction, w, hiddenLayers);
 			testOutputsError = mean(0.5 * ((testTargets - testOutputs) .^ 2));
 			epochTestAccuracy(epochs, :) = testOutputsError;
	
 			plotEpochs(epochs, epochError, '-g', 3);
 			plotEpochs(epochs, epochLearningRate, 'o-c', 3);
			plotEpochs(epochs, epochTestAccuracy, 'm', 3);

			title('Batch backpropagation');
 			legend ({'epochError', 'epochLearningRate', 'testError'});
 			legend hide
 			legend show

 		until(epochError(epochs) <= epsilon || epochs == limitEpochs)

 	elseif (strcmp(trainingType,'incremental'))

 		do
 			backpropagation(patterns, targets, activationFunction, hiddenLayers, 
 				learningRate, derivativeFunction, momentum);
	
 			epochs += 1;
	
 			currentEpochError = mean(0.5 * ((targets - calculatedOutputs) .^ 2));
 			epochError(epochs, :) = currentEpochError;

 			if(epochs == 1)
 				deltaError = 0;
 			else
 				deltaError =  currentEpochError - previousEpochError;
 			endif
	
 			if(adaptativeLearningRate == 1) 
	
 				deltalr = deltaLearningRate(deltaError, learningRate, limitEpochsForLearningRate, 
 					learningRateIncrement, learningRateGeometricDecrement);
	
 				learningRate += deltalr;
	
 				if(deltaError > 0)
 					w = previousWeights;
 					momentum = 0;
 				else
 					previousWeights = w;
 				endif
	
 			endif

 			epochLearningRate(epochs, :) = learningRate;
	
 			previousEpochError = currentEpochError;

 			testOutputs = evaluateNetwork(testPatterns, testTargets, activationFunction, w, hiddenLayers);
 			testOutputsError = mean(0.5 * ((testTargets - testOutputs) .^ 2));
 			epochTestAccuracy(epochs, :) = testOutputsError;
	
 			plotEpochs(epochs, epochError, '-b', 2);
 			plotEpochs(epochs, epochLearningRate, 'o-k', 2);
			plotEpochs(epochs, epochTestAccuracy, 'm', 2);

			title('Incremental backpropagation');
 			legend ({'epochError', 'epochLearningRate', 'testError'});
 			legend hide
 			legend show

 		until(currentEpochError <= epsilon || epochs == limitEpochs)

 	else
 		error('Wrong training type.');
 	endif

 	trainW = w;

	clear global deltaW;
	clear global t;
 	clear global w;
 	clear global k;
 	clear global calculatedOutputs;

 endfunction