1;

function w = backpropagationWithOldWeigths(patterns, targets, activationFunction, hiddenLayers, derivativeFunction, learningRate)

	global w;

	% w;

	% 1. Initialize weights with small random values
	
	numberOfInputsIncludedBias = columns(patterns);

	numberOfOutputs = columns(targets);

	% 2. Choose a pattern and set it to be the entry layer

	numberOfPatterns = rows(patterns);

	layers = vertcat(hiddenLayers, numberOfOutputs);

	numberOfLayers = rows(layers);

  	for p = 1:numberOfPatterns

		inputPattern = patterns(p,:);
		% inputPattern es un vector fila

		target = targets(p,:);
		% target es un numero (en este problema)

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
		% if(isequaln(calculatedOutputs(p, :), NaN))
		% 	keyboard();
		% endif
		% 4. Calculate deltas between output layer and wanted output

		delta = cell(numberOfLayers, 1);

		delta{numberOfLayers} = arrayfun(derivativeFunction, h{numberOfLayers}) * (target - v{numberOfLayers});

	% 5. Calculate deltas for previous layers propagating errors backwards for each neuron
	% of each layer. m = M, M - 1, ..., 2
		

	for m = numberOfLayers:-1:2

			for i = 1:layers(m-1)
				% First column of w is bias

    			delta{m-1}(i) = derivativeFunction(h{m-1}(i)) * (w{m}(:, i+1)' * delta{m}');
    			keyboard();

    		endfor

    		% 6. Update all weights
    		for i = 1:rows(w{m})

    		  for j = 1:columns(w{m})
    
    		      deltaW = learningRate * delta{m}(i) * [-1 v{m-1}](j);
    
    		      w{m}(i,j) = w{m}(i,j) + deltaW;

    			%if(isequaln(w{m}(i,j),Inf))
					% keyboard();
				% endif
    
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

function w = backpropagation(calculatedOutputs, patterns, targets, activationFunction, hiddenLayers, derivativeFunction, learningRate)

	global calculatedOutputs;

	% 1. Initialize weights with small random values
	
	numberOfInputsIncludedBias = columns(patterns);

	numberOfOutputs = columns(targets);

	w = randomInitialWeights(hiddenLayers, numberOfInputsIncludedBias, numberOfOutputs);

	% keyboard();

	% 2. Choose a pattern and set it to be the entry layer

	numberOfPatterns = length(patterns);

	layers = vertcat(hiddenLayers, numberOfOutputs);

	numberOfLayers = rows(layers);

  	for p = 1:numberOfPatterns

		inputPattern = patterns(p,:);
		% inputPattern es un vector fila

		target = targets(p,:);
		% target es un numero (en este problema)

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
		if(isequaln(calculatedOutputs(p, :), NaN))
			keyboard();
		endif

		% 4. Calculate deltas between output layer and wanted output

		delta = cell(numberOfLayers,1);

		delta{numberOfLayers} = arrayfun(derivativeFunction, h{numberOfLayers}) * (target - v{numberOfLayers});


		% 5. Calculate deltas for previous layers propagating errors backwards for each neuron
		% of each layer. m = M, M - 1, ..., 2
		

		for m = numberOfLayers:-1:2


			for i = 1:layers(m-1)
				% First column of w is bias

    			delta{m-1}(i) = derivativeFunction(h{m-1}(i)) * (w{m}(:, i+1)' * delta{m}');

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

function w = mlp(patterns, targets, activationFunction, hiddenLayers, learningRate)

	derivativeFunction = setDerivative(activationFunction);

	% Add bias to patterns
	bias = -1 * ones(length(patterns),1);
	patterns = [bias, patterns];

	if(isrow(hiddenLayers))
		hiddenLayers = hiddenLayers';
	endif

	global calculatedOutputs = zeros(rows(targets),1);

	global w;

	epochs = 2;

	w = backpropagation(calculatedOutputs, patterns, targets, activationFunction, hiddenLayers, derivativeFunction, learningRate);

	for i = 1:epochs

		w = backpropagationWithOldWeigths(patterns, targets, activationFunction, hiddenLayers, derivativeFunction, learningRate);

	end

	calculatedOutputs

	% numberOfInputsIncludedBias = columns(patterns);
	% numberOfOutputs = columns(targets);
	% global w = randomInitialWeights(hiddenLayers, numberOfInputsIncludedBias, numberOfOutputs)

	% keyboard();

	% global calculatedOutputs = zeros(rows(targets),1);

	% for i = 1:5
		
	% 	i
	% 	w = backpropagationWithOldWeigths(patterns, targets, activationFunction, hiddenLayers, derivativeFunction, learningRate, calculatedOutputs);
			
	% endfor

	% 	x=patterns(:,2);
	% 	y=patterns(:,3);
	% 	z=calculatedOutputs(:,1)

	% 	plot3(x,y,z,'rx')

endfunction