public class PollaxMUD {
	public static void welcomeMessage1() {
		System.out.println("#############################################################");
		System.out.println("#############################################################");
		System.out.println("##     ########  #  ################   ###   #  ##  #     ###");
		System.out.println("##  ##  #######  #  ################    #    #  ##  #  ##  ##");
		System.out.println("##  ##  #    ##  #  ##    ##  ###  #  #   #  #  ##  #  ##  ##");
		System.out.println("##     #  ##  #  #  #  ##  ##  #  ##  ## ##  #  ##  #  ##  ##");
		System.out.println("##  ####  ##  #  #  #  ##  ###   ###  #####  #  ##  #  ##  ##");
		System.out.println("##  ####  ##  #  #  #  #   ##  #  ##  #####  #  ##  #  ##  ##");
		System.out.println("##  #####    ##  #  ##   # #  ###  #  #####  ##    ##     ###");
		System.out.println("#############################################################");
		System.out.println("#################### By Robert Kallgren & Philip Akerfeldt ##");
		System.out.println("#############################################################");
		System.out.println();
	}

	public static void welcomeMessage2() {
		System.out.println("#########################################################");
		System.out.println("#####        ## ##                ###   ### ##  ## ##### ");
		System.out.println("##  ##       ## ##                #### #### ##  ## ##  ##");
		System.out.println("##  ## ####  ## ##  ####  ##   ## ## ### ## ##  ## ##  ##");
		System.out.println("##### ##  ## ## ## ##  ##  ## ##  ##  #  ## ##  ## ##  ##");
		System.out.println("##    ##  ## ## ## ##  ##   ###   ##     ## ##  ## ##  ##");
		System.out.println("##    ##  ## ## ## ## ###  ## ##  ##     ## ##  ## ##  ##");
		System.out.println("##     ####  ## ##  ### # ##   ## ##     ##  ####  ##### ");
		System.out.println("#########################################################");
		System.out.println("                    By Robert Kallgren & Philip Akerfeldt");
		System.out.println();
	}

	public static void welcomeMessage3() {
		System.out.println(" _____      _ _            __  __ _    _ _____  ");
		System.out.println("|  __ \\    | | |          |  \\/  | |  | |  __ \\ ");
		System.out.println("| |__) |__ | | | __ ___  _| \\  / | |  | | |  | |");
		System.out.println("|  ___/ _ \\| | |/ _` \\ \\/ / |\\/| | |  | | |  | |");
		System.out.println("| |  | (_) | | | (_| |>  <| |  | | |__| | |__| |");
		System.out.println("|_|   \\___/|_|_|\\__,_/_/\\_\\_|  |_|\\____/|_____/ ");
		System.out.println("           By Robert Källgren & Philip Akerfeldt");
		System.out.println();
	}

	public static void main(String[] args) {
		welcomeMessage2();

		new Level("rooms.txt").start();
	}
}