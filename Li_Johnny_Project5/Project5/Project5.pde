import java.io.*;    // Needed for BufferedReader
import queasycam.*;
import controlP5.*;

//Global Variable Given
QueasyCam cam;
ControlP5 cp5;
float xPos = 150;
float zPos = 300;
float speed = 1.0f;

ArrayList<Scene> scenes = new ArrayList<Scene>();
int currentScene = 0;

//Files
BufferedReader test;
BufferedReader s1;
BufferedReader s2;

void setup()
{  
  size(1200, 1000, P3D);
  //size(700, 700, P3D);
  pixelDensity(2);
  perspective(radians(60.0f), width/(float)height, 0.1, 1000);
  
  cp5 = new ControlP5(this);
  cp5.addButton("ChangeScene").setPosition(10, 10);
  
  cam = new QueasyCam(this);
  cam.speed = 0;
  cam.sensitivity = 0;
  cam.position = new PVector(0, -50, 100);

  // TODO: Load scene files here (testfile, scene 1, and scene 2)
  test = createReader("testfile.txt");
  s1 = createReader("scene1.txt");
  s2 = createReader("scene2.txt");
  
  //Add scenes to arraylist
  //scenes.add(new Scene(test)); 
  scenes.add(new Scene(s1)); 
  scenes.add(new Scene(s2)); 
  
  //Initialize scenes
  scenes.get(0).Update();
  scenes.get(1).Update();
  
  lights(); // Lights turned on once here
}

void draw()
{
  // Use lights, and set values for the range of lights. Scene gets REALLY bright this commented out...
  lightFalloff(1.0, 0.001, 0.0001);
  pushMatrix();
  rotateZ(radians(180)); // Flip everything upside down because Processing uses -y as up
  
  // TODO: Draw the current scene
  scenes.get(currentScene).DrawScene();
  
  popMatrix();
  
  camera();
  noLights(); // Turn lights off for ControlP5 to render correctly
  
  //Text
  DrawText();
}

//Given
void mousePressed()
{
  if (mouseButton == RIGHT)
  {
    // Enable the camera
    cam.sensitivity = 1.0f; 
    cam.speed = 2;
  }
}

//Given
void mouseReleased()
{  
  if (mouseButton == RIGHT)
  {
    // "Disable" the camera by setting move and turn speed to 0
    cam.sensitivity = 0; 
    cam.speed = 0;
  }
}

//Given
void ChangeScene()
{
  currentScene++;
  if (currentScene >= scenes.size())
    currentScene = 0;
}

//Given
void DrawText(){
  hint(DISABLE_DEPTH_TEST);
  textSize(30);
  fill(255);
  text("PShapes: " + scenes.get(currentScene).GetShapeCount(), 0, 70);
  text("Lights: " + scenes.get(currentScene).GetLightCount(), 0, 100);
  hint(ENABLE_DEPTH_TEST);
}
