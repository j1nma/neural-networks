function W = randomInitialWeights(layers, inputs)
	
	numberOfLayers = rows(layers);

	W = cell(numberOfLayers, 1);

	for i = 1:numberOfLayers

		numberOfNeuronsInLayer = layers(i);

			if(i == 1)
				W{i} = rand(numberOfNeuronsInLayer, 1 + inputs) - 0.5;
			else
				W{i} = rand(numberOfNeuronsInLayer, 1 + layers(i-1)) - 0.5;
			endif

	endfor

endfunction