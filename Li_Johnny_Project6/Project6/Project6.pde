// VertexAnimation Project - Student Version
//No time to finish (:C)
import java.io.*;
import java.util.*;

/*========== Monsters ==========*/
/*Animation monsterAnim;
 ShapeInterpolator monsterForward = new ShapeInterpolator();
 ShapeInterpolator monsterReverse = new ShapeInterpolator();
 ShapeInterpolator monsterSnap = new ShapeInterpolator();
 
/*========== Sphere ==========*/
/*Animation sphereAnim; // Load from file
 Animation spherePos; // Create manually
 ShapeInterpolator sphereForward = new ShapeInterpolator();
 PositionInterpolator spherePosition = new PositionInterpolator();*/

// TODO: Create animations for interpolators
ArrayList<PositionInterpolator> cubes = new ArrayList<PositionInterpolator>();

//Global Variable
PVector vec = new PVector(0, 0, 0);
PVector cameraPosition = new PVector(0, 0, 0);
boolean wheeled = false;
boolean pressed = false;
int temp = 0;
float scaled = 0;
//Camera object
cam object=null;

void setup()
{
  pixelDensity(2);
  size(1200, 800, P3D);
  //size(800, 800, P3D);
  noStroke();

  /*====== Load Animations ======*/
  // monsterAnim = ReadAnimationFromFile("monster.txt");
  // sphereAnim = ReadAnimationFromFile("sphere.txt");
  /*
  monsterForward.SetAnimation(monsterAnim);
   monsterReverse.SetAnimation(monsterAnim);
   monsterSnap.SetAnimation(monsterAnim);  
   monsterSnap.SetFrameSnapping(true);
   sphereForward.SetAnimation(sphereAnim);
   
  /*====== Create Animations For Cubes ======*/
  //Make KeyFrames of Cube
  ArrayList<KeyFrame> cubePos = new ArrayList<KeyFrame>();
  cubePos.add(new KeyFrame(0.5f, new PVector(0, 0, 0)));  //KeyFrame 0
  cubePos.add(new KeyFrame(1.0f, new PVector(0, 0, -100)));  //KeyFrame 1
  cubePos.add(new KeyFrame(1.5f, new PVector(0, 0, 0)));  //KeyFrame 2
  cubePos.add(new KeyFrame(2.0f, new PVector(0, 0, 100)));  //KeyFrame 3

  // When initializing animations, to offset them
  // you can "initialize" them by calling Update()
  // with a time value update. Each is 0.1 seconds
  // ahead of the previous one
  Animation cubing = new Animation(cubePos);
  //For each cube set animation
  for (int i=0; i<11; i++) {
    PositionInterpolator PI = new PositionInterpolator();  //Set interpolating cubes
    PI.SetAnimation(cubing);

    if (i%2==1) {  //Every other cube / Odds
      PI.SetFrameSnapping(true); //Set snapping cubes
    }
    //Delay
    PI.Update(0.1f*i);
    cubes.add(PI); //Add to cube array list
  }

  /*====== Create Animations For Spheroid ======*/
  //Animation spherePos = new Animation();
  // Create and set keyframes
  // spherePosition.SetAnimation(spherePos);

  //Projection Matrix
  perspective(-radians(50.0f), width/(float)height, 0.1, 1000);   
  translate(width * 0.5, height * 0.5, 0);
  //Create Object Camera
  object=new cam();
}

void draw()
{
  lights();
  background(0);
  DrawGrid();

  float playbackSpeed = 0.005f;
  // TODO: Implement your own camera
  object.Update(); //Update camera
  /*====== Draw Forward Monster ======*/
  /* pushMatrix();
   translate(-40, 0, 0);
   monsterForward.fillColor = color(128, 200, 54);
   monsterForward.Update(playbackSpeed);
   //shape(monsterForward.currentShape);
   popMatrix();
   
  /*====== Draw Reverse Monster ======*/
  /*pushMatrix();
   translate(40, 0, 0);
   monsterReverse.fillColor = color(220, 80, 45);
   monsterReverse.Update(-playbackSpeed);
   //shape(monsterReverse.currentShape);
   popMatrix();
   
  /*====== Draw Snapped Monster ======*/
  /* pushMatrix();
   translate(0, 0, -60);
   monsterSnap.fillColor = color(160, 120, 85);
   monsterSnap.Update(playbackSpeed);
   //shape(monsterSnap.currentShape);
   popMatrix();
   
  /*====== Draw Spheroid ======*/
  /* spherePosition.Update(playbackSpeed);
   sphereForward.fillColor = color(39, 110, 190);
   sphereForward.Update(playbackSpeed);
   PVector pos = spherePosition.currentPosition;
   pushMatrix();
   //translate(pos.x, pos.y, pos.z);
   //shape(sphereForward.currentShape);
   popMatrix();
   
  /*====== TODO: Update and draw cubes ======*/
  // For each interpolator, update/draw
  boolean red=true;  //Color check
  PShape cube = createShape(BOX, 10);  //Cube shape
  cube.setStroke(false);  //No Stroke
  cube.setFill(true);  //Yes color
  //Loop to create cubes
  for (int i=0; i<11; i++) {
    cubes.get(i).Update(playbackSpeed);  //Update cube
    if (red) {
      cube.setFill(color(255, 0, 0));  //Red cube
      red=false;
    } else {
      cube.setFill(color(255, 255, 0));  //Yellow cube
      red=true;
    }
    pushMatrix();
    translate(cubes.get(i).currentPosition.x+100-20*i, 0, cubes.get(i).currentPosition.z);  //Move cube
    shape(cube);
    popMatrix();
  }
}

void mouseWheel(MouseEvent event)
{
  float e = event.getCount();
  wheeled = true;  // Zoom the camera
  scaled = e;
}
/*
// Create and return an animation object
 Animation ReadAnimationFromFile(String fileName)
 {
 Animation animation = new Animation();
 
 // The BufferedReader class will let you read in the file data
 //try
 //{
 //  BufferedReader reader = createReader(fileName);
 
 //}
 //catch (FileNotFoundException ex)
 //{
 //  println("File not found: " + fileName);
 //}
 //catch (IOException ex)
 //{
 //  ex.printStackTrace();
 //}
 
 return animation;
 }*/

void DrawGrid()
{
  pushMatrix();
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
  popMatrix();
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
  int radius = 200;
  float zooming = 1;

  //Constructor
  public void cam() {
  }

  public void Update() {
    //Update Target and Zoom
    CycleTarget();
    //Map mouse position
    theta = radians(map(mouseY, 0, width-1, 0, 360));
    phi = radians(map(mouseX, 0, height-1, 1, 179));
    //Camera Positions
    cameraPosition.x = vec.x + radius*cos(phi)*sin(theta); 
    cameraPosition.y = vec.y + radius*cos(theta); 
    cameraPosition.z = vec.z + radius*sin(theta)*sin(phi); 

    camera(cameraPosition.x*abs(Zoom(scaled)), cameraPosition.y*abs(Zoom(scaled)), cameraPosition.z*abs(Zoom(scaled)), // Where is the camera?   
      vec.x, vec.y, vec.z, // Where is the camera looking?   
      0, 1, 0); // Camera Up vector (0, 1, 0 often, but not always, works)
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
      zooming += scaled*0.2;
      //Reset pressing to remove bouncing.
      wheeled=false;
      //Testing
      print("wheel moved");
      return zooming;
    } else {
      return zooming;
    }
  };
}
