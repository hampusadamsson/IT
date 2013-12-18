import java.util.ArrayList;
import java.util.List;
import java.util.Random;

public class Teacher extends Varelse {
	public Teacher(String name) {
		this(name, new ArrayList<String>());
	}
	
	public Teacher(String name, List<String> lines) {
		super(name, lines);
	}
}