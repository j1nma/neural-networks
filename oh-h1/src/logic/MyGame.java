package logic;

public interface MyGame {

	public StoneColor getStone(Point position);
	
	public void putStone(Point position);
	
	public boolean hasFinished();
	
	public void playIA();
	
	public boolean hasWon();
	
	public boolean isPossibleMovement(Point position);
}
