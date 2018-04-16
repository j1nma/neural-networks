package logic;


public class Game implements MyGame{
	private Integer[][] board;
	private int dim;
	
	public Game(int dimension){
		dim = dimension;
		board = new Integer[dim][dim];
		for(int i = 0; i<dim ; i++){
			for(int j = 0; j<dim ; j++){
				board[i][j] = 0;
			}
		}
	}

	@Override
	public StoneColor getStone(Point position) {
		Integer color = null;
		for(int i = 0; i<dim ; i++){
			for(int j = 0; j<dim ; j++){
				if(i == position.getI() && j == position.getJ()){
					color = board[i][j];
				}
			}
		}
		if(color == 0){
			return StoneColor.EMPTY;
		}else if(color == 1){
			return StoneColor.RED;
		}else if(color == -1){
			return StoneColor.BLUE;
		}else{
			return null;
		}
	}

	@Override
	public void putStone(Point position) {
		StoneColor stone = null;
		if(position.getI()<=dim && position.getJ()<=dim){
			stone = getStone(position);
			if(stone == null){
				return;
			}else if(stone == StoneColor.EMPTY){
				board[position.getI()][position.getJ()] = 1;
			}else if(stone == StoneColor.RED){
				board[position.getI()][position.getJ()] = -1;
			}else if(stone == StoneColor.BLUE){
				board[position.getI()][position.getJ()] = 0;
			}
		}
	}

	@Override
	public boolean hasFinished() {

		for(int i = 0; i<dim ; i++){
			for(int j = 0; j<dim ; j++){
				if(board[i][j] == 0){
					return false;
				}
			}
		}
		return true;
	}

	@Override
	public void playIA() {
		// TODO Auto-generated method stub
		
	}

	@Override
	public boolean hasWon() {
		// TODO Auto-generated method stub
		return true;
	}

	public boolean isPossibleMovement(Point position) {
		// TODO Auto-generated method stub
		return true;
	}

	
}
