1;

function updateLearningRate(error)

	global epsilon;
	global learningRate;
	global numberOfLayers;
	global w;

	% calculo el error promedio de las salidas

	calcError = 0;

	if (length(error) != 1)

		for i = 1: length(error)
			calcError += error(i);
		endfor

		calcError = calcError/length(error);
	else
		calcError = error;
	endif

	% guardo el learning rate anterior y calculo el nuevo

	aux = calcError/epsilon;

	prevLearningRate = learningRate;
	
	learningRate = exp(-1/aux);


	% si el learning rate anterior y el nuevo son iguales, entonces me encuentro en un minimo. 
	if (abs(prevLearningRate - learningRate) < 0.000000001)

		disp('ESTOY EN UN MINIMO');

		% para salir del minimo local vuelvo a setear los pesos
		for m = 1 : numberOfLayers

	    		for i = 1:rows(w{m})

	    		  for j = 1:columns(w{m})
	    
	    		      w{m}(i,j) = rand()-0.5;
	    
	    		  endfor
	    
	    		endfor

		endfor

	endif

endfunction
		