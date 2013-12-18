import java.io.FileNotFoundException;
import java.io.FileReader;
import java.util.ArrayList;
import java.util.List;
import java.util.Random;
import java.util.Scanner;

/**
 * 
 * @author Robert Källgren, Philip Åkerfeldt
 * 
 */
public class Level {
	private class BadLevelFileException extends RuntimeException {
		public BadLevelFileException(String message) {
			super(message);
		}
	}

	private List<Room> rooms = new ArrayList<Room>();
	private Room spawn;
	private Avatar player;
	private Scanner scanner;
	private boolean levelLoaded, gameWon = false, quitPending = false;

	public Level(String path) {
		scanner = new Scanner(System.in);
		System.out.println("---------------------------------------------------------");
		levelLoaded = loadFromFile(path);
		System.out.println("---------------------------------------------------------");
	}

	private boolean loadFromFile(String path) {
		System.out.println("Loading level...");

		List<Room> undeclaredRooms = new ArrayList<Room>(); // Rum som annu inte deklarerats pa egen rad i inlasningsfilen

		try {
			Scanner sc = new Scanner(new FileReader(path));

			while (sc.hasNextLine()) {
				String[] line = sc.nextLine().trim().split(";\\s*");

				if (line.length != 9) {
					sc.close();
					throw new BadLevelFileException("Incorrect number of fields on one or more lines");
				}

				for (int i = 0; i < line.length; i++) {
					line[i] = line[i].trim();

					if (line[i].equals("")) {
						sc.close();
						throw new BadLevelFileException("Empty field(s) on one or more lines");
					}
				}

				Room currentRoom = getRoomByName(line[0]);
				Room north = getRoom(line[1], undeclaredRooms);
				Room east = getRoom(line[2], undeclaredRooms);
				Room south = getRoom(line[3], undeclaredRooms);
				Room west = getRoom(line[4], undeclaredRooms);

				if (currentRoom != null) { // Rummet har inte deklarerats pa en egen rad forut
					Door doorNorth = north != null ? (north.getSouth() == null ? new Door(getRoomByName(line[0]), north, Boolean.valueOf(line[5].toLowerCase())) : north.getSouth()) : null;
					Door doorEast = east != null ? (east.getWest() == null ? new Door(getRoomByName(line[0]), east, Boolean.valueOf(line[6].toLowerCase())) : east.getWest()) : null;
					Door doorSouth = south != null ? (south.getNorth() == null ? new Door(getRoomByName(line[0]), south, Boolean.valueOf(line[7].toLowerCase())) : south.getNorth()) : null;
					Door doorWest = west != null ? (west.getEast() == null ? new Door(getRoomByName(line[0]), west, Boolean.valueOf(line[8].toLowerCase())) : west.getEast()) : null;

					currentRoom.update(doorNorth, doorEast, doorSouth, doorWest);

					if (!undeclaredRooms.contains(currentRoom)) {
						sc.close();
						throw new BadLevelFileException(currentRoom + " declared on multiple lines");
					}

					undeclaredRooms.remove(currentRoom);
				} else {
					rooms.add(new Room(line[0]));
					
					Door doorNorth = north != null ? (north.getSouth() == null ? new Door(getRoomByName(line[0]), north, Boolean.valueOf(line[5].toLowerCase())) : north.getSouth()) : null;
					Door doorEast = east != null ? (east.getWest() == null ? new Door(getRoomByName(line[0]), east, Boolean.valueOf(line[6].toLowerCase())) : east.getWest()) : null;
					Door doorSouth = south != null ? (south.getNorth() == null ? new Door(getRoomByName(line[0]), south, Boolean.valueOf(line[7].toLowerCase())) : south.getNorth()) : null;
					Door doorWest = west != null ? (west.getEast() == null ? new Door(getRoomByName(line[0]), west, Boolean.valueOf(line[8].toLowerCase())) : west.getEast()) : null;

					getRoomByName(line[0]).update(doorNorth, doorEast, doorSouth, doorWest);
				}
			}

			sc.close();

			if (!undeclaredRooms.isEmpty()) {
				String rooms = undeclaredRooms.get(0).toString();

				if (undeclaredRooms.size() > 1) {
					for (int i = 1; i < undeclaredRooms.size(); i++) {
						rooms = rooms + ", " + undeclaredRooms.get(i);
					}
					rooms = rooms + " need to be declared on separate lines";
				} else {
					rooms = rooms + " needs to be declared on a separate line";
				}

				throw new BadLevelFileException(rooms);
			}

			if (rooms.isEmpty()) {
				throw new BadLevelFileException("No rooms found");
			}
		} catch (FileNotFoundException e) {
			System.out.println("Error: Levelfile " + path + " not found!");
			return false;
		} catch (BadLevelFileException e) {
			System.out.println("Loading failed!\n");
			System.out.println("Error: " + e.getMessage() + "!");
			return false;
		}

		System.out.println("Adding " + rooms.size() + (rooms.size() != 1 ? " rooms" : " room") + "...");
		System.out.println("Loading complete!");
		spawn = rooms.get(0);
		List<String> lines = new ArrayList<String>();
		lines.add("Hej, hur gar det med studierna?");
		lines.add("Forklara vad ett sammanhangsfritt sprak ar!");
		rooms.get(new Random().nextInt(rooms.size())).add(new Teacher("Hans", lines));
		return true;
	}

