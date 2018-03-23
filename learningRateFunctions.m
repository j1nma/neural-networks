1;

function learningRate = updateLearningRate(currentPatternError, hiddenLayers, learningRate, numberOfInputsIncludedBias, numberOfOutputs, epsilon)

	global w;

	% calculo el error promedio de las salidas

	calcError = 0;

	if (length(currentPatternError) != 1)

		for i = 1: length(currentPatternError)
			calcError += currentPatternError(i);
		endfor

		calcError = calcError/length(currentPatternError);
	else
		calcError = currentPatternError;
	endif

	% guardo el learning rate anterior y calculo el nuevo
	calcError;

	aux = calcError/epsilon;

	prevLearningRate = learningRate;
	
	learningRate = exp(-1/aux);


	% si el learning rate anterior y el nuevo son iguales, entonces me encuentro en un minimo. 
	if (abs(prevLearningRate - learningRate) < 0.000000001)

		% disp('ESTOY EN UN MINIMO');

		% para salir del minimo local vuelvo a setear los pesos
		w = randomInitialWeights(hiddenLayers, numberOfInputsIncludedBias, numberOfOutputs);

	endif

endfunction
		