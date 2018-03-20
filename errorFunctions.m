1;

function error = calcError()

	global calculatedOutputs;
	global targets;

	error = calculatedOutputs;

	for i = 1 : rows(error)
		error(i) = 0.5*((error(i)-targets(i)).^2);
	endfor

endfunction

function a = limitError()

	global calculatedOutputs;
	global targets;
	global epsilon;

	a = 0;
	i = 0;

	do
		i++;
		quadraticError = 0.5*((calculatedOutputs(i)-targets(i)).^2);
		signo = sign(calculatedOutputs(i)*targets(i));

		if ((quadraticError > epsilon) ||  (signo < 0))
			a = 1;
		endif
		
	until( a == 1 || i == rows(targets))

endfunction

function error = totalError()

	global calculatedOutputs;
	global targets;

	errorVector = calcError();
	error = 0;
	for i = 1 : errorVector
		error += errorVector(i);
	endfor

	error = error/length(errorVector);
endfunction



