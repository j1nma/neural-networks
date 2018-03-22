function ans = updateWeights(deltaW, w, numberOfLayers)
	
	global w;

	for m = 1:numberOfLayers
		w{m} += deltaW{m};
	endfor

endfunction