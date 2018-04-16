package logic;

public class Point {

    private int i,j;

    public Point(int i, int j){
        this.i = i;
        this.j = j;
    }

    public boolean equals(Object o){
        if(o == null)
            return false;
        if(o == this)
            return true;
        if(o.getClass() != getClass())
            return false;
        Point p = (Point) o;
        return p.i == i && p.j == j;
    }

    public String toString(){
        return Integer.toString(i) + " " + Integer.toString(j);
    }
    public int hashCode(){
        return (int) (Math.pow(2,i)*Math.pow(3,j));
    }

    public int getI() {
        return i;
    }

    public int getJ() {
        return j;
    }
}
