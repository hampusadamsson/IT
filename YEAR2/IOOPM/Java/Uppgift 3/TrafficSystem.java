public class TrafficSystem {
	// Definierar de v�gar och signaler som ing�r i det
	// system som skall studeras.
	// Samlar statistik

	// Attribut som beskriver best�ndsdelarna i systemet
	private Lane r0;
	private Lane r1;
	private Lane r2;
	private Light s1;
	private Light s2;
	private int numberOfCars = 0;
	private double averageTime;
	private int fastestTime = Integer.MAX_VALUE;
	private int slowestTime = 0;

	private Car pendingCar = null; // En bil som vill in p� v�gen

	// Diverse attribut f�r simuleringsparametrar (ankomstintensiteter,
	// destinationer...)

	// Diverse attribut f�r statistiksamling
	// ....

	private int time = 0;

	public TrafficSystem() {
		this(5, 5, 5, 5, 5);
	}

	public TrafficSystem(int r0length, int r1length, int r2length, int period,
			int greenTime) {
		r0 = new Lane(r0length);
		r1 = new Lane(r1length);
		r2 = new Lane(r2length);
		s1 = new Light(period, greenTime);
		s2 = new Light(period, greenTime);
	}

	public void readParameters() {
		// L�ser in parametrar f�r simuleringen
		// Metoden kan l�sa fr�n terminalf�nster, dialogrutor
		// eller fr�n en parameterfil. Det sista alternativet
		// �r att f�redra vid uttestning av programmet eftersom
		// man inte d� beh�ver mata in v�rdena vid varje k�rning.
		// Standardklassen Properties �r anv�ndbar f�r detta.
	}

	public void step() {
		s1.step();
		s2.step();

		if (s1.isGreen()) {
			Car car = r1.getFirst();

			if (car != null) {
				double totalTime = averageTime * numberOfCars;
				numberOfCars++;
				int carTime = (time - car.getBornTime());
				if (carTime < fastestTime) {
					fastestTime = carTime;
				}
				if (carTime > slowestTime) {
					slowestTime = carTime;
				}
				averageTime = (totalTime + carTime) / numberOfCars;
			}
		}
		r1.step();

		if (s2.isGreen()) {
			Car car = r2.getFirst();

			if (car != null) {
				double totalTime = averageTime * numberOfCars;
				numberOfCars++;
				int carTime = (time - car.getBornTime());
				if (carTime < fastestTime) {
					fastestTime = carTime;
				}
				if (carTime > slowestTime) {
					slowestTime = carTime;
				}
				averageTime = (totalTime + carTime) / numberOfCars;
			}
		}
		r2.step();

		if (r0.firstCar() != null) {
			if (r0.firstCar().getDest() == 1) {
				if (r1.lastFree()) {
					r1.putLast(r0.getFirst());
				}
			} else {
				if (r2.lastFree()) {
					r2.putLast(r0.getFirst());
				}
			}
		}

		r0.step();

		if (pendingCar != null && r0.lastFree()) {
			r0.putLast(pendingCar);
			pendingCar = null;
		}

		time++;
	}

	public void insertCar(Car c) {
		pendingCar = c;
	}

	public void printStatistics() {
		System.out.println("Statistik: ");
		System.out.println("Antal bilar: " + numberOfCars);
		System.out.println("Medeltids�tg�ng: " + averageTime);
		System.out.println("B�sta tid: " + fastestTime);
		System.out.println("S�msta tid: " + slowestTime + "\n");
	}

	public void print() {
		System.out.println("      ______________________________");
		System.out.println(s1 + "| " + r1 + "" + r0);
		System.out.println(s2 + "| " + r2 + "/");
	}
}
