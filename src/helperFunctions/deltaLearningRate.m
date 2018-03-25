function deltalr = deltaLearningRate(deltaError, learningRate, limitEpochsForLearningRate, learningRateIncrement, learningRateGeometricDecrement)

	global k;

	a = learningRateIncrement; 
	b = learningRateGeometricDecrement; 

	if (deltaError > 0.002) 

		k = 0;

		deltalr = -b*learningRate;
		printf('%s learningRate by: %d\n', 'Decremented', deltalr);

	elseif(deltaError < 0)

		k += 1;

		if (k == limitEpochsForLearningRate)
			deltalr = a;
			k = 0;
			printf('%s learningRate by: %d\n', 'Incremented', deltalr);
		else
			deltalr = 0;
		endif

	else

		k = 0;
		deltalr = 0;
		printf('%s\n', 'deltaError is 0. Nothing to be done.');

	endif

endfunction