/**
 * @author Philip Åkerfeldt
 * @date November 2013
 * @brief A simple example of inheritance of classes, supercalls (?) and method specialization.
 *
 **/

public class Second extends First {
    // Arver metoded int x automatiskt
    public int getX(){
	return super.getX() + 2;
    }
}


