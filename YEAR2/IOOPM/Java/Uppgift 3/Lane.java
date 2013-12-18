/**
 *
 * @author Robert K�llgren & Philip �kerfeldt
 * @date 11-05-13
 *
 * The class represents a lane in which cars are stored.
 * It contains methods to:
 *        - move the cars along the lane.
 *        - get the first car
 *        - check if the last slot is empty
 * 
 * @see Car
 *
 */
public class Lane {

	public static class OverflowException extends RuntimeException {
		// Undantag som kastas n�r det inte gick att l�gga
		// in en ny bil p� v�gen
	}

	private Car[] theLane;

	/**
	 * Initializes a newly created Lane object with a specified length.
	 * 
	 * @param n
	 *           The length of the lane.
 	 */
	public Lane(int n) {
		if (n < 1) {
			n = 10;
		}
		theLane = new Car[n];
	}

	/**
	 * Moves the cars a step forward on the lane if the slot is not already
	 * occupied.
	 */
	public void step() {
		for (int i = 0; i < (theLane.length - 1); i++) {
			if (theLane[i] == null) {
				theLane[i] = theLane[i + 1];
				theLane[i + 1] = null;
			}
		}
	}

	/**
	 * Removes and returns the first car on the lane.
	 * 
	 * @return The first car.
	 */
	public Car getFirst() {
		Car temp = theLane[0];
		theLane[0] = null;
		return temp;
	}

	/**
	 * Returns the first car without removing it from the lane.
	 * 
	 * @return The first car.
	 */
	public Car firstCar() {
		return theLane[0];
	}

	/**
	 * Returns whether the last slot on the lane is free.
	 * 
	 * @return True if the slot is free, else false.
	 */
	public boolean lastFree() {
		return theLane[theLane.length - 1] == null;
	}

	/**
	 * Puts a car in the last slot of the lane if not already occupied.
	 * 
	 * @param c
	 *            A car to put last.
	 * @throws OverflowException
	 *            If the last slot is already occupied.
	 */
	public void putLast(Car c) throws OverflowException {
		if (c == null) {
			return;
		}
		if (lastFree()) {
			theLane[theLane.length - 1] = c;
		}
	}

	/**
	 * Returns a visual representation of the lane.
	 * @return A line of text where "___" means an empty slot and cars are
	 *         represented by their own toString() method.
	 * @see Car
	 */
	public String toString() {
		String bilar = "";
		for (int i = 0; i < theLane.length; i++) {
			if (theLane[i] == null) {
				bilar = bilar + "___";
			} else {
				bilar = bilar + theLane[i] + "";
			}

		}
		return bilar;
	}
}
