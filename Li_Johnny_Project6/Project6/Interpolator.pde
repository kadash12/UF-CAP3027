abstract class Interpolator
{
  Animation animation;

  // Where we at in the animation?
  float currentTime = 0;

  // To interpolate, or not to interpolate... that is the question
  boolean snapping = false;

  void SetAnimation(Animation anim)
  {
    animation = anim;
  }

  void SetFrameSnapping(boolean snap)
  {
    snapping = snap;
  }

  void UpdateTime(float time)
  {
    // TODO: Update the current time
    // Check to see if the time is out of bounds (0 / Animation_Duration)
    if (time>0) {    
      if (currentTime>animation.GetDuration()) {
        // If so, adjust by an appropriate amount to loop correctly
        currentTime=currentTime%animation.GetDuration();
      } else {
        currentTime = currentTime + time;
      }
    } else if (time<0) {
      if (currentTime<0) {
        // If so, adjust by an appropriate amount to loop correctly
        currentTime=animation.GetDuration()-currentTime%animation.GetDuration();
      } else {
        currentTime = currentTime + time;
      }
    }
  }

  //Solve timing ratio
  float ratio(float curr, float start, float end) {
    float r = (curr-start)/(end-start);
    if (r>1) {  //Positive
      return (currentTime/end);
    } else {
      return r;
    }
  } 

  // Implement this in derived classes
  // Each of those should call UpdateTime() and pass the time parameter
  // Call that function FIRST to ensure proper synching of animations
  abstract void Update(float time);
}

class ShapeInterpolator extends Interpolator
{
  // The result of the data calculations - either snapping or interpolating
  PShape currentShape;

  // Changing mesh colors
  color fillColor;

  PShape GetShape()
  {
    return currentShape;
  }

  void Update(float time)
  {
    // TODO: Create a new PShape by interpolating between two existing key frames
    // using linear interpolation

  }
}

class PositionInterpolator extends Interpolator
{
  //Initial position
  PVector currentPosition = new PVector(0, 0, 0);

  void Update(float time)
  {
    // The same type of process as the ShapeInterpolator class... except
    // this only operates on a single point
    UpdateTime(time); 
    
    KeyFrame[] frame = animation.sFrames(currentTime);
    //Get ratio
    float rat = ratio(currentTime, frame[0].time, frame[1].time);

    //Snapping one frame at a time
    if (snapping) {
      if (frame[1].time>=(currentTime+0.001)) {
        currentPosition = frame[1].points.get(0);
        return;
      }
    }

    PVector pPos=frame[0].points.get(0);  //previous position
    PVector nPos=frame[1].points.get(0);  //next position

    //Set position
    float x=nPos.x-pPos.x;
    float y=nPos.y-pPos.y;
    float z=nPos.z-pPos.z;

    //Update position
    currentPosition=new PVector(pPos.x+(rat*x), pPos.y+(rat*y), pPos.z+(rat*z));
  }
}
