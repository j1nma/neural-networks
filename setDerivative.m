1;

function g = exponentialSigmoid(z)
	g = 1.0 ./ ( 1.0 + e.^(-z));
endfunction

function g = exponentialSigmoidDerivate(z)
	g = z*(1-z);
endfunction

function g = tanhDerivate(z)
	g = 1 - z*z;
endfunction

function f = setDerivative(activationFunction)
	if(activationFunction == @tanh)
		f = @tanhDerivate;
	elseif (activationFunction == @exponentialSigmoid)
		f = @exponentialSigmoidDerivate;
	endif
endfunction