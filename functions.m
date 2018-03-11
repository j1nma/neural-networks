1;
 
function salidasDeseadas = calcSD(entradas)
for i = 1 : rows(entradas)

	aux = 1;

	for j = 1 : columns(entradas)

		if (entradas(i, j) == (-1))
			aux = aux & 0;
		endif

	endfor

	if (aux == 0)
		salidasDeseadas(i, : ) = (-1);
	elseif
		salidasDeseadas(i, : ) = 1;
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

function bv = biasVector(bias, bits)
	bv = repmat(bias, 1, bits);
endfunction

function o = neuralNetwork(bits)

	w = randomWeights(1,bits)

	a = entryCombinations(bits)

	b = biasVector(0.5, bits)

	o = sign(w*a(1,:)' + b(1));

endfunction