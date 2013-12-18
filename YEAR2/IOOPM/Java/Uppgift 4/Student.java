import java.util.ArrayList;
import java.util.List;

public class Student extends Varelse {
	public Student(String name) {
		this(name, new ArrayList<String>());
	}
	
	public Student(String name, List<String> lines) {
		super(name, lines);
	}
	
	public String talk() {
		return null;
	}
}