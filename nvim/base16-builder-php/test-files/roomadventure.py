###################################################
# Name: Landen Nguyen, Hayden Pott, Sadie Sanders #
# Date: 29 March 2023                             #
# Desc: Room Adventure Revolutions                #
###################################################

from tkinter import *
from random import choice

class Room:
    """A Room has a name and a file path that points to a .gif image."""

    def __init__(self, name: str, image_filepath: str) -> None:
        self.name = name
        self.image = image_filepath
        self.exits = {}
        self.items = {}
        self.grabbables = []

    # skipping getters and setters
    def add_exit(self, label: str, room: "Room"):
        self.exits[label] = room

    def add_item(self, label: str, desc: str):
        self.items[label] = desc

    def add_grabbables(self, label: str):
        self.grabbables.append(label)

    def del_grabbables(self, label: str):
        self.grabbables.remove(label)

    def __str__(self) -> str:
        # create base response
        result = f"You are in {self.name}\n"

        # append the items you see in the room
        result += f"You see: "
        for item in self.items.keys():
            result += item + " "
        result += "\n"

        # append the exits available
        result += "Exits: "
        for exit in self.exits.keys():
            result += exit + " "
        result += "\n"

        return result

class Game(Frame):
    
    EXIT_ACTIONS = ["quit", "exit", "bye", "q"]

    # status
    STATUS_CMD_ERR = "I don't understand. Try <verb> <noun>. Valid verbs are 'go', 'dance', 'look', 'take', and 'use'."
    STATUS_DEAD = "You are dead."
    STATUS_BAD_EXIT = "Invalid exit."
    STATUS_ROOM_CHANGE = "Room changed."
    STATUS_GRABBED = "Item grabbed."
    STATUS_BAD_GRABBABLE = "I can't grab that."
    STATUS_BAD_ITEM = "I don't see that."
    
    WIDTH = 800
    HEIGHT = 600

    def __init__(self, parent) -> None:
        self.inventory = []
        Frame.__init__(self, parent)
        self.pack(fill=BOTH, expand=1)

        self.command_history = []
        self.command_history_pos = 0

    def setup_game(self):
        # create rooms
        r1 = Room("Kitchen", "images/kitchen.png")
        r2 = Room("Dining Room", "images/diningroom.png")
        r3 = Room("Living Room", "images/livingroom.png")
        r4 = Room("Library", "images/library.png")
        r5 = Room("Laundry Room", "images/laundryroom.png")
        r6 = Room("Office", "images/office.png")
        r7 = Room("Master Bedroom", "images/masterbedroom.png")
        r8 = Room("Bathroom", "images/bathroom.png")
        r9 = Room("Kid's Bedroom", "images/bedroom.png")
        r10 = Room("Cellar", "images/cellar.png")

        # add exits to each room
        r1.add_exit("east", r2)
        r1.add_exit("south", r3)
        r1.add_exit("north", r5)
        r1.add_exit("downstairs", r10)

        r2.add_exit("west", r1)
        r2.add_exit("south", r4)

        r3.add_exit("north", r1)
        r3.add_exit("east", r4)
        r3.add_exit("west", r6)

        r4.add_exit("north", r2)
        r4.add_exit("west", r3)
        r4.add_exit("upstairs", r7)
        r4.add_exit("south", None)

        r5.add_exit("south", r1)

        r6.add_exit("east", r3)

        r7.add_exit("downstairs", r4)
        r7.add_exit("north", r8)
    
        r8.add_exit("south", r7)
        r8.add_exit("west", r9)

        r9.add_exit("east", r8)

        r10.add_exit("upstairs", r1)

        # add items to the rooms
        r1.add_item("stools", "The stools are around the island.")
        r1.add_item("island", "The island is made of marble like the counter and pristine.")
        r1.add_item("counter", "The counter is made of marble like the island. \
                                There's a baking_sheet sitting on it.")
        r1.add_item("fridge", "The fridge is touchscreen because I'm rich. \
                               There's dough and butter sitting in it ready to be used.")

        r2.add_item("dining_set", "The table is made of wicker and stained a dark brown.")
        r2.add_item("chandelier", "It's made of glass and glistens when the lights are on.")

        r3.add_item("fireplace", "It's radiating a lot of heat and roaring.")
        r3.add_item("couch", "It's made of a very expensive leather.")
        r3.add_item("endtable", "There's a remote laying on it.")
        r3.add_item("TV", "The TV is currently off hanging above the fireplace.")

        r4.add_item("bookcase", "It looks brand new still even though it's been years since I had it installed. \
                                 There's my favorite book on this shelf.")
        r4.add_item("staircase", "It leads to my bedroom. I love having a library right beneath my room.")

        r5.add_item("washing_machine", "It's a dual model that washes and dries your clothes.")

        r6.add_item("desk", "It's a big L shaped desk in the corner of the room I use to work. \
                             There's a key sitting on top of it.")
        r6.add_item("office_chair", "Made of a flexible material made to move as you lean back.")

        r7.add_item("king_bed", "The sheets are Egyptian cotton and the pillows are memory foam.")
        r7.add_item("vanity", "It's massive and sits across from my bed.")

        r8.add_item("toilet", "It has a bidet feature.")
        r8.add_item("mirror", "Half of the bathroom consists of the mirror.")
        r8.add_item("shower", "It's a standing shower with a big bench in it.")

        r9.add_item("bunk_beds", "My kid's love these bunk beds even though they're getting older.")
        r9.add_item("toys", "They're all over the ground since my kids never clean up after themselves.")

        r10.add_item("keg", "All of my alcohol stays down here including my secret stash.")

        # add grabbables to the rooms

        r1.add_grabbables("baking_sheet")
        r1.add_grabbables("dough")
        r1.add_grabbables("butter")

        r3.add_grabbables("remote")

        r4.add_grabbables("book")

        r6.add_grabbables("key")

        # set the current room to the starting room
        self.current_room = r1

    def setup_gui(self):
        # input element at the bottom of the screen
        self.player_input = Entry(self, bg='white', fg='black')
        self.player_input.bind("<Return>", self.process)
        self.player_input.bind("<Up>", self.prev_cmd)
        self.player_input.bind("<Down>", self.next_cmd)
        self.player_input.pack(side=BOTTOM, fill=X)
        self.player_input.focus()

        # the image container and default image
        img = None # represents the actual image
        self.image_container = Label(self, width=Game.WIDTH // 2, image=img)
        self.image_container.image = img # ensuring image persistence after function ends
        self.image_container.pack(side=LEFT, fill=Y)
        self.image_container.pack_propagate(False) # prevent the image from modifying the size of the container it is in

        # container for the game text
        text_container = Frame(self, width=Game.WIDTH // 2)
        self.text = Text(text_container, bg="#111", fg="lightgrey", state=DISABLED, font=('monospace', 16), wrap='word')
        self.text.pack(fill=Y, expand=1)
        text_container.pack(side=RIGHT, fill=Y)
        text_container.pack_propagate(False)

    def set_room_image(self):
        if self.current_room == None:
            img = PhotoImage(file="images/skull.gif")
        else:
            img = PhotoImage(file=self.current_room.image)

        self.image_container.config(image=img)
        self.image_container.image = img

    def set_status(self, status):
        self.text.config(state=NORMAL) # make it editable
        self.text.delete(1.0, END) # yes 1.0 for text, 0 for entry elements

        if self.current_room == None:
            self.text.insert(END, Game.STATUS_DEAD)
        else:
            self.inventory.sort()
            content = f"{self.current_room}\nYou are carrying: {self.inventory}\n\n{status}"
            self.text.insert(END, content)

        self.text.config(state=DISABLED) # no longer editable

    def clear_entry(self):
        self.player_input.delete(0, END)

    def handle_go(self, destination):
        status = Game.STATUS_BAD_EXIT

        if destination in self.current_room.exits:
            self.current_room =  self.current_room.exits[destination]
            if self.current_room == None:
                self.player_input.config(state='disabled')
            status = Game.STATUS_ROOM_CHANGE

        self.set_status(status)
        self.set_room_image()


    def handle_look(self, item):
        status = Game.STATUS_BAD_ITEM

        if item in self.current_room.items:
            status = self.current_room.items[item]

        self.set_status(status)

    def handle_take(self, grabbable):
        status = Game.STATUS_BAD_GRABBABLE

        if grabbable in self.current_room.grabbables:
            self.inventory.append(grabbable)
            self.current_room.del_grabbables(grabbable)
            status = Game.STATUS_GRABBED

        self.set_status(status)

    def use_item(self, args: str):
        args = args.split(' ')

        if len(args) < 2:
            self.set_status('Usage: `use <this> <that>`')
            return

        if args[0] not in self.inventory and args[1] not in self.inventory:
            self.set_status('You must be holding this item to use it.')
            return

        status = "Can't use this item on that"
        match args[0]:
            case 'dough':
                if args[1] == 'baking_sheet':
                    self.inventory.remove('dough')
                    self.inventory.append('bread')
                    status = 'Baked bread!'
            case 'butter':
                if args[1] == 'bread':
                    self.inventory.remove('bread')
                    self.inventory.remove('butter')
                    self.inventory.append('buttered_bread')
                    status = 'Buttered bread!'
        self.set_status(status)

    def handle_dance(self, destination: str):
        dances = ["dougie", "floss", "whip", "nae nae", "woah", "moonwalk", "robot", "two step"]
        status = Game.STATUS_BAD_EXIT

        if destination in self.current_room.exits:
            self.current_room =  self.current_room.exits[destination]
            if self.current_room == None:
                self.player_input.config(state='disabled')
            dance = choice(dances)
            status = "You hit the " + dance + " through the doorway."

        self.set_status(status)
        self.set_room_image()

    def eat_item(self, item):
        if item not in self.inventory:
            self.set_status('Item must be in your inventory to eat it.')
        status = 'You may not eat this item.'
        match item:
            case 'buttered_bread':
                status = 'YUM!'
                self.inventory.remove(item)
        self.set_status(status)

    def play(self):
        self.setup_game()
        self.setup_gui()
        self.set_room_image()
        self.set_status("")

    def update_cmd(self):
        """ Update the command prompt line """
        self.player_input.delete(0, END)
        if self.command_history_pos == 0: return
        self.player_input.insert(0, self.command_history[-self.command_history_pos])

    def prev_cmd(self, _):
        """ Move up the command history by 1 """
        self.command_history_pos += 1
        if self.command_history_pos > len(self.command_history):
            self.command_history_pos = len(self.command_history)
        self.update_cmd()

    def next_cmd(self, _):
        """ Move down the command history by 1 """
        self.command_history_pos -= 1
        if self.command_history_pos < 0:
            self.command_history_pos = 0
        self.update_cmd()

    def process(self, _):
        action = self.player_input.get().strip()

        if len(self.command_history) == 0 or self.command_history[-1].lower().strip() != action.lower():
            self.command_history.append(action)

        action = action.lower()

        if action in Game.EXIT_ACTIONS:
            exit()

        self.clear_entry()

        if self.current_room == None:
            return
        
        if ' ' not in action:
            self.set_status(Game.STATUS_CMD_ERR)
            return

        [verb, noun] = action.split(' ', 1)

        match verb:
            case 'go' | 'move' | 'cd': self.handle_go(destination=noun.replace(' ', '_'))
            case 'look' | 'll' | 'ls': self.handle_look(item=noun.replace(' ', '_'))
            case 'take': self.handle_take(grabbable=noun.replace(' ', '_'))
            case 'use': self.use_item(noun)
            case 'dance': self.handle_dance(destination=noun.replace(' ', '_'))
            case 'eat': self.eat_item(noun.replace(' ', '_'))

########################### MAIN ###########################################
window = Tk()
window.title("Room Adventure... REVOLUTIONS")
game = Game(window)
game.play()
window.mainloop()

# test
