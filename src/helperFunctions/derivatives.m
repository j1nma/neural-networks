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

function g = modifiedTanh(z)
	g = 1.7159 * tanh((2/3)*z);
endfunction

function g = modifiedTanhDerivate(z)
	g = (0.6667/1.7159) * (1.7159 - z)*(1.7159 + z);
endfunction

function f = setDerivative(activationFunction)
	if(activationFunction == @tanh)
		f = @tanhDerivate;
	elseif (activationFunction == @exponentialSigmoid)
		f = @exponentialSigmoidDerivate;
	elseif (activationFunction == @modifiedTanh)
		f = @modifiedTanhDerivate;
	else
		error('activationFunction not found')
	endif
endfunction