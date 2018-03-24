function deltalr = deltaLearningRate(deltaError, learningRate, k, limitEpochsForLearningRate)

	global k;

	a = 0.15; 
	b = 0.07;

	if (deltaError >= 0) 

		k = 0;

		deltalr = -b*learningRate

	elseif(deltaError < 0)

		k += 1;

		if (k == limitEpochsForLearningRate)

			deltalr = a;

			k = 0;

		else

			deltalr = 0;

		endif

	else

		k = 0;

		deltalr = 0;

	endif

endfunction