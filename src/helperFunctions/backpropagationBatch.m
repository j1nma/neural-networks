function backpropagationBatch(patterns, targets, activationFunction, hiddenLayers, learningRate, derivativeFunction, momentum) 

	global calculatedOutputs;

	global w;

	numberOfOutputs = columns(targets);
	numberOfPatterns = rows(patterns);
	layers = vertcat(hiddenLayers, numberOfOutputs);
	numberOfLayers = rows(layers);

	global h;

	global v;

	global deltaW = cell(numberOfLayers, 1);

	for m = 1:numberOfLayers
		deltaW{m} = zeros(size(w{m}));	
	endfor

	t = 0;

	for p = 1:numberOfPatterns

  		% 2. Choose a pattern and set it to be the entry layer
  		inputPattern = patterns(p,:);
  		target = targets(p,:);

  		h = cell(numberOfLayers, 1); 
		v = cell(numberOfLayers, 1); 

		calculatedOutputs(p, :) = computeOutputs(inputPattern, numberOfLayers, w, layers, activationFunction);

		computeAndAccumulateDeltas(deltaW, target, learningRate, inputPattern, numberOfLayers, w, h, v, layers, activationFunction, derivativeFunction, momentum, t);
		
		t += 1;

	endfor

	updateWeights(deltaW, numberOfLayers);

	clear global h;
  	clear global v;
  	clear global deltaW;

endfunction