import java.util.ArrayList;
import java.util.List;

public class Room {
	private String name;
	private Door north, east, south, west;

	private List<Teacher> teachers;
	private List<Student> students;

	public Room(String name) {
		this(name, null, null, null, null);
	}
	
	public Room(String name, Door north, Door east, Door south, Door west) {
		this(name, north, east, south, west, new ArrayList<Teacher>(), new ArrayList<Student>());
	}

	public Room(String name, Door north, Door east, Door south, Door west, List<Teacher> teachers, List<Student> students) {
		this.name = name;
		this.north = north;
		this.east = east;
		this.south = south;
		this.west = west;
		this.teachers = teachers;
		this.students = students;
	}

	public void update(Door north, Door east, Door south, Door west) {
		this.north = north;
		this.east = east;
		this.south = south;
		this.west = west;
	}
	
	public List<Teacher> getTeachers() {
		return teachers;
	}
	
	public List<Student> getStudents() {
		return students;
	}

	public Door getNorth() {
		return north;
	}

	public Door getEast() {
		return east;
	}

	public Door getSouth() {
		return south;
	}

	public Door getWest() {
		return west;
	}

	public void add(Teacher teacher) {
		teachers.add(teacher);
	}

	public void add(Student student) {
		students.add(student);
	}

	public void remove(Teacher teacher) {
		teachers.remove(teacher);
	}

	public void remove(Student student) {
		students.remove(student);
	}
	
	public Varelse getPerson(String name) {
		for (Teacher teacher : teachers) {
			if (teacher.toString().toLowerCase().equals(name)) {
				return teacher;
			}
		}
		for (Student student: students) {
			if (student.toString().toLowerCase().equals(name)) {
				return student;
			}
		}
		
		return null;
	}

	public void remove() {

	}

	public String toString() {
		return name;
	}
}
