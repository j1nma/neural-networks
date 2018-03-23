1;

function ce = quadraticError(calculatedOutputs,targets)
	ce = 0;
	for i = 1 : rows(targets)
		ce += (calculatedOutputs(i)-targets(i)).^2;
	endfor
	ce *= 0.5/rows(targets);

endfunction

function a = limitError(calculatedOutputs,targets, epsilon)

	a = 0;
	i = 0;

	do
		i++;
		ce = 0.5*(calculatedOutputs(i)-targets(i))*(calculatedOutputs(i)-targets(i));
		signo = sign(calculatedOutputs(i)*targets(i));

		if ((ce > epsilon) ||  (signo < 0))
			a = 1;
		endif
		
	until( a == 1 || i == rows(targets))

endfunction

