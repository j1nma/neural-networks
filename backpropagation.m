function w = backpropagation(patterns, targets, activationFunction, hiddenLayers, derivativeFunction)

	global calculatedOutputs;

	global w;

	global learningRate;

	% w;

	numberOfOutputs = columns(targets);

	% 2. Choose a pattern and set it to be the entry layer
	numberOfPatterns = rows(patterns);
	layers = vertcat(hiddenLayers, numberOfOutputs);
	numberOfLayers = rows(layers);

  	for p = 1:numberOfPatterns

		% inputPattern es un vector fila
		inputPattern = patterns(p,:);

		% target es un numero (en este problema)
		target = targets(p,:);

		% 3. Propagate output forward for each neuron of each layer upto the output layer
	
		% Cada h{m} es un vector fila
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
		
		% 4. Calculate deltas between output layer and wanted output

		delta = cell(numberOfLayers, 1);

		delta{numberOfLayers} = arrayfun(derivativeFunction, h{numberOfLayers}) * (target - v{numberOfLayers});

	% 5. Calculate deltas for previous layers propagating errors backwards for each neuron
	% of each layer. m = M, M - 1, ..., 2
	for m = numberOfLayers:-1:2

			numberOfNeuronsInLayer = layers(m-1);

			for i = 1:numberOfNeuronsInLayer
				% First column of w is bias

    			delta{m-1}(i) = derivativeFunction(h{m-1}(i)) * (w{m}(:, i+1)' * delta{m}');
    			% keyboard();

    		endfor

    		% 6. Update all weights
    		for i = 1:rows(w{m})

    		  for j = 1:columns(w{m})
    
    		      deltaW = learningRate * delta{m}(i) * [-1 v{m-1}](j);
    
    		      w{m}(i,j) = w{m}(i,j) + deltaW;
    
    		  endfor
    
    		endfor

		endfor
  	
  		% 6. Update first weights
  		for i= 1:rows(w{1}) 

    		 for j= 1:columns(w{1})
    		      
    		     deltaW = learningRate * delta{1}(i) * inputPattern(j);
    		      
    		     w{1}(i,j) = w{1}(i,j) + deltaW;

    		endfor

    	endfor

		% 7. Back to step 2 for next pattern
  	endfor

endfunction