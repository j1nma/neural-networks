1;

function g = exponentialSigmoid(z)
	g = 1.0 ./ ( 1.0 + e.^(-z));
endfunction

function g = exponentialSigmoidDerivate(z)
	g = exponentialSigmoid(z)*(1-exponentialSigmoid(z));
endfunction

function g = tanhDerivate(z)
	g = 1 - (tanh(z) * tanh(z));
endfunction

function f = setDerivative(activationFunction)
	if(activationFunction == @tanh)
		f = @tanhDerivate;
	elseif (activationFunction == @exponentialSigmoid)
		f = @exponentialSigmoidDerivate;
	else
		error('activationFunction not found')
	endif
endfunction