/*
 Johnny Li
 CAP3027
 Project 1: Random Walk
 */

//Using the ControlP5 library.
import controlP5.*;
ControlP5 cp5;

//Global Variables
Button START; 
Slider ITERATION;
Slider stepcount;
CheckBox toggle;
int x;  //Current Point Length
int y;  //Current Point Height
int step=1;  //Step size
int temp=0;  //Temp variable
boolean on=false;  //START button was pressed.
boolean coloron=false;  //COLOR button was pressed.
boolean gradualon=false;  //GRADUAL button was pressed.
int run;  //Get Iteration value when on gradual

void setup() {
  cp5 = new ControlP5(this);

  //Given: window of size(800, 800)
  size(800, 800);

  //Blue background
  background(140, 170, 209);

  //Create START button
  START=cp5.addButton("START")
    .setPosition(10, 10)
    .setSize(70, 30)
    ;

  //Create COLOR and GRADUAL toggle
  toggle=cp5.addCheckBox("toggle")
    .setPosition(100, 10)
    .setSize(30, 30)
    .setColorActive(color(0, 170, 255))
    .addItem("COLOR", 0)
    .addItem("GRADUAL", 1);
  ;

  //Create ITERATION and STEP COUNT slider
  ITERATION=cp5.addSlider("ITERATION")
    .setPosition(180, 10)
    .setSize(300, 30)
    .setRange(1000, 500000)
    ;
  stepcount=cp5.addSlider("STEP COUNT")
    .setPosition(180, 41)
    .setSize(300, 30)
    .setRange(1, 1000)
    ;
}

//Random Walk Algorithm - Drawing but gradually
public void draw() {  
  //Check if gradual checkbox is slected.
  if(gradualon && on){
    //Get Step Count rate 
    int rate = (int)stepcount.getValue();
    
    //Go through all the iterations
    if(temp<run){
      //Step Count rate per frame
      for(int i=0; i<rate; i++){
        //Check if color checkbox is slected.
        if(coloron){
          //Change color scale
          stroke((int)map(temp,0,run,0,255));
        }
        
        //Switch Case of Direction
        switch(randomwalk()) {
        case 0: 
          //Move Up
          y=y+step;
          //Clump boundary of top of Y
          if (y>800) {
            y=y-step;
          } 
          //Plot point
          else {
            point(x, y+step);
            break;
          }
        case 1: 
          //Move Down
          y=y-step;
          //Clump boundary of bottom of Y
          if (y<0) {
            y=y+step;
          } 
          //Plot point
          else {
            point(x, y-step);
            break;
          }
        case 2: 
          //Move Left
          x=x-step;
          //Clump boundary of bottom of X
          if (x<0) {
            x=x+step;
          } 
          //Plot point
          else {
            point(x-step, y);
            break;
          }
        case 3: 
          //Move Right
          x=x+step; 
          //Clump boundary of top of X
          if (x>800) {
            x=x-step;
          } 
          //Plot point
          else {
            point(x+step, y);
            break;
          }
        }
        //Increment 
        temp++;
      }
    }
  }
}

//Random Walk Algorithm - Moving
public int randomwalk() {
  //Generate a random number
  int walk =(int)random(4);
  /* 
   0=Up
   1=Down
   2=Left
   3=Right
   */
  return walk;
}

//START button function
public void START() {
  //Reset program
  clear();
  background(140, 170, 209);
  temp=0;
  on=false;
  coloron=false;
  gradualon=false;
  
  //Point Art
  stroke(0);
  strokeWeight(1);
  //Initial point middle of screen-black
  x=y=400;
  point(x, y);

  //Get Iteration value
  run = (int)ITERATION.getValue();
  
  //Check if COLOR button was pressed.
  if(toggle.getState(0)){
    //COLOR button was pressed.
    coloron=true;
  }
  
  //Check if gradual checkbox is selected.
  if(toggle.getState(1)){
    //GRADUAL button was pressed.
    gradualon=true;
    //START button was pressed.
    on=true;
    draw();  
  }
  else{
    //Check if start has been clicked if so draw random walk.  
    randomdraw();
  }
}

//Random Walk Algorithm - Drawing
public void randomdraw() {
  //Get Iteration value
  int runs = (int)ITERATION.getValue();
  
  //Go through all the iterations
  for (int i=0; i<runs; i++) {
    //Check if color checkbox is slected.
    if(toggle.getState(0)){
      //Change color scale
      stroke((int)map(i,0,runs,0,255));
    }    
    //Switch Case of Direction
    switch(randomwalk()) {
    case 0: 
      //Move Up
      y=y+step;
      //Clump boundary of top of Y
      if (y>800) {
        y=y-step;
        continue;
      } 
      //Plot point
      else {
        point(x, y+step);
        break;
      }
    case 1: 
      //Move Down
      y=y-step;
      //Clump boundary of bottom of Y
      if (y<0) {
        y=y+step;
        continue;
      } 
      //Plot point
      else {
        point(x, y-step);
        break;
      }
    case 2: 
      //Move Left
      x=x-step;
      //Clump boundary of bottom of X
      if (x<0) {
        x=x+step;
        continue;
      } 
      //Plot point
      else {
        point(x-step, y);
        break;
      }
    case 3: 
      //Move Right
      x=x+step; 
      //Clump boundary of top of X
      if (x>800) {
        x=x-step;
        continue;
      } 
      //Plot point
      else {
        point(x+step, y);
        break;
      }
    }
  }
}
