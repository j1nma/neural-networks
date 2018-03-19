
hiddenLayers = [2];

numberOfOutputs = 1;

layers = vertcat(hiddenLayers, numberOfOutputs);

numberOfPatterns = 4;

numberOfLayers = 2;

h = cell(numberOfPatterns, 1);


for p = 1:numberOfPatterns

	h{p} = cell(numberOfLayers, 1); 

	for m = 1:numberOfLayers

			numberOfNeuronsInLayer = layers(m);
			
			for i = 1:numberOfNeuronsInLayer
	
				if(m == 1)
					h{p}{m}(i) = 123;			
				else
					h{p}{m}(i) = 321;
				endif
	
			endfor
	
		endfor

endfor

h