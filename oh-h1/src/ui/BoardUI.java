package ui;
import javafx.scene.canvas.Canvas;
import javafx.scene.image.Image;
import javafx.scene.layout.Pane;
import logic.Game;
import logic.Point;
import logic.StoneColor;

public class BoardUI extends Pane implements Dimensions{

	private final Game game;
	private final Canvas[][] board;
	private StoneImg img;
	private int dimension;
	
	public BoardUI(Game game, int dimension){
		this.dimension = dimension;
		this.setPrefSize(TABLERO_ANCHO, TABLERO_ALTO);
		this.setTranslateX(DES_TABLERO_X);
		this.setTranslateY(DES_TABLERO_Y);
	
		this.game = game;
		board = new Canvas[dimension][dimension];
		img = new StoneImg();
		showBoard();
		
		this.getStylesheets().add(getClass().getResource("../assets/application.css").toExternalForm());
	}


	public void showBoard() {
		
		for(int row = 0; row < dimension; row++){
			for(int column = 0 ; column < dimension ; column++){
				Point position = new Point(row,column);
				StoneColor stone = game.getStone(position);
				
				drawStone(position,stone);
			}
		}
	}

	private void drawStone(Point pos, StoneColor color) {
		double casilleroAncho = TABLERO_ANCHO/dimension;
		double casilleroAlto = TABLERO_ALTO/dimension;
		int row = pos.getI();
		int column = pos.getJ();

		this.getChildren().remove(board[row][column]);
		board[row][column]=new Canvas(casilleroAncho,casilleroAlto);
		board[row][column].setTranslateX(casilleroAncho*column);
		board[row][column].setTranslateY(casilleroAlto*row);

		this.getChildren().add(board[row][column]);
		
		
		if(color!= null){
		Image img = this.img.getStone(color);
		board[row][column].getGraphicsContext2D().drawImage(img, casilleroAncho*0.10, casilleroAlto*0.10, casilleroAncho*0.80, casilleroAlto*0.8);		
		}
	}

}
