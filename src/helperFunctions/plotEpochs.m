function plotEpochs(epochs, epochError, style, figureNumber)

	figure(figureNumber);
	plot(1:epochs, epochError, style);
	grid on;
	hold on;
	more off;
	drawnow();

endfunction