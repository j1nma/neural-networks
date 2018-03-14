1;
 
function wantedOutputs = calcWantedOutputs(inputs, operation)
for i = 1 : rows(inputs)

	aux = inputs(i, 1);

	for j = 1 : columns(inputs)

		if (inputs(i, j) == (-1))
			aux = feval(operation,aux,0);
		endif

	endfor

	if (aux == 0)
		wantedOutputs(i, : ) = (-1);
	else
		wantedOutputs(i, : ) = 1;
	endif

endfor

endfunction

# Initial W
function rw = randomWeights(outerNeurons, bits)
	rw = rand(outerNeurons, bits);
endfunction

# Xi
function combs = entryCombinations(bits)
#https://stackoverflow.com/questions/15310078/permutations-with-repetition-of-length-different-from-input-vector-in-octave?rq=1

	cart  = nthargout ([1:bits], @ndgrid, [-1,1]);

	combs = cell2mat (cellfun (@(c) c(:), cart, "UniformOutput", false));

endfunction


function w = neuralNetwork(bits, learningRate, activationFunc, operation, limitEpochs)

	w = randomWeights(1,bits+1) - 0.5;

	a = entryCombinations(bits);

	s = calcWantedOutputs(a, operation);

	bias = -1*ones(pow2(bits),1);

	a = horzcat(a,bias)

	epochs = 0;

	o = zeros(1,pow2(bits));

	errEpochs = [];

	do

		error = 0;
		
		for i = randperm(pow2(bits)) 

			o(i) = feval(activationFunc, w*a(i,:)');

			delta = s(i) - o(i);

			if(delta != 0)

				error = 1;

				for k = 1:columns(a(i,:))
					w(k) += learningRate*delta*a(i,k);
				endfor

			endif

		endfor

		% errEpochs = vertcat(errEpochs, sum(s' - feval(activationFunc, w*a')));

		epochs += 1;

	until (error == 0 || epochs == limitEpochs);

	% line([1:epochs], errEpochs);

  	if(epochs == limitEpochs)
  		disp('Limit epochs reached!');
  	endif

  	printf('Runs: %d\n', epochs);

endfunction