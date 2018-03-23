1;

learningRateFunctions

function w = mlp(patterns, targets, activationFunction, hiddenLayers, learningRate, limitEpochs, epsilon, trainingType, momentum)

	global calculatedOutputs;

	global w;

	global numberOfLayers;

	global lr = learningRate;

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

	prevW = w;

	prevec = 0;

	if(strcmp(trainingType,'batch'))
		do
			w = backpropagationBatch(patterns, targets, activationFunction, hiddenLayers, learningRate, derivativeFunction);

			epochs += 1;

			epochError(epochs, :) = 0.5 * sum((targets - calculatedOutputs) .^ 2);

			ce = quadraticError(calculatedOutputs,targets);

			learningRate = updateLearningRate(prevW, prevec,ce,learningRate);

			lr = [lr learningRate];

			prevW = w;

			prevec = quadraticError(calculatedOutputs,targets);
		

		until((limitError(calculatedOutputs,targets, epsilon) == 0) || epochs == limitEpochs)

		figure(2);
		plot(lr,1:length(lr),'r');
		grid on;
		hold on;

		figure(3);
		plot(epochError,1:epochs,'r');
		grid on;
		hold on;

	elseif (strcmp(trainingType,'incremental'))

		do

			w = backpropagation(patterns, targets, activationFunction, hiddenLayers, learningRate, derivativeFunction, momentum);

			epochs += 1;

			epochError(epochs, :) = 0.5 * sum((targets - calculatedOutputs) .^ 2);

			ce = quadraticError(calculatedOutputs,targets);

			learningRate = updateLearningRate(prevW, prevec,ce,learningRate);

			lr = [lr learningRate];

			prevW = w;

			prevec = quadraticError(calculatedOutputs,targets);
		
		until((limitError(calculatedOutputs,targets, epsilon) == 0) || epochs == limitEpochs)

		figure(2);
		plot(1:length(lr),lr,'g');
		grid on;
		hold on;

		figure(3);
		plot(epochError,1:epochs,'g');
		grid on;
		hold on;

	else
		error('Wrong training type');
	endif		


	% plot3(patterns(:,2),patterns(:,3),calculatedOutputs,'b*');

endfunction