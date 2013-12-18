/**
 *
 *@author Robert Källgren & Philip Åkerfeldt
 *@date 11-05-13
 *
 * This class represents a car with a set destination 1 or 2. 
 *
 */
public class Car {
	private int bornTime;
	private int dest; // 1 för rakt fram, 2 för vänstersväng

	/**
	 * Initializes a newly created Car object
	 * 
	 * @param bornTime
	 *            When the car was created
	 * @param dest
	 *            Which lane the car is going; 1 For the upper lane, 2 for the
	 *            lower lane
	 */
	public Car(int bornTime, int dest) {
		this.bornTime = bornTime;

		if (dest != 1 && dest != 2) {
			this.dest = 1;
		} else {
			this.dest = dest;
		}
	}

	/**
	 * Returns an integer representing the time when the car was created
	 * 
	 * @return The time of the car's initialization
	 */
	public int getBornTime() {
		return bornTime;
	}

	/**
	 * Returns the destination of the car
	 * 
	 * @return The destination of the car. 1 for the upper lane and 2 for the
	 *         lower.
	 */
	public int getDest() {
		return dest;
	}

	/**
	 * Returns the visual representation of the car
	 * 
	 * @return Returns the string "BIL"
	 */
	public String toString() {
		return "BIL";
	}
}