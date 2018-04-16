package ui;
import javafx.scene.Node;
import javafx.scene.Scene;
import javafx.scene.control.Button;
import javafx.scene.control.Label;
import javafx.scene.layout.Pane;
import javafx.stage.Stage;
import logic.Game;
import logic.Point;


public class Play extends Pane implements Dimensions{
	private GameControler controler;
	private Game game;
	private BoardUI board;
	private boolean isHuman;
	private int dimension;

	public Play(boolean i, int dim){
		this.setPrefSize(Dimensions.TABLERO_ANCHO+100,Dimensions.TABLERO_ALTO+200);
		game = new Game(dim);
		board = new BoardUI(game,dim);
		controler = new GameControler(board,game);
		isHuman = i;
		dimension = dim;
		menu();
		this.getStylesheets().add(getClass().getResource("../assets/application.css").toExternalForm());
	}

	private void menu() {
		Label title = new MyLabel("",250,25,100,50);
		title.setId("title");

		if(isHuman){
			playHuman();
		}else{
			controler.computerPlay();
		}
		
		Button submit = new MyButton("Submit",50,600,150,70);
		submit.setId("blueButton");
		submit.setOnAction(e -> {
			if(game.hasFinished()){
				if(game.hasWon()){
					Alert.display("oh-h1!", "FELICIDADES! HAS GANADO!! <3");
				}else{
					Alert.display("oh-h1!", "Lo siento, es incorrecto.. prueba devuelta!");
				}
			}else{
				Alert.display("oh-h1!", "Parece que no has llenado todos los casilleros");
			}
		});
		
		Button back = new MyButton("Back",400,600,150,70);
		back.setId("blueButton");
		back.setOnAction(e -> {
			((Stage)(((Node) e.getSource()).getScene().getWindow())).setScene(new Scene( new Start()));
		});

		Button quit = new MyButton("Quit",450/2,600,150,70);
		quit.setId("blueButton");
		quit.setOnAction(e-> ((Stage)(((Node) e.getSource()).getScene().getWindow())).close());

		this.getChildren().addAll(title,board,submit,quit,back);
	}
	
	private void playHuman(){
		this.setOnMouseClicked( e->{
			double x=e.getSceneX();
			double y=e.getSceneY();
			if(x>DES_TABLERO_X && x<DES_TABLERO_X+TABLERO_ANCHO && y>DES_TABLERO_Y && y<DES_TABLERO_Y+TABLERO_ALTO){
				controler.click(convertClick( x , y) );
			}
		} );
	}


	private Point convertClick(double x, double y) {
		int row= (int) ((y-DES_TABLERO_Y)/(TABLERO_ALTO/dimension));
		int column= (int) ((x-DES_TABLERO_X)/(TABLERO_ANCHO/dimension));
		return new Point(row, column);
	}

}
