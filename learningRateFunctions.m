1;

function lr = updateLearningRate(prevW, prevce, ce, learningRate)

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
		