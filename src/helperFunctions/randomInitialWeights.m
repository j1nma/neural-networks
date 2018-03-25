function randomInitialWeights(hiddenLayers, numberOfInputsIncludedBias, numberOfOutputs)
	
	global w;

	numberOfHiddenLayers = length(hiddenLayers);

	% + 1 for output layer
	w = cell(numberOfHiddenLayers + 1, 1);

	for i = 1:numberOfHiddenLayers

		numberOfNeuronsInHiddenLayer = hiddenLayers(i);

			if(i == 1)
				fanInInputNeurons = numberOfInputsIncludedBias;
				inputRangeLimit = 1/sqrt(fanInInputNeurons);
				w{i} = rand(numberOfNeuronsInHiddenLayer, fanInInputNeurons) - inputRangeLimit;
			else
				
				%  + 1 for bias
				fanInHiddenNeurons = 1 + hiddenLayers(i-1);
				hiddenRangeLimit = 1/sqrt(fanInHiddenNeurons);
				w{i} = rand(numberOfNeuronsInHiddenLayer, fanInHiddenNeurons) - hiddenRangeLimit;
			endif

	endfor

	% Output layer
	fanInOuterNeurons = 1 + hiddenLayers(numberOfHiddenLayers);
	outerRangeLimit = 1/sqrt(fanInOuterNeurons);
	w{numberOfHiddenLayers + 1} = rand(numberOfOutputs, fanInOuterNeurons) - outerRangeLimit;

endfunction