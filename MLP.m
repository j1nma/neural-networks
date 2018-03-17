1;

function w = backpropagation(bits, patterns, targets, activationFunction, hiddenLayers, outputs)

	bias = -1 * ones(pow2(bits),1);
	patterns = [bias, patterns];

% 1. Initialize weights with small random values
	
	% hiddenLayers vector always passed as column Lx1
	if(isrow(hiddenLayers))
		hiddenLayers = hiddenLayers';
	endif

	w = randomInitialWeights(hiddenLayers, outputs);

% 2. Choose a pattern and set it to be the entry layer
	randomIndex = randi(rows(patterns));
	inputPattern = patterns(randomIndex,:);
	target = targets(randomIndex,:);

% 3. Propagate output forward for each neuron of each layer upto the output layer

	numberOfLayers = rows(hiddenLayers);

	h = cell(numberOfLayers,1);

	v = cell(numberOfLayers,1);
	
	for m = 1:numberOfLayers
		
		for i = 1:hiddenLayers(m)

			if(m == 1)
				h{m}(i) = w{m}(i) * inputPattern';			
			else
				h{m}(i) = w{m}(i) * v{m-1};
			endif

			v{m}(i) = activationFunction( h{m}(i) );

		endfor

	endfor

% 4. Calculate deltas between output layer and wanted output

	deltas = cell(numberOfLayers,1);

	delta{numberOfLayers} = derivativeFunction( h{numberOfLayers} ) * (target - v{m});


% 5. Calculate deltas for previous layers propagating errors backwards for each neuron
% of each layer. m = M, M - 1, ..., 2
% TODO: delta de umbrales no se calcula cr

	for m = numberOfLayers:2
		
		delta{m-1} = derivativeFunction( h{m} ) * (w{m}(i) * delta{m});

	endfor

% 6. Update all weights


% 7. Back to step 2 for next pattern
endfor

endfunction

function w = mlp(bits, learningRate, activationFunction, operation, limitEpochs, trainingSet, hiddenLayers, outputs)
	
	derivativeFunction = setDerivative(activationFunction);
	
	w = backpropagation(bits, trainingSet(0), trainingSet(1), activationFunction, hiddenLayers, outputs, derivativeFunction);

endfunction