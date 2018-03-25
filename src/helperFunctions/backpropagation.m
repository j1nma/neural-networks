function w = backpropagation(patterns, targets, activationFunction, hiddenLayers, learningRate, derivativeFunction, momentum)

	global calculatedOutputs;

	global w;

	% 2. Choose a pattern and set it to be the entry layer
	numberOfPatterns = rows(patterns);
	numberOfOutputs = columns(targets);
	layers = vertcat(hiddenLayers, numberOfOutputs);
	numberOfLayers = rows(layers);

	% Momentum parameters
	deltaW = w;
	t = 0;

  	for p = 1:numberOfPatterns

		% inputPattern es un vector fila
		inputPattern = patterns(p,:);

		% target es un numero (en este problema)
		target = targets(p,:);

		% 3. Propagate output forward for each neuron of each layer upto the output layer
	
		% Cada h{m} es un vector fila
		global h = cell(numberOfLayers,1);
	
		global v = cell(numberOfLayers,1);

		calculatedOutputs(p, :) = computeOutputs(inputPattern, numberOfLayers, w, h, v, layers, activationFunction);
		
		% 4. Calculate deltas between output layer and wanted output

		delta = cell(numberOfLayers, 1);

		delta{numberOfLayers} = arrayfun(derivativeFunction, v{numberOfLayers}) * (target - v{numberOfLayers});

		% 5. Calculate deltas for previous layers propagating errors backwards for each neuron
		% of each layer. m = M, M - 1, ..., 2
		for m = numberOfLayers:-1:2
	
			numberOfNeuronsInLayer = layers(m-1);
	
			for i = 1:numberOfNeuronsInLayer
				% First column of w is bias

    			delta{m-1}(i) = derivativeFunction(v{m-1}(i)) * (w{m}(:, i+1)' * delta{m}');
	
    		endfor

    		% 6. Update all weights
    		for i = 1:rows(w{m})

    		 	for j = 1:columns(w{m})

    		 		if(t == 0)
    					deltaW{m}(i,j) = learningRate * delta{m}(i) * [-1 v{m-1}](j);
    				else
    					momentumTerm = momentum * deltaW{m}(i,j);
    					deltaW{m}(i,j) = (1-momentum) * learningRate * delta{m}(i) * [-1 v{m-1}](j) + momentumTerm;
    				endif
    
    		     	w{m}(i,j) = w{m}(i,j) + deltaW{m}(i,j);
    
    			endfor
    	
    		endfor
	
		endfor
  		
  		% 6. Update first weights
  		for i = 1:rows(w{1}) 

    		for j = 1:columns(w{1})
    		     
    			if(t == 0)
    				deltaW{1}(i,j) = learningRate * delta{1}(i) * inputPattern(j);
    			else
    				momentumTerm = momentum * deltaW{1}(i,j);
    				deltaW{1}(i,j) = (1-momentum) * learningRate * delta{1}(i) * inputPattern(j) + momentumTerm;
    		    endif 

    			w{1}(i,j) = w{1}(i,j) + deltaW{1}(i,j);

    		endfor
	
    	endfor

    	t += 1;
	
	% 7. Back to step 2 for next pattern
  	endfor

endfunction