	private Room getRoomByName(String name) {
		for (Room room : rooms) {
			if (name.equals(room.toString())) {
				return room;
			}
		}
		return null;
	}

	// Returnerar antingen ett redan existerande rum, eller ett nytt tomt
	private Room getRoom(String name, List<Room> undeclaredRooms) {
		if (name.toLowerCase().equals("x")) {
			return null;
		}
		if (getRoomByName(name) != null) {
			return getRoomByName(name);
		}

		Room room = new Room(name); // Skapa ett preliminart rum
		rooms.add(room);
		undeclaredRooms.add(room);
		return room;
	}

	private void addPlayer() {
		String name = "";

		while (name.equals("")) {
			System.out.print("Enter your name: ");
			name = scanner.nextLine().trim().replaceAll("\\s+", " ");
		}

		player = new Avatar(name, spawn);
		System.out.println("Welcome to PollaxMUD, " + player + "! You are in " + player.getRoom() + ".");
	}

	private void parseInput(String input) {
		String[] splitInput = input.trim().split("\\s+");

		if (splitInput.length < 1) {
			return;
		}

		List<String> command = new ArrayList<String>();

		for (String s : splitInput) {
			command.add(s);
		}

		switch (command.get(0).toLowerCase()) {
		case "go":
			command.remove(0);
			go(command);
			break;
		case "say":
			command.remove(0);
			say(command);
			break;
		case "talk":
			command.remove(0);
			talk(command);
			break;
		case "help":
			printHelp();
			break;
		case "quit":
			quitPending = true;
			break;
		case "":
			break;
		default:
			System.out.println("Unknown command '" + command.get(0).toLowerCase() + "'. Type 'help' to see available options.");
			break;
		}
	}
	
	private void talk(List<String> command) {
		if (command.size() != 1) {
			System.out.println("Usage: talk <person>");
			return;
		}
		
		Varelse v = player.getRoom().getPerson(command.get(0).toLowerCase());
		
		if (v != null) {
			System.out.println(v + ": " + v.talk());
		} else {
			System.out.println("There is no one called '" + command.get(0) + "' in this room.");
		}
	}
	
	private boolean askForUnlock() {
		System.out.println("The door is locked, do you want to unlock it? (y/n)");
		return yesNoPrompt();
	}

