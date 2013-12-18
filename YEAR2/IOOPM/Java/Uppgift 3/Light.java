/**
 *
 * @author Robert K�llgren & Philip �kerfeldt
 * @date 11-05-13
 *
 * The class represents a traffic light that is able to switch to green for a set period of time.
 * 
 */
public class Light {
	private int period;
	private int time; // Intern klocka: 0, 1, ... period-1, 0, 1 ...
	private int green; // Signalen gr�n n�r time<green
	private int greenGuideline;

	/**
	 * Initializes a newly created Light object
	 * 
	 * @param period
	 *            How many steps the light will be red.
	 * @param greenGuideline
	 *            Approximately how many steps the light will be green within
	 *            the interval of greenGuideline +-2.
	 */
	public Light(int period, int greenGuideline) {
		if (period < 1) {
			period = 5;
		}
		if (greenGuideline < 3) {
			greenGuideline = 3;
		}
		this.period = period;
		this.greenGuideline = greenGuideline;
		this.green = time + ((int) (Math.random() * 5) + greenGuideline - 2);
		time = 0;
	}

	/**
	 * Sets the light green if the red period has passed, as well as increasing
	 * the time.
	 */
	public void step() {
		if (time >= green + period) {
			setGreen((int) (Math.random() * 5) + greenGuideline - 2);
		}

		time++;
	}

	/**
	 * Returns whether the light is green or red.
	 * 
	 * @return True if green and false if red.
	 */
	public boolean isGreen() {
		return time < green;
	}

	private void setGreen(int seconds) {
		green = time + seconds;
	}

	/**
	 * Returns a string representing the light.
	 * 
	 * @return The time left until the light changes color appended to a "G" if
	 *         the light is green and "R" if the light is red.
	 */
	public String toString() {
		if (isGreen()) {
			return ((green - time) + " " + "G ");
		}

		return ((green + period - time) + " " + "R ");
	}
}
