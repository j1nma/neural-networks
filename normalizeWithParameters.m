function np = normalizeWithParameters(patterns, mP, sP)

	np = bsxfun(@rdivide, bsxfun(@minus, patterns, mP), sP);

endfunction