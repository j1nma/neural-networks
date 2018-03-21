function [np, mP, sP] = normalizePatterns(patterns)

	mP = mean(patterns,1); 
	mP(1) = 0; 

	sP = std(patterns,[],1); 
	sP(1) = 1; 

	np = bsxfun(@rdivide, bsxfun(@minus, patterns, mP), sP);

endfunction