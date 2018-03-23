1;

<<<<<<< HEAD:learningRateFunctions.m
function lr = updateLearningRate(prevW, prevce, ce, learningRate)
=======
function learningRate = updateLearningRate(currentPatternError, hiddenLayers, learningRate, numberOfInputsIncludedBias, numberOfOutputs, epsilon)
>>>>>>> ded4728a4677f5bb71c589d0d1908a5af25ed685:src/helperFunctions/learningRateFunctions.m

	global top = 5;

	inc = 0.015;

	global it;

	global w;

	lr = learningRate;

	if prevce == 0
		it = 0;
	else

		if ((prevce > ce) && (it < top))
			it++;
		elseif prevce < ce
			it = 0;
			w = prevW;
			if(learningRate - inc)>0
				lr = learningRate - inc;
			endif
		endif

		if it == top
			it = 0;
			lr = learningRate + inc;
		endif
	endif
		
endfunction
		