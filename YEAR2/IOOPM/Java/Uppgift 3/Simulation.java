import java.util.Random;

public class Simulation {
	public static void main(String[] args) {
		TrafficSystem TS = new TrafficSystem(5, 5, 5, 5, 5);

		long time = System.currentTimeMillis();
		int steps = 0;

		while (true) {
			if (System.currentTimeMillis() > time + 1000) {
				time = System.currentTimeMillis();
				TS.step();
				if (new Random().nextInt(3) > 0) {
					TS.insertCar(new Car(steps, (int) (Math.random() * 2) + 1));
				}
				for (int i = 0; i < 70; i++) {
					System.out.println();
				}
				TS.printStatistics();
				TS.print();
				steps++;
			}
		}
	}
}
