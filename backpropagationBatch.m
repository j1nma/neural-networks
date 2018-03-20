function w = backpropagationBatch(patterns, targets, activationFunction, hiddenLayers, derivativeFunction)

	global calculatedOutputs;

	global w;

	global learningRate;

	numberOfOutputs = columns(targets);
	numberOfPatterns = rows(patterns);
	layers = vertcat(hiddenLayers, numberOfOutputs);
	numberOfLayers = rows(layers);

	h = cell(numberOfPatterns, 1);
	v = cell(numberOfPatterns, 1); 

  	for p = 1:numberOfPatterns

  		% 2. Choose a pattern and set it to be the entry layer
		% inputPattern es un vector fila
		inputPattern = patterns(p,:);

		% 3. Propagate output forward for each neuron of each layer upto the output layer
		h{p} = cell(numberOfLayers, 1); 
		v{p} = cell(numberOfLayers, 1); 

		for m = 1:numberOfLayers

			numberOfNeuronsInLayer = layers(m);
			
			for i = 1:numberOfNeuronsInLayer
	
				if(m == 1)
					h{p}{m}(i) = w{m}(i,:) * inputPattern';			
				else
					h{p}{m}(i) = w{m}(i,:) * [-1 v{p}{m-1}]';
				endif

				v{p}{m}(i) = activationFunction( h{p}{m}(i) );
	
			endfor
	
		endfor

		calculatedOutputs(p,:) = v{p}{numberOfLayers};
		
  	endfor

  	delta = cell(numberOfPatterns, 1);

  	for p = 1:numberOfPatterns

  		% inputPattern es un vector fila
		inputPattern = patterns(p,:);

  		% target es un numero (en este problema)
		target = targets(p,:);
		
		% 4. Calculate deltas between output layer and wanted output
		delta{p} = cell(numberOfLayers, 1);

		delta{p}{numberOfLayers} = arrayfun(derivativeFunction, h{p}{numberOfLayers}) * (target - v{p}{numberOfLayers});

		% 5. Calculate deltas for previous layers propagating errors backwards for each neuron
		% of each layer. m = M, M - 1, ..., 2
		for m = numberOfLayers:-1:2

			numberOfNeuronsInLayer = layers(m-1);

			for i = 1:numberOfNeuronsInLayer

    			delta{p}{m-1}(i) = derivativeFunction(h{p}{m-1}(i)) * (w{m}(:, i+1)' * delta{p}{m}');

    		endfor

    		% 6. Update all weights
    		for i = 1:rows(w{m})

    		  for j = 1:columns(w{m})
    
    		      deltaW = learningRate * delta{p}{m}(i) * [-1 v{p}{m-1}](j);
    
    		      w{m}(i,j) = w{m}(i,j) + deltaW;
    
    		  endfor
    
    		endfor
	
		endfor
  		
  		% 6. Update first weights
  		for i = 1:rows(w{1}) 

    		for j = 1:columns(w{1})
    	      
    	    	deltaW = learningRate * delta{p}{1}(i) * inputPattern(j);
    	      
    	    	w{1}(i,j) = w{1}(i,j) + deltaW;

    		endfor

    	endfor
	
  	endfor

endfunction