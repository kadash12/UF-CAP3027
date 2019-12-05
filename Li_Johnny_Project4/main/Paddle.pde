/* 
 This class represents a rectangle.
 It can also handle movement via keyboard input.
 Feel free to add any helper methods/functions necessary.
 */

class Paddle {
  //Declare class variables/members like position, velocity, size, speed, etc.
  PVector location;  //Store location of paddle
  int position;  //Changing position

  //Constructor
  Paddle(/* possible parameters needed to create a Paddle */) {
    position = 0;
    location = new PVector(width/2-80, 700);  //Initial position
  }

  //Perform actions necessary to update the current frame of the Paddle
  void update() {
    location = new PVector(width/2-80+position, 700);
  }

  //Draws the current location of the Paddle (rectangle) after update() is processed
  void draw() {
    //Draw paddle
    fill(0);
    rect(location.x, 700, 150, 20);
  }
}
