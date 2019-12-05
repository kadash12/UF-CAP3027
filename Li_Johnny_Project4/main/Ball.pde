/* 
 This class represents a circle or ellipse; which also has movement via velocity.
 Has functions/methods on how to collide with: (1) Paddle and (2) Box objects.
 Feel free to add any helper methods/functions necessary.
 */

class Ball {
  //Declare class variables/members like position, velocity, diameter, speed, etc.
  PVector ballposition;
  PVector ballvelocity;
  int vel;

  //Constructor
  Ball(/* possible parameters needed to create a Ball */) {
    //Initialize variables needed to create a ball
    ballposition = new PVector(400, 600);
    ballvelocity = new PVector(0, 5);
  }

  //Perform actions necessary to update the current frame of the Ball
  void update() {
    ballposition.add(ballvelocity);
  }

  //Helper function to process Ball-Paddle collisions
  void collide_paddle(Paddle thePaddle) {
    //Hit left side of paddle move left
    if (RecVSC(thePaddle.location) && ballposition.x <= thePaddle.location.x+(150/3)) {
      ballvelocity = new PVector(-5, -5);
    }
    //Hit center bounce straight up
    else if (RecVSC(thePaddle.location) && ballposition.x <= (thePaddle.location.x+100)) {
      ballvelocity = new PVector(0, -5);
    }
    //Hit right side of paddle move right
    else if (RecVSC(thePaddle.location)) {
      ballvelocity = new PVector(5, -5);
    }
  }

  //Helper function to process Ball-Box collisions
  void collide_box(Box theBox) {     
   //Take an modified from https://yal.cc/rectangle-circle-intersection-test/
    float DeltaX =  ballposition.x - max(theBox.pos.x, min(ballposition.x, theBox.pos.x + 25));
    float DeltaY =  ballposition.y - max(theBox.pos.y, min(ballposition.y, theBox.pos.y + 25));
   //Check if condition is met
    if ((DeltaX * DeltaX + DeltaY * DeltaY) < (10 * 10)) {
      //Bounce back from hitting box
      ballvelocity = new PVector(ballvelocity.x, ballvelocity.y*-1);
      theBox.update();
    }
  }

  //Helper function to process Ball-Wall collisions (left, top, & right wall boundaries)
  void collide_wall() {
    //If ball hit side wall -> Keep y value and invert x value
    //Right Wall
    if (ballposition.x+10 >= width) {
      ballvelocity= new PVector(ballvelocity.x*(-1), ballvelocity.y);
    } 
    //Left Wall
    else if (ballposition.x-(10) <= 0) {
      ballvelocity = new PVector(ballvelocity.x*(-1), ballvelocity.y);
    }
    //If the ball hit top wall -> Keep x value and invert y value
    else if (ballposition.y-(10) <= 0) {
      ballvelocity = new PVector(ballvelocity.x, ballvelocity.y*-1);
    } else if (ballposition.y+(10) >= height) {
      //Lose Screen
      textSize(40);
      fill(0);
      text("You Lose!", width/2-100, 150);
    }
  }

  //Draws the current location of the Ball (circle or ellipse) after update() is processed 
  void draw () {
    //Draw ball
    fill(255);
    circle(ballposition.x, ballposition.y, 20);
  }

  //Rectange and circle collision.
  boolean RecVSC(PVector Rect) {
    //Take an modified from https://yal.cc/rectangle-circle-intersection-test/
    float DeltaX =  ballposition.x - max(Rect.x, min(ballposition.x, Rect.x + 150));
    float DeltaY =  ballposition.y - max(Rect.y, min(ballposition.y, Rect.y + 20));
    return (DeltaX * DeltaX + DeltaY * DeltaY) < (10 * 10);
  }
}
