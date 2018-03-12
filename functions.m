1;
 
function wantedOutputs = calcWantedOutputs(inputs)
for i = 1 : rows(inputs)

	aux = 1;

	for j = 1 : columns(inputs)

		if (inputs(i, j) == (-1))
			aux = aux & 0;
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


function w = neuralNetwork(bits, learningRate, activationFunc, limitIterations)

	w = randomWeights(1,bits+1) - 0.5;

	a = entryCombinations(bits);

	s = calcWantedOutputs(a);

	bias = -1*ones(pow2(bits),1);

	a = horzcat(a,bias);

	error = 0;

	iterations = 0;


	do
		
		for i = 1:pow2(bits) 

			o(i) = feval(activationFunc, w*a(i,:)');

			delta = s(i) - o(i);

			if (delta != 0) 
					error = 1;
					deltaW = learningRate*delta*a(i,:)
					w += deltaW;
			else
					error = 0;
			endif

			iterations += 1;

			if (iterations == limitIterations)
				break;
			endif

		endfor

	until (error == 0 || iterations == limitIterations);


  	if(iterations == limitIterations)
  		disp('Limit iterations reached!');
  		disp(w);
  	else
  		printf('Runs: %d\n', iterations);
  	endif

endfunction