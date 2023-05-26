/////////////////////////////////////////////////////////////////////////////////
// name: Landen Nguyen
// date: May 10, 2023
// desc: Room adventure implemented in Java... yay...
// My additions are a lot more rooms and each have their own item and grabbable
//////////////////////////////////////////////////////////////////////////////////

// allows us to use dictionaries and array lists in Java

import java.util.*;

class Room {

    // declare instance variables
    private String              name;
    public  Map<String, Room>   exits      = new HashMap<>();
    public  Map<String, String> items      = new HashMap<>();
    public  List<String>        grabbables = new ArrayList<>();

    // room constructor
    public Room(String name) {
        this.name = name;
    }

    // accessors and mutators for instance variables
    public String getName() {
        return this.name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public Map<String, Room> getExits() {
        return this.exits;
    }

    public void setExits(HashMap<String, Room> exits) {
        this.exits = exits;
    }

    public Map<String, String> getItems() {
        return this.items;
    }

    public void setItems(Map<String, String> items) {
        this.items = items;
    }

    public List<String> getGrabbables() {
        return this.grabbables;
    }

    public void setGrabbables(List<String> grabbables) {
        this.grabbables = grabbables;
    }

    // creates a room
    public void addExit(String exit, Room room) {
        this.exits.put(exit, room);
    }

    // adds an item to a room
    public void addItem(String item, String desc) {
        this.items.put(item, desc);
    }

    // adds grabbable to a room
    public void addGrabbable(String item) {
        this.grabbables.add(item);
    }

    // removes grabbable from the room
    public void delGrabbable(String item) {
        this.grabbables.remove(item);
    }

    // string function to print location and what you see
    public String toString() {
        String result = "You are in " + this.name + ".\n" + "You see: ";

        result += String.join(",", this.items.keySet());

        result += "\nExits: " + String.join(",", exits.keySet()) + "\n";

        return result;
    }
}

class Game {

    // default statuses
    private static final String STATUS_CMD_ERR       = "I don't understand. Try <verb> <noun>. Valid verbs are 'go', 'look', and 'take'.";
    private static final String STATUS_DEAD          = "You are dead.";
    private static final String STATUS_BAD_EXIT      = "Invalid exit.";
    private static final String STATUS_ROOM_CHANGE   = "Room changed.";
    private static final String STATUS_GRABBED       = "Item grabbed.";
    private static final String STATUS_BAD_GRABBABLE = "I can't grab that.";
    private static final String STATUS_BAD_ITEM      = "I don't see that.";
    private              String status;

    // instance variable for the inventory and current room
    private       Room         currentRoom;
    private final List<String> inventory = new ArrayList<>();

    public static void main(String[] args) {
        Game game = new Game();
        game.setupGame();
        game.setStatus("");
        Scanner s = new Scanner(System.in);
        
        // main game loop that uses 'switch' to determine what to do
        // if given unrecognized input, sets status to an error
        gameLoop: while (true) {
            
            String input = s.nextLine();
            String[] inputArray = input.toLowerCase().split(" ");
            if (inputArray.length == 2){
                switch (inputArray[0]) {
                    case "go"                       -> game.handleGo(inputArray[1]);
                    case "look"                     -> game.handleLook(inputArray[1]);
                    case "take"                     -> game.handleTake(inputArray[1]);
                    default                         -> {
                        game.status = STATUS_CMD_ERR;
                        game.setStatus(game.status);
                    }
                }
            } else if (inputArray.length > 1) {
                game.status = STATUS_CMD_ERR;
                game.setStatus(game.status);
            } else {
                break gameLoop;
            }
        }
    }

