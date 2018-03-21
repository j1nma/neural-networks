function calculatedOutputs = evaluateNetwork(patterns, targets, activationFunction, w, hiddenLayers)

	if(isrow(hiddenLayers))
		hiddenLayers = hiddenLayers';
	endif
	
	numberOfPatterns = rows(patterns);
	numberOfOutputs = columns(targets);
	layers = vertcat(hiddenLayers, numberOfOutputs);
	numberOfLayers = rows(layers);
	
	calculatedOutputs = zeros(columns(targets),1);
	
	for p = 1:rows(patterns)

		inputPattern = patterns(p,:);

		target = targets(p,:);

		% Propagate output forward for each neuron of each layer upto the output layer
		h = cell(numberOfLayers,1);
	
		v = cell(numberOfLayers,1); 
		
		for m = 1:numberOfLayers

			numberOfNeuronsInLayer = layers(m);
			
			for i = 1:numberOfNeuronsInLayer
	
				if(m == 1)
					h{m}(i) = w{m}(i,:) * inputPattern';			
				else
					h{m}(i) = w{m}(i,:) * [-1 v{m-1}]';
				endif
	
				v{m}(i) = activationFunction( h{m}(i) );
	
			endfor
	
		endfor

		calculatedOutputs(p,:) = v{numberOfLayers};
	
	endfor

endfunction