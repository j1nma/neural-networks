1;

function error = calcError(calculatedOutputs, wantedOutputs)
	global calculatedOutputs;
	error = 0.5*pow2(calculatedOutputs-wantedOutputs);

endfunction

function a = limitError(percentage,error)

	a = 0;
	i = 1;

	do
		if ( error(i) > percentage)
			a = 1;
		endif
		i++;
	until( a == 1 || i == columns(error))

endfunction

