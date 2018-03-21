function rs = randomSubset(patterns, percentage)

	if(percentage <= 0.0 || percentage > 1.0)
		error('Wrong percentage. (0.0-1.0]')
	endif

rp = randperm(length(patterns)); 

rts = rp(1:ceil((length(patterns)*percentage)));

rs = patterns(rts, :);

endfunction