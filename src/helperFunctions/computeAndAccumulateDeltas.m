function ans = computeAndAccumulateDeltas(deltaW, target, learningRate, inputPattern, numberOfLayers, w, h, v, layers, activationFunction, derivativeFunction, momentum, t);

		global deltaW;

		global h;

		global v;

		delta = cell(numberOfLayers, 1);

		% 4. Calculate deltas between output layer and wanted output

		delta{numberOfLayers} = arrayfun(derivativeFunction, v{numberOfLayers}) * (target - v{numberOfLayers});

		% 5. Calculate deltas (gradients) for previous layers propagating errors backwards for each neuron
		% of each layer. m = M, M - 1, ..., 2
		for m = numberOfLayers:-1:2
	
			numberOfNeuronsInLayer = layers(m-1);
	
			for i = 1:numberOfNeuronsInLayer

    			delta{m-1}(i) = derivativeFunction(v{m-1}(i)) * (w{m}(:, i+1)' * delta{m}');
	
    		endfor
	
    		% 6. Compute delta for all weights
    		for i = 1:rows(w{m})

    		 	for j = 1:columns(w{m})

    		 		if(t == 0)
    					deltaW{m}(i,j) += learningRate * delta{m}(i) * [-1 v{m-1}](j);
    				else
    					momentumTerm = momentum * deltaW{m}(i,j);
    					deltaW{m}(i,j) += (1-momentum)*learningRate * delta{m}(i) * [-1 v{m-1}](j) + momentumTerm;
    				endif
        
    			endfor
    	
    		endfor
	
		endfor
  		
  		% 6. Update first weights
  		for i = 1:rows(w{1}) 

    		for j = 1:columns(w{1})
    		     
    			if(t == 0)
    				deltaW{1}(i,j) += learningRate * delta{1}(i) * inputPattern(j);
    			else
    				momentumTerm = momentum * deltaW{1}(i,j);
    				deltaW{1}(i,j) += (1-momentum)*learningRate * delta{1}(i) * inputPattern(j) + momentumTerm;
    		    endif 

    		endfor
	
    	endfor

endfunction