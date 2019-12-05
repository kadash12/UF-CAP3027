/*  //<>// //<>//
 This class is the brains of the game.
 Handles how the game is run especially interactions between the Ball, Paddle, and Box objects.
 Feel free to add any helper methods/functions necessary.
 */

class GameState {
  //Declare class variables/members necessary to help with running the game
  boolean pause = false;
  Box[] rows = new Box[60];
  int boxsize = 20;

  //Declare class objects for the game: a Ball, Paddle, collection of Boxes, etc.
  Ball balling;
  Box boxing;
  Paddle paddling;

  //Constructor
  GameState(/* possible parameters needed to create a GameState */) {
    balling = new Ball();
    paddling = new Paddle();

    //Load Boxes
    for (int i = 0; i<6; i++) {  //Loop rows
      for (int j = 0; j<10; j++) {  //Loop column
        //Load values parameters in boxes.
        Box boxing = new Box(new PVector(180+j*40, 180+30*i), 40*i, 6-i, false);
        //Store the boxes in the array.
        rows[i*10+j] = boxing;
      }
    }
  }

  //Call update() on respective game objects: Ball, Box(es), and/or Paddle
  //Handle interactions of current state of game at every frame
  void update() {
    //Check if not pause to update.
    if (pause == false) {
      paddling.update();
    }
    //Update ball, all collision
    balling.collide_wall();
    balling.collide_paddle(paddling);
    for(int i=0; i<60; i++){
        //Check if already hit, ignore
        if(!rows[i].hit){
         balling.collide_box(rows[i]);
        } 
       }
     //Pause condition
    if(!pause){
      balling.update();
    } 
  }

  //Draws the current state of the Game
  void draw() {
    //Draw Paddle
    paddling.draw();
    //Draw all Box
    for (int i = 0; i<6; i++) {  //Rows
      for (int j = 0; j<10; j++) {  //Columns
        rows[i*10+j].draw();
      }
    }
    //Draw Ball
    balling.draw();
  }

  //Handles what happens when specific keys on the keyboard is pressed
  void keyPressed() {
    //If pause do nothing.
    if (pause == false) {
      //A key
      if ((key == 97)&& !(paddling.location.x<=-5)) {  //Bounary of left side
        //Move left by 25
        paddling.position -= 35;
        //Testing
        print("a pressed ");
      }
      //D key
      else if ((key == 100)&& !(paddling.location.x>=670)) {  //Boundary of right side
         //Move right by 25
        paddling.position += 35;
        //Testing
        print("d pressed ");
      }
    }
    //P key
    if (key == 112) {
      //If pausing -> turn off.
      if (pause == true) {
        pause = false;
      }
      //If not pause -> turn on.
      else if (pause != true) {
        pause = true; 
        print("pause");
      }
      //Testing
      print("p pressed ");
    }
  }

  //Handles what happens when specific keys on the keyboard is released
  void keyReleased() {
  }
}