    // creates all rooms and adds items to them (grabs, items)
    public void setupGame() {
        Room r1  = new Room("Kitchen");
        Room r2  = new Room("Office");
        Room r3  = new Room("Living Room");
        Room r4  = new Room("Library");
        Room r5  = new Room("Master Bedroom");
        Room r6  = new Room("Laundry Room");
        Room r7  = new Room("Garage");
        Room r8  = new Room("Bathroom");
        Room r9  = new Room("Guest Room");
        Room r10 = new Room("Man Cave");
        Room r11 = new Room("Guest Bathroom");

        r1.addExit("east", r2);
        r1.addExit("south", r3);
        r1.addExit("north", r6);
        r1.addExit("west", r9);

        r2.addExit("west", r1);
        r2.addExit("south", r4);

        r3.addExit("north", r1);
        r3.addExit("east", r4);
        r3.addExit("west", r7);

        r4.addExit("west", r3);
        r4.addExit("north", r2);
        r4.addExit("south", null);
        r4.addExit("upstairs", r5);

        r5.addExit("north", r8);
        r5.addExit("downstairs", r4);
        r5.addExit("west", r10);

        r6.addExit("south", r1);

        r7.addExit("east", r3);

        r8.addExit("south", r5);

        r9.addExit("east", r1);
        r9.addExit("north", r11);

        r10.addExit("east", r5);

        r11.addExit("south", r9);

        // items added to rooms
        r1.addItem("stools", "The stools are around the island."); 
        r1.addItem("island", "The island is made of marble like the counter and pristine."); 
        r1.addItem("counter", "The counter has a cookie on it."); 
        r1.addItem("fridge", "The fridge is touchscreen because I'm rich."); 
        
        r2.addItem("chair", "lots of wicker"); 
        r2.addItem("table", "got a key on it or sum"); 
        
        r3.addItem("fireplace", "There's my dog laying in front of it."); 
        
        r4.addItem("bookshelf", "It's made of wicker and has a book on it."); 

        r5.addItem("bed", "It has a wicker frame.");

        r6.addItem("washing_machine", "It's the fancy one that washes in 5 minutes.");

        r7.addItem("car", "My ferrari is red.");

        r8.addItem("toilet", "It has a bidet function.");

        r9.addItem("twin_bed", "Wick frame with a memory foam mattress.");

        r10.addItem("tv", "It's a 80 inch tv that I play Tears of the Kingdom on.");

        r11.addItem("mirror", "I hate looking at myself.");
        
        // grabbables added to the room 
        r1.addGrabbable("cookie");

        r2.addGrabbable("key");

        r3.addGrabbable("dog");

        r4.addGrabbable("book");

        r5.addGrabbable("brush");

        r6.addGrabbable("towel");

        r7.addGrabbable("keys");

        r8.addGrabbable("comb");

        r9.addGrabbable("underwear");

        r10.addGrabbable("switch");

        r11.addGrabbable("hair_tie");

        // set current room to room 1
        this.currentRoom = r1;
    }

    // anytime something happens this function is run to determine what to print
    public void setStatus(String status) {
        if (this.currentRoom == null) {
            this.status = STATUS_DEAD;
            System.out.println("\n" + this.status + "\n");
            System.exit(0);
        } else {
            Collections.sort(inventory);
            System.out.println("\n" + this.status + "\n");
            this.status = this.currentRoom + "\nYou are carrying: " + this.inventory + "\n\nWhat would you like to do? ";
            System.out.println(this.status);
        }
    }

    // checks current room exits for a way out then goes to it if it exists
    public void handleGo(String destination) {
        this.status = STATUS_BAD_EXIT;

        if (this.currentRoom.exits.containsKey(destination)) {
            Room dest = this.currentRoom.exits.get(destination);
            if (dest != null) {
                this.currentRoom = dest;
                this.status = STATUS_ROOM_CHANGE;
            } else {
                this.currentRoom = dest;
                this.status = STATUS_DEAD;
            }
        }
        this.setStatus(this.status);
    }

    // checks the current items in the room and gives the description if it exists
    public void handleLook(String item) {
        this.status = STATUS_BAD_ITEM;

        if (this.currentRoom.items.containsKey(item)) {
            this.status = this.currentRoom.items.get(item);
        }
        this.setStatus(this.status);
    }

    // checks the current room for grabbables and adds it to inventory if it exists
    public void handleTake(String grabbable) {
        this.status = STATUS_BAD_GRABBABLE;

        if (this.currentRoom.grabbables.contains(grabbable)) {
            this.inventory.add(grabbable);
            this.currentRoom.delGrabbable(grabbable);
            this.status = STATUS_GRABBED;
        }
        this.setStatus(this.status);
    }
}