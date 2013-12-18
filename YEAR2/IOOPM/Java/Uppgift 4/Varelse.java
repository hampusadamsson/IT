import java.util.List;
import java.util.Random;

public abstract class Varelse {
	private String name;
	private List<String> lines;

	public Varelse(String name, List<String> lines) {
		this.name = name;
		this.lines = lines;
	}

	public String talk() {
		return lines.isEmpty() ? null : lines.get(new Random().nextInt(lines.size()));
	}
	
	public String toString() {
		return name;
	}
}