	private void go(List<String> command) {
		String errorMessage = "Usage: go <north/east/south/west>";

		if (command.size() != 1) {
			System.out.println(errorMessage);
			return;
		}

		boolean successfulMove = false;
		String direction = command.get(0).toLowerCase();

		switch (direction) {
		case "north":
			if (player.getRoom().getNorth() != null && !player.getRoom().getNorth().isUnlocked()) {
				if (askForUnlock()) {
					player.getRoom().getNorth().unlock();
					successfulMove = player.move(0);
				}
			} else {
				successfulMove = player.move(0);
			}
			break;
		case "east":
			if (player.getRoom().getEast() != null && !player.getRoom().getEast().isUnlocked()) {
				if (askForUnlock()) {
					player.getRoom().getEast().unlock();
					successfulMove = player.move(1);
				}
			} else {
				successfulMove = player.move(1);
			}
			break;
		case "south":
			if (player.getRoom().getSouth() != null && !player.getRoom().getSouth().isUnlocked()) {
				if (askForUnlock()) {
					player.getRoom().getSouth().unlock();
					successfulMove = player.move(2);
				}
			} else {
				successfulMove = player.move(2);
			}
			break;
		case "west":
			if (player.getRoom().getWest() != null && !player.getRoom().getWest().isUnlocked()) {
				if (askForUnlock()) {
					player.getRoom().getWest().unlock();
					successfulMove = player.move(3);
				}
			} else {
				successfulMove = player.move(3);
			}
			break;
		default:
			System.out.println(errorMessage);
			return;
		}

		if (successfulMove) {
			printRoom(player.getRoom());
		} else {
			System.out.println("Can't move " + direction + ".");
		}
	}

	private void printRoom(Room room) {
		System.out.println("---------------------------------------------------------");
		System.out.println(room + ":");
		System.out.println("---------------------------------------------------------");
		System.out.println("North: " + (room.getNorth() == null ? "Nothing" : room.getNorth().getOtherRoom(room) + " " + (room.getNorth().isUnlocked() ? "[unlocked]" : "[locked]")));
		System.out.println("East: " + (room.getEast() == null ? "Nothing" : room.getEast().getOtherRoom(room) + " " + (room.getEast().isUnlocked() ? "[unlocked]" : "[locked]")));
		System.out.println("South: " + (room.getSouth() == null ? "Nothing" : room.getSouth().getOtherRoom(room) + " " + (room.getSouth().isUnlocked() ? "[unlocked]" : "[locked]")));
		System.out.println("West: " + (room.getWest() == null ? "Nothing" : room.getWest().getOtherRoom(room) + " " + (room.getWest().isUnlocked() ? "[unlocked]" : "[locked]")));
		System.out.print("There are " + room.getTeachers().size() + " teacher(s) in the room. ");
		for (Teacher teacher : room.getTeachers()) {
			System.out.print(teacher + " ");
		}
		System.out.println();
		System.out.println("There are " + room.getStudents().size() + " student(s) in the room.");
		System.out.println("---------------------------------------------------------");
	}

	private void say(List<String> message) {
		if (message.isEmpty()) {
			System.out.println("Usage: say <message>");
			return;
		}

		System.out.print(player + ": ");

		for (String s : message) {
			System.out.print(s + " ");
		}

		System.out.println();
	}

	private void printHelp() {
		System.out.println();
		System.out.println("---------------------------------------------------------");
		System.out.println("Available commands:");
		System.out.println("---------------------------------------------------------");
		System.out.println("go <north/east/south/west>: Move through the world");
		System.out.println("say <message>: Chat");
		System.out.println("talk <person>: See what people are up to");
		System.out.println("help: Show this dialog");
		System.out.println("quit: Exit the game");
		System.out.println("---------------------------------------------------------");
	}

	private boolean yesNoPrompt() {
		while (true) {
			System.out.print("> ");
			String input = scanner.nextLine();
			String[] splitInput = input.trim().toLowerCase().split("\\s+");
			String response = splitInput[0];

			if (response.equals("y") || response.equals("yes")) {
				return true;
			} else if (response.equals("n") || response.equals("no")) {
				return false;
			}

			System.out.println("Please type 'yes' or 'no'.");
		}
	}

	public void start() {
		System.out.println();

		if (levelLoaded) {
			addPlayer();
			printHelp();
			printRoom(player.getRoom());

			while (!quitPending && !gameWon) {
				System.out.print("> ");
				parseInput(scanner.nextLine());
			}

			System.out.println("\nThank you for playing, " + player + "!");
		} else {
			System.out.println("Unable to start level!");
		}
	}
}