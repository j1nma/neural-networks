# Prevent Octave from thinking that this
# is a function file:

1;

# Simple perceptron

# S 
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
function rw = randomWeights(rows, cols)
	rw = rand(rows,cols);
endfunction

# Xi
function combs = entryCombinations(bits)
#https://stackoverflow.com/questions/15310078/permutations-with-repetition-of-length-different-from-input-vector-in-octave?rq=1

cart  = nthargout ([1:bits], @ndgrid, [-1,1]);

combs = cell2mat (cellfun (@(c) c(:), cart, "UniformOutput", false));

endfunction

function w = neuralnetwork(bits)
rw = randomWeights(1,bits)

combs = entryCombinations(bits)

w = rw * transpose(combs)

endfunction