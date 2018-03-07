function salidasDeseadas = calcSD(entradas)
for i = 1 : rows(entradas)

	aux = 1;

	for j = 1 : columns(entradas)

		if (entradas(i, j) == (-1))
			aux = aux & 0;
		endif

	endfor

	if (aux == 0)
		salidasDeseadas(i, : ) = -1;
	elseif
		salidasDeseadas(i, : ) = 1;
	endif

endfor

endfunction