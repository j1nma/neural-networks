function w = randomInitialWeights(hiddenLayers, numberOfInputsIncludedBias, numberOfOutputs)
	
	numberOfHiddenLayers = length(hiddenLayers);

	% + 1 for output layer
	w = cell(numberOfHiddenLayers + 1, 1);

	for i = 1:numberOfHiddenLayers

		numberOfNeuronsInHiddenLayer = hiddenLayers(i);

			if(i == 1)
				w{i} = rand(numberOfNeuronsInHiddenLayer, numberOfInputsIncludedBias) - 0.5;
			else
				%  + 1 for bias
				w{i} = rand(numberOfNeuronsInHiddenLayer, 1 + hiddenLayers(i-1)) - 0.5;
			endif

	endfor

	% Output layer
	w{numberOfHiddenLayers + 1} = rand(numberOfOutputs, 1 + hiddenLayers(numberOfHiddenLayers)) - 0.5;

endfunction