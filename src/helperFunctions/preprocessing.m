function p = preprocessing(patterns, willNormalize)

	% Add bias to patterns
	bias = -1 * ones(rows(patterns),1);
	p = [bias, patterns];

endfunction