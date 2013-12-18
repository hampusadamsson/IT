/**
 * @author Philip Åkerfeldt
 * @date November 2013
 * @brief
 *
 *
 **/
public class Simulation {
    public static void main(String[] args) {
	First a = new First();
	a.getX(); // Borde returnera 27
	System.out.println("Detta är ditt värde är:  " + a.getX());

	a = new Second();
	//a.whatPrint();
	a.getX(); // Borde returnera 29
	System.out.println("Detta är ditt värde är:  " + a.getX());
	return;
    } 
}
