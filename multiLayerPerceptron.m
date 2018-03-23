1;

learningRateFunctions

function w = mlp(patterns, targets, activationFunction, hiddenLayers, learningRate, limitEpochs, 
	epsilon, trainingType, momentum)

	global calculatedOutputs;

	global w;

	global numberOfLayers;

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
			w = backpropagationBatch(patterns, targets, activationFunction, hiddenLayers, 
				learningRate, derivativeFunction, momentum);
	
			epochs += 1;

			printf(disp(epochs));
	
			% learningRate = updateLearningRate(calcError(targets), hiddenLayers, learningRate, 
				% numberOfInputsIncludedBias, numberOfOutputs, epsilon)
	
			epochError(epochs, :) = (0.5 * sum((targets - calculatedOutputs) .^ 2))/rows(patterns);
			epochError(epochs)

			figure(2);
			plot(1:epochs, epochError, 'o-g');
			grid on;
			hold on;
			more off;
			drawnow()

		until(epochError(epochs) <= epsilon || epochs == limitEpochs)

		% figure(2);
		% plot(1:epochs, epochError,'o-b');
		% grid on;
		% hold on;

	elseif (strcmp(trainingType,'incremental'))

		do
			w = backpropagation(patterns, targets, activationFunction, hiddenLayers, 
				learningRate, derivativeFunction, momentum);
	
			epochs += 1;
	
			printf(disp(epochs));
	
			learningRate = updateLearningRate(calcError(targets), hiddenLayers, learningRate, 
				numberOfInputsIncludedBias, numberOfOutputs, epsilon)
	
			epochError(epochs, :) = (0.5 * sum((targets - calculatedOutputs) .^ 2))/rows(patterns);
			epochError(epochs)

			figure(2);
			plot(1:epochs, epochError, 'o-b');
			grid on;
			hold on;
			more off;
			drawnow()
		
		until(epochError(epochs) <= epsilon || epochs == limitEpochs)

	else
		error('Wrong training type');
	endif		

	% plot3(patterns(:,2),patterns(:,3),calculatedOutputs,'b*');

endfunction