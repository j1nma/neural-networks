package ui;

import javafx.animation.KeyFrame;
import javafx.animation.Timeline;
import javafx.util.Duration;
import logic.Game;
import logic.Point;


public class GameControler {
	private Game game;
	private BoardUI board;	
	
	public GameControler(BoardUI board, Game game) {
		this.board = board;
		this.game = game;
	}

	public void click(Point position) {
		if(game.isPossibleMovement(position)){
			game.putStone(position);
			board.showBoard();
		}
	}

	void computerPlay() {
		game.playIA();
		board.showBoard();
		Timeline timer = new Timeline(new KeyFrame(Duration.seconds(1), e -> computerPlay()));
		timer.setCycleCount(1);
		timer.play();
	}
	


}
