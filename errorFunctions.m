1;

function error = calcError(calculatedOutputs, wantedOutputs)
	global calculatedOutputs;
	error = calculatedOutputs;

	for i = 1 : rows(error)
		error(i) = 0.5*((error(i)-wantedOutputs(i)).^2);
	endfor

endfunction

function a = limitError(epsilon ,error)

	a = 0;
	i = 1;

	do
		if ( error(i) > epsilon)
			a = 1;
		endif
		i++;
	until( a == 1 || i == rows(error))

endfunction

function error = totalError(calculatedOutputs, wantedOutputs)
	errorVector = calcError(calculatedOutputs,wantedOutputs);
	error = 0;
	for i = 1 : errorVector
		error += errorVector(i);
	endfor
endfunction

