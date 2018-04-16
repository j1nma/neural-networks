package ui;


import javafx.scene.image.Image;
import logic.StoneColor;


public class StoneImg {
	private Image emptyStone = new Image("/assets/emptyStone.png");
	private Image redStone = new Image("/assets/redStone.png");
	private Image blueStone = new Image("/assets/blueStone.png");
	
	
	public Image getStone(StoneColor color){
		if(color == StoneColor.RED){
			return redStone;
		}else if(color == StoneColor.BLUE){
			return blueStone;
		}
		return emptyStone;
	}
}
