class Scene
{
  //Global Variable
  BufferedReader file;  //Txt
  PVector backcolor = new PVector();  //Background color
  int snum=0;  //Number of shapes
  String shape[];  //Name of Shapes
  float spos[][];  //Shape position
  int scolor[][];  //Shape color
  int lnum=0;  //Number of lights
  float lpos[][];  //light position
  int lcolor[][];  //light color

  // TODO: Write this class!
  //Store values
  void Update() {
    try {
      //Get background color 1's line
      String line = file.readLine();  //Read line
      String value[] = line.split(",");  //Split parts
      backcolor.add(Integer.parseInt(value[0]), Integer.parseInt(value[1]), Integer.parseInt(value[2]));  //Background color
      //Get Number of Shapes 2's line
      line = file.readLine();
      snum = Integer.parseInt(line);  //Numer of shapes 
      //Get shape model and positions and color
      shape=new String[snum];  //Set shape size
      spos=new float[snum][3];  //Set postion size
      scolor=new int[snum][3];  //Set color size
      for(int i=0; i<snum; i++){  //Loop through all
        line = file.readLine();
        value = line.split(",");
        shape[i] = value[0];  //Shape name
        spos[i][0]=Float.parseFloat(value[1]);  //x  //Store position of shape
        spos[i][1]=Float.parseFloat(value[2]);  //y
        spos[i][2]=Float.parseFloat(value[3]);  //z
        scolor[i][0]=Integer.parseInt(value[4]);  //R  //Store color of shape
        scolor[i][1]=Integer.parseInt(value[5]);  //G
        scolor[i][2]=Integer.parseInt(value[6]);  //B
      }  
      //Get Number of lights
      line = file.readLine();
      lnum = Integer.parseInt(line);  //Number of lighrs
      //Get light positions and color
      lpos=new float[lnum][3];  //Set postion size
      lcolor=new int[lnum][3];  //Set color size
      for(int i=0; i<lnum; i++){  //Loop through all
        line = file.readLine();
        value = line.split(",");
        lpos[i][0]=Float.parseFloat(value[0]);  //x  //Store position of shape
        lpos[i][1]=Float.parseFloat(value[1]);  //y
        lpos[i][2]=Float.parseFloat(value[2]);  //z
        lcolor[i][0]=Integer.parseInt(value[3]);  //R  //Store color of shape
        lcolor[i][1]=Integer.parseInt(value[4]);  //G
        lcolor[i][2]=Integer.parseInt(value[5]);  //B
      }
    }
    catch(IOException e) {
      // In case something went wrong during the processe.
      e.printStackTrace();
    }   
  }

  //Constructor
  Scene(BufferedReader files) {
    this.file=files;  //Set file
  }

  void DrawScene()
  {
    // TODO: Draw all the information in this scene
    //Reset
    background(backcolor.x, backcolor.y, backcolor.z);
    
    //Light Creation
    for(int i=0; i<lnum; i++){
      //Light Color and Position
      pointLight(lcolor[i][0],lcolor[i][1],lcolor[i][2],lpos[i][0],lpos[i][1],lpos[i][2]);
    }
    //Shape Creation
    for(int j=0; j<snum; j++){
      //Load object
      PShape model=loadShape(shape[j]+".obj"); 
      
      pushMatrix();
      model.setFill(true);  //Color of shape
      model.setFill(color(scolor[j][0],scolor[j][1],scolor[j][2]));
      model.setStroke(false);
      model.translate(spos[j][0], spos[j][1], spos[j][2]); //Positioning
      shape(model);
      popMatrix();
    }
  }

  //Return number of shapes
  int GetShapeCount() {
    return snum;
  };

  //Return number of lights
  int GetLightCount() {
    return lnum;
  }
}
