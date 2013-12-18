public class Avatar {
	private String name;
	private Room room;

	public Avatar(String name, Room room) {
		this.name = name;
		this.room = room;
	}

	public boolean move(int direction) {
		switch (direction) {
		case 0:
			if (room.getNorth() == null) {
				return false;
			} else {
				room = room.getNorth().getOtherRoom(room);
				return true;
			}
		case 1:
			if (room.getEast() == null) {
				return false;
			} else {
				room = room.getEast().getOtherRoom(room);
				return true;
			}
		case 2:
			if (room.getSouth() == null) {
				return false;
			} else {
				room = room.getSouth().getOtherRoom(room);
				return true;
			}
		case 3:
			if (room.getWest() == null) {
				return false;
			} else {
				room = room.getWest().getOtherRoom(room);
				return true;
			}
		default:
			return false;
		}
	}

	public Room getRoom() {
		return room;
	}

	public String toString() {
		return name;
	}
}