/*
 Johnny Li
 CAP3027
 Project 3: 3D Rendering
 */
//Using the ControlP5 library.
import controlP5.*;
ControlP5 cp5; 

//Global Variable
PVector vec = new PVector(-100, 0, 0);
boolean wheeled = false;
boolean pressed = false;
int temp = 1;
int scaled = 0;
//Camera object
cam object=null;

public void setup() {
  cp5 = new ControlP5(this);

  //Given size for 3D rendering
  size(800, 500, P3D); 
  //Projection Matrix
  perspective(radians(50.0f), width/(float)height, 0.1, 1000);   
  //Create Object Camera
  object=new cam();
}

public void draw() {
  //Reset
  background(155);
  
 //Update camera
  //object.Update();
  //Build Grid
  translate(width * 0.5, height * 0.5, 0);

  //rotateX(-5);
//  grid();
  //Build Monster
 // mon(); 
  //Build Cubes
  //cubes();
  fans();
}

//Build grid for the objects
//Origin (0, 0, 0)
//min and max of -100 and 100 on X and Z axes, lines every 10 units.
public void grid() {
  //White line every 10 units
  for (int i=0; i<21; i++) {
    stroke(255);
    line(-100, 0, -100+10*i, 100, 0, -100+10*i);
    line(-100+10*i, 0, -100, -100+10*i, 0, 100);
  }

  //Red line x
  stroke(255, 0, 0);
  line(-100, 0, 0, 100, 0, 0);
  //Blue line z
  stroke(0, 0, 255);
  line(0, 0, -100, 0, 0, 100);
}

//Check if spacebar is pressed
public void keyPressed() { 
  if (key == 32) {
    pressed=true;
    //Testing
    print("space pressed");
  }
}

//Check if mouse wheel is moved
public void mouseWheel(MouseEvent event) { 
  wheeled = true;
  scaled = event.getCount();
  //Testing
  print("wheel moved");
}

//Camera class
public class cam {
  //Global Variable
  float x;
  float y;
  float z;
  float theta;
  float phi;
  float scaleFactor = 0;
  float translateX = 0;
  float translateY = 0;
  int radius = 30;
  float zooming = 1;
  
  //Constructor
  public void cam() {
  }
  
  public void Update() {
    //Update Target and Zoom
    CycleTarget();
    scale(Zoom(scaled));
    //Map mouse position
    theta = map(mouseX, 0, width-1, 0, 360);
    phi = map(mouseY, 0, height-1, 1, 179);
    //Camera Positions
    float cameraPositionx = vec.x + radius*cos(phi)*sin(theta); 
    float cameraPositiony = vec.y + radius*cos(theta); 
    float cameraPositionz = vec.z + radius*sin(theta)*sin(phi); 

    /*camera(cameraPositionx, cameraPositiony, cameraPositionz, // Where is the camera?   
    vec.x, vec.y, vec.z, // Where is the camera looking?   
    0, 1, 0); // Camera Up vector (0, 1, 0 often, but not always, works)*/
    
     camera(width * 0.5-100,  height * 0.5-150,10, // Where is the camera?   
    width * 0.5-vec.x, height * 0.5- vec.y, 0-vec.z, // Where is the camera looking?   
    0, 1, 0); // Camera Up vector (0, 1, 0 often, but not always, works)*/
  }
  
  //Load the position of the images
  public void AddLookAtTarget(PVector vec) {
    //Reset vector
    vec.mult(0);
    //Reset counter to beginning
    if (temp == 5) {
      temp=1;
    }
    //Look at Taget
    switch(temp) {
    case 1: 
      vec.add(-100, 0, 0);
      break;
    case 2:
      vec.add(-50, 0, 0);
      break;
    case 3:
      vec.add(0, 0, 0);
      break;
    case 4:
      vec.add(75, 0, 0);
      break;
    }
    //Testing
    print(vec);
  };
  
  //Move to next traget
  public void CycleTarget() {
    if (pressed) {
      AddLookAtTarget(vec);
      //Item counter
      temp++;
      //Reset pressing to remove bouncing.
      pressed=false;
    }
  };
  
  //Zoom to target
  public float Zoom(float scaled) {
    if (wheeled) {
      //Scale image
      zooming += scaled*0.01;
      //Reset pressing to remove bouncing.
      wheeled=false;
      
      return zooming;
    } else {
      //Reset
      zooming = 1;
      return zooming;
    }
  };
}

//Monster object
public void mon(){
  //Monster generator
  PShape monster=loadShape("monster.obj");
  //Wireframe
 /* monster.setFill(true);
  monster.setFill(color(0,0,0,0));
  monster.setStroke(true);
  monster.setStroke(color(0));
  monster.setStrokeWeight(1.5f);
  //Positioning
  monster.scale(1,1,-1);  //Flip across x axis
  monster.translate(0, 0, 0);
  shape(monster);  //Full size*/
  monster.setStroke(true);
  monster.setStroke(color(190,230,60));
  monster.setFill(true);
  monster.setFill(color(190,230,60));
  monster.translate(0, 0, 0);
  monster.scale(0.5);
  shape(monster); //Half size*/
}

//Cubes generator
public void cubes(){
  //Cube position
   float theta;
  float phi;
   theta = map(mouseX, 0, width-1, 0, 360);
    phi = map(mouseY, 0, height-1, 1, 179);
  translate(0,0,0);
 int i=50;
 int j=10;
  //Small cube
  pushMatrix();
  translate(0,0,0);
  rotateY(theta);
  rotateZ(phi);
  //Cube shape
  beginShape(TRIANGLE);
  //noStroke();
  //FRONT
  fill(255,255,0);  //Yellow
  vertex(-0.5*i,-0.5*i,0.5*i);
  vertex(-0.5*i,0.5*i,0.5*i);
  vertex(0.5*i,0.5*i,0.5*i);
  fill(0,255,0);  //Green
  vertex(-0.5*i,-0.5*i,0.5*i);
  vertex(0.5*i,0.5*i,0.5*i);
  vertex(0.5*i,-0.5*i,0.5*i);
  //BACK
  fill(160,60,179);  //Purple
  vertex(-0.5*i,-0.5*i,-0.5*i);
  vertex(-0.5*i,0.5*i,-0.5*i);
  vertex(0.5*i,-0.5*i,-0.5*i);
  fill(0,128,200);  //Blue
  vertex(-0.5*i,0.5*i,-0.5*i);
  vertex(0.5*i,-0.5*i,-0.5*i);
  vertex(0.5*i,0.5*i,-0.5*i);
  //TOP
  fill(160,209,182);  //Teal
  vertex(-0.5*i,-0.5*i,0.5*i);
  vertex(0.5*i,-0.5*i,0.5*i);
  vertex(0.5*i,-0.5*i,-0.5*i);
  fill(247,107,0);  //Orange
  vertex(-0.5*i,-0.5*i,0.5*i);
  vertex(-0.5*i,-0.5*i,-0.5*i);
  vertex(0.5*i,-0.5*i,-0.5*i); 
  //Left
  fill(254,60,39);  //Red
  vertex(0.5*i,0.5*i,0.5*i);
  vertex(0.5*i,-0.5*i,0.5*i);
  vertex(0.5*i,0.5*i,-0.5*i); 
  fill(75,128,199);  //Light Blue
  vertex(0.5*i,-0.5*i,0.5*i);
  vertex(0.5*i,0.5*i,-0.5*i);
  vertex(0.5*i,-0.5*i,-0.5*i);
  //Bottom
  fill(254,0,0);  //Red
  vertex(0.5*i,0.5*i,0.5*i);
  vertex(-0.5*i,0.5*i,0.5*i);
  vertex(0.5*i,0.5*i,-0.5*i); 
  fill(250,2,251);  //Pink
  vertex(-0.5*i,0.5*i,0.5*i);
  vertex(0.5*i,0.5*i,-0.5*i);
  vertex(-0.5*i,0.5*i,-0.5*i);
  //Right
  fill(102,102,222);  //Blue
  vertex(-0.5*i,0.5*i,0.5*i);
  vertex(-0.5*i,-0.5*i,0.5*i);
  vertex(-0.5*i,-0.5*i,-0.5*i); 
  fill(180,180,150);  //Grey
  vertex(-0.5*i,0.5*i,0.5*i);
  vertex(-0.5*i,-0.5*i,-0.5*i);
  vertex(-0.5*i,0.5*i,-0.5*i);
  endShape();
  
  popMatrix();
}

//Fans generator
public void fans(){
  //Cube position
 // translate(-50,0,0);
 
  //Lots of triangle
  pushMatrix();
  translate(-70,0,0);
  fanshape(20);
  popMatrix();
  
  //Few of triangle
  pushMatrix();
  translate(70,0,0);
  fanshape(6);
  popMatrix();
}

//Build fan shape
public void fanshape(int segment){
  int col =0;
  //HSB color here for color
  colorMode(HSB, 360, 100, 100);
  beginShape(TRIANGLE_FAN);
  stroke(2);
  int i=50;
  rotateY(60);
  //Connectine Point
  fill(col,100,100);
  vertex(0,i,0);
  strokeWeight(2);
  //Segment Vertex
  for (float angle=0; angle<=360; angle += 360/segment) {
    float vx = i + cos(radians(angle))*i;
    float vy = i + sin(radians(angle))*i;
    
    col += 360/segment;
    fill(col, 100, 100);  //Coloring Segment
    vertex(vx, vy);
  }
  endShape();
}
