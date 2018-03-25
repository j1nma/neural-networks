1;

function trainW = mlp(patterns, targets, activationFunction, hiddenLayers, learningRate, limitEpochs, 
	epsilon, trainingType, momentum, adaptativeLearningRate, limitEpochsForLearningRate, 
	learningRateIncrement, learningRateGeometricDecrement)

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
	
			currentEpochError = (sum((targets - calculatedOutputs) .^ 2))/rows(patterns);
			epochError(epochs, :) = currentEpochError;
	
			if(adaptativeLearningRate == 1) 
	
				if(epochs == 1)
					deltaError = 0;
				else
					deltaError =  currentEpochError - previousEpochError;
				endif
	
				deltalr = deltaLearningRate(deltaError, learningRate, limitEpochsForLearningRate, 
					learningRateIncrement, learningRateGeometricDecrement);
	
				learningRate += deltalr;
	
				if(deltaError > 0)
					w = previousWeights;
					momentum = 0;
				else
					previousWeights = w;
				endif

				epochdeltaError(epochs, :) = deltaError;
	
			endif

			epochLearningRate(epochs, :) = learningRate;
	
			epochdeltaError(epochs, :) = deltaError;
	
			previousEpochError = currentEpochError;
	
			plotEpochs(epochs, epochError, 'o-g', 2);
			plotEpochs(epochs, epochLearningRate, 'o-k', 2);
			
			if(adaptativeLearningRate == 1) 
				plotEpochs(epochs, epochdeltaError, 'o-m', 2);
			endif

 			% 	epochAccuracy(epochs, :) = ((sum(abs(targets - calculatedOutputs) <= 0.3))/rows(patterns));
				% epochAccuracy(epochs);
 			% 	plotEpochs(epochs, epochAccuracy, 'k', 3);

 			% Shuffle patterns
 			patterns = randomSubset(patterns, 100.0);

 		until(epochError(epochs) <= epsilon || epochs == limitEpochs)

 	elseif (strcmp(trainingType,'incremental'))

 		do
 			backpropagation(patterns, targets, activationFunction, hiddenLayers, 
 				learningRate, derivativeFunction, momentum);
	
 			epochs += 1;
	
 			currentEpochError = mean(0.5 * ((targets - calculatedOutputs) .^ 2));
 			epochError(epochs, :) = currentEpochError;

 			% if(epochs == 1)
 				% deltaError = 0;
 			% else
 				deltaError =  currentEpochError - previousEpochError;
 			% endif
	
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

 				epochdeltaError(epochs, :) = deltaError;
	
 			endif

 			epochLearningRate(epochs, :) = learningRate;
	
 			previousEpochError = currentEpochError;
	
 			plotEpochs(epochs, epochError, '-b', 2);
 			plotEpochs(epochs, epochLearningRate, 'o-k', 2);

 			if(adaptativeLearningRate == 1) 
 				plotEpochs(epochs, epochdeltaError, 'o-r', 2);
			endif
 			% 	epochAccuracy(epochs, :) = ((sum(abs(targets - calculatedOutputs) <= 0.3))/rows(patterns));
				% epochAccuracy(epochs);
 			% 	plotEpochs(epochs, epochAccuracy, 'm', 3);

 			% Shuffle patterns
 			% patterns = randomSubset(patterns, 100.0);

 			w

 		until(currentEpochError <= epsilon || epochs == limitEpochs)

 		abs(targets - calculatedOutputs)

 	else
 		error('Wrong training type.');
 	endif

 	trainW = w;

 	whos global

	clear global deltaW;
	clear global t;
 	clear global w;
 	clear global k;
 	clear global calculatedOutputs;

 endfunction