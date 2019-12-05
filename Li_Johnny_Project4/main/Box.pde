/* 
 This class represents a rectangle (also a square).
 The Box disappears when the Ball collides into it .
 Feel free to add any helper methods/functions necessary.
 */
class Box {
  //Declare class variables/members necessary for a Box
  PVector pos = new PVector();
  color H;
  int points;
  boolean hit = false;

  //Constructor
  Box( PVector npos, color nH, int npoints, boolean nhit) {
    //Set the values for each new box
    this.H = nH;
    this.pos = npos;
    this.points = npoints;
    this.hit = nhit;
  }

  //Perform actions necessary to update the current frame of the Box
  void update() {
    //If hit box -> add square score
    if(hit==false) {
      //Reset hit
      hit = true;
      score += points;
    }
  }

  //Draws the current location of the Box (rectangle/square) [or hides it] after update() is processed
  void draw() {
    //If already hit dont draw again.
    if(!hit){
      //Draw Box
      colorMode(HSB, 360, 100, 100);
      fill(H, 100, 100);
      rect(pos.x, pos.y, 25, 25);      
      colorMode(RGB, 255, 255, 255);
    }
  }
}
