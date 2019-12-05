import controlP5.*;

//Objects declared to create the UI (ControlP5) and GameState
ControlP5 cp5;
GameState gs;

//Global Variable
int score = 0;

//Initalize window settings, objects, etc. to start the game 
void setup() {
  cp5 = new ControlP5(this);
  //Given size
  size(800, 800); 
  background(150); 

  //Reset Button
  Button Reset;
  Reset = cp5.addButton("Reset")
    .setPosition(0, 0)
    .setSize(100, 50);

  //Score Text
  textSize(40);
  fill(0);
  text("score = "+score, width/2-100, 50); 
  
  //Gamestate Object
  gs = new GameState();
}

//Reset button function
public void Reset() {
  //Make new gamestate to reset.
  gs = new GameState();
  //Reset score
  score = 0;
}

//Updates the GameState every frame
void draw() {
  //Reset
  background(150); 
  fill(0);
  text("score = "+score, width/2-100, 50); 
  
  //Win screen
  if(score == 210){
     //Lose Screen
      textSize(40);
      fill(0);
      text("You Win!", width/2-100, 150);
  }
  else{
    //Draw GameState
    gs.update();
    gs.draw();
  }
}


//Handles when keyboard input is pressed
void keyPressed() {
  gs.keyPressed();
}


//Handles when keyboard input is released
void keyReleased() {
  gs.keyReleased();
}
