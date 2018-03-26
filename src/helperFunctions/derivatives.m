1;

function g = exponentialSigmoid(z)
	g = 1.0 ./ ( 1.0 + e.^(-z));
endfunction

function g = exponentialSigmoidDerivate(z)
	g = z*(1-z);
endfunction

function g = tanhDerivate(z)
	g = 1 - (z*z);
endfunction

global leakyRELUParameter = 0.2;

function g = leakyRELU(z)
	global leakyRELUParameter;

	g = max(leakyRELUParameter*z,z);
endfunction

function g = leakyRELUDerivative(z)
	global leakyRELUParameter;

	if(z < 0)
		g = leakyRELUParameter;
	elseif (z >= 0)
		g = 1;
	endif

endfunction

function f = setDerivative(activationFunction)
	if(activationFunction == @tanh)
		f = @tanhDerivate;
	elseif (activationFunction == @exponentialSigmoid)
		f = @exponentialSigmoidDerivate;
	elseif (activationFunction == @leakyRELU)
		f = @leakyRELUDerivative;
	else
		error('activationFunction not found')
	endif
endfunction