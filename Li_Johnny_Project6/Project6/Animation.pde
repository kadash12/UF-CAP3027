// Snapshot in time of some amount of data
class KeyFrame
{
  //Constructor 1
  public KeyFrame(float t, PVector p) {
    //Set Values
    this.time=t;
    this.points=new ArrayList();
    points.add(p);   //Add to ArrayList<PVector>
  }

  //Constructor 2
  public KeyFrame(float t, ArrayList<PVector> p) {
    //Set Values
    this.time=t;
    this.points=p;
  }

  // Where does this thing occur in the animation?
  public float time;

  // Because translation and vertex positions are the same thing, this can
  // be reused for either. An array of one is perfectly viable.
  public ArrayList<PVector> points = new ArrayList<PVector>();
}

class Animation
{
  //Construction
  Animation(ArrayList<KeyFrame> kf) {
    this.keyFrames=kf;
  }

  // Animations start at zero, and end... here
  float GetDuration()
  {
    return keyFrames.get(keyFrames.size()-1).time;
  }

  ArrayList<KeyFrame> keyFrames = new ArrayList<KeyFrame>();

  //Check surrounding KeyFrames
  KeyFrame[] sFrames(float time) {
    KeyFrame[] temp = new KeyFrame[2];  //temp keyframe holder
    KeyFrame next = keyFrames.get(0);  //next keyframe
    KeyFrame prev = keyFrames.get(keyFrames.size()-1);

    //Positive 
    if (next.time<time) {
      //Loop keyframes
      for (KeyFrame k : keyFrames) {
        next=k;  //set keyframe
        //Check if error
        if (k.time>time && time>prev.time) {
          break;
        } else {
          //Ordering
          prev=k;
        }
      }
    }
    //Update frames
    temp[0]=prev;
    temp[1]=next;
    return temp;
  }
}
