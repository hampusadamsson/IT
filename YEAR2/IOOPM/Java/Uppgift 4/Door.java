public class Door {
	private Room room1;
	private Room room2;
	private boolean unlocked;
	
	public Door(Room room1, Room room2, boolean unlocked) {
		this.room1 = room1;
		this.room2 = room2;
		this.unlocked = unlocked;
	}
	
	public Room getOtherRoom(Room room) {
		if (room1 == room) {
			return room2;
		} else if (room2 == room) {
			return room1;
		} else {
			throw new IllegalArgumentException("This door does not lead to " + room);
		}
	}
	
	public void unlock() {
		unlocked = true;
	}
	
	public boolean isUnlocked() {
		return unlocked;
	}
}
