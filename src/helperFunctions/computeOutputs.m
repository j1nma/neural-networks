function ans = computeOutputs(pattern, numberOfLayers, w, layers, activationFunction)

	global h;

	global v;

		% 3. Propagate output forward for each neuron of each layer upto the output layer

		for m = 1:numberOfLayers

			numberOfNeuronsInLayer = layers(m);
			
			for i = 1:numberOfNeuronsInLayer

				if(m == 1)
					h{m}(i) = w{m}(i,:) * pattern';			
				else
					h{m}(i) = w{m}(i,:) * [-1 v{m-1}]';
				endif

				if (m == numberOfLayers)
					v{m}(i) = tanh(h{m}(i));
				else
					v{m}(i) = activationFunction( h{m}(i) );
				endif

				% v{m}(i) = activationFunction( h{m}(i) );

			endfor

		endfor

		ans = v{numberOfLayers};

endfunction
