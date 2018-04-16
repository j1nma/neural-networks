package ui;

import javafx.geometry.Pos;
import javafx.scene.Node;
import javafx.scene.Scene;
import javafx.scene.control.Button;
import javafx.scene.control.Label;
import javafx.scene.control.RadioButton;
import javafx.scene.layout.HBox;
import javafx.scene.layout.VBox;
import javafx.stage.Stage;

public class Start extends VBox {

	private Label humanPlayerLabel, aiPlayerLabel;
	private RadioButton humanButton, aiButton;
	private int dimension;
	
	public Start(){
		super(25);
		this.setPrefSize(700, 700);
		Label title = new MyLabel("",0,0,200,100);
		title.setAlignment(Pos.TOP_CENTER);
		title.setId("title");
		
		dimension = 4;
		
		humanButton = new RadioButton();
		aiButton = new RadioButton();
		
		humanButton.setSelected(true);
		aiButton.setSelected(false);
		
		humanPlayerLabel = new Label("Play manually");
		aiPlayerLabel = new Label("Play with algorithm");

		humanButton.setOnAction(e -> {
			if(humanButton.isSelected()){
				aiButton.setSelected(false);
			}else if(!humanButton.isSelected() && !aiButton.isSelected()){
				humanButton.setSelected(true);
				aiButton.setSelected(false);
			}
		});
		
		aiButton.setOnAction(e -> {
			if(aiButton.isSelected()){
				humanButton.setSelected(false);
			}else if(!humanButton.isSelected() && !aiButton.isSelected()){
				humanButton.setSelected(false);
				aiButton.setSelected(true);
			}
		});
		
		HBox playChoiceLabel = new HBox();
		playChoiceLabel.getChildren().addAll(humanPlayerLabel,aiPlayerLabel);
		playChoiceLabel.setAlignment(Pos.CENTER);
		playChoiceLabel.setSpacing(50);
		
		
		HBox playChoiceButton = new HBox();
		playChoiceButton.getChildren().addAll(humanButton,aiButton);
		playChoiceButton.setAlignment(Pos.CENTER);
		playChoiceButton.setSpacing(150);
		
		Button[] dim = new Button[5];
		
		
		for(int i = 0; i < 5 ; i++){
			Integer aux = 4+2*i;
			dim[i] = new MyButton(aux.toString(),0,0,50,50);
			if(aux == 4){
				dim[i].setId("redStone");
			}else{
			dim[i].setId("blueStone");
			}
			
			Button dimaux = dim[i];
			dimaux.setOnAction(e -> {
				for(int j = 0; j < 5 ; j++){
					if( dim[j].getId().compareTo("redStone") == 0){
						dim[j].setId("blueStone");
					}
				}
				dimaux.setId("redStone");
				dimension = new Integer(dimaux.getText()).intValue();
			});
		}
		
		HBox dims = new HBox();
		dims.getChildren().addAll(dim);
		dims.setAlignment(Pos.CENTER);
		dims.setSpacing(5);
		
		Button play= new MyButton("Play",0,0,170,70);
		play.setId("redButton");

		play.setOnAction(e -> {
			Scene escena = new Scene(new Play(humanButton.isSelected()?true:false,dimension));
			((Stage)(((Node) e.getSource()).getScene().getWindow())).setScene(escena);
		});

		Button quit = new MyButton("Quit",0,0,170,70);
		quit.setId("blueButton");
		quit.setOnAction(e-> ((Stage)(((Node) e.getSource()).getScene().getWindow())).close());
		
		HBox playnquit = new HBox();
		playnquit.getChildren().addAll(play,quit);
		playnquit.setAlignment(Pos.CENTER);
		playnquit.setSpacing(10);
	

		this.getChildren().addAll(title,playChoiceLabel,playChoiceButton,dims,playnquit);
		this.setSpacing(50);
		this.setAlignment(Pos.CENTER);
		this.getStylesheets().add(getClass().getResource("../assets/application.css").toExternalForm());
		
	}
}
