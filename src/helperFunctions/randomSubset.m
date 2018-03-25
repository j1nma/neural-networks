function rs = randomSubset(patterns, percentage)

	if(percentage <= 0.0 || percentage > 100.0)
		error('Wrong percentage. (0.0-100.0]')
	endif

rp = randperm(length(patterns));

rts = rp(1:ceil((length(patterns)*(percentage/100.0))));

rs = patterns(rts, :);

endfunction