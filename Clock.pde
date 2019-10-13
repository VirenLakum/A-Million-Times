class Clock
{
  float centreX = 0;
  float centreY = 0;
  PVector hand1 = new PVector();
  PVector hand2 = new PVector();
  float handLength1 = 0;
  float handLength2 = 0;
  boolean isSpecial = false;
  int special1 = 0;
  int special2 = 0;
  int currentAngle1 = 0;
  int currentAngle2 = 0;
  int clockId = 0;
  
  public Clock(float x, float y, float angle, float len, int id)
  {
    clockId = id;
    centreX = x;
    centreY = y;
    handLength1 = len;
    handLength2 = len*1;
    hand1.x = handLength1 * cos(angle) + centreX;
    hand1.y = handLength1 * sin(angle) + centreY;
    hand2.x = handLength2 * cos(angle+PI) + centreX;
    hand2.y = handLength2 * sin(angle+PI) + centreY; //<>//
  }
  
  public void setSpecial(int sp1, int sp2)
  {
    isSpecial = true;
    special1 = sp1;
    special2 = sp2;
  }
  
  public void setNotSpecial()
  {
    isSpecial = false;
  }
  
  public void draw()
  {
    line(centreX, centreY, hand1.x, hand1.y);
    line(centreX, centreY, hand2.x, hand2.y);
  }
  
  public void transition1()
  {
    setAngle(currentAngle1+1, currentAngle2-1);
  }
  
  public void transition2()
  {
    if (clockId % 2 == 0)
      setAngle(currentAngle1+1, currentAngle2-1);
    else
      setAngle(currentAngle1-1, currentAngle2+1);
  }
  
  public void setTime(int time)
  {
    int angle = 0;
    if (time >= 0 && time <=15)
      angle = (int)map(time, 0, 15, 270, 360);
    else if (time >= 16 && time <=59)
      angle = (int)map(time, 15, 60, 0, 270);
    setAngle(angle, angle);
  }
  
  //public void setAngle(float angle)
  //{
  //  hand1.x = handLength * cos(angle) + centreX;
  //  hand1.y = handLength * sin(angle) + centreY;
  //  hand2.x = handLength * cos(angle) + centreX;
  //  hand2.y = handLength * sin(angle) + centreY;
  //  draw();
  //}
  
  public void setAngle(float angle1, float angle2)
  {
    hand1.x = handLength1 * cos(angle1) + centreX;
    hand1.y = handLength1 * sin(angle1) + centreY;
    hand2.x = handLength2 * cos(angle2) + centreX;
    hand2.y = handLength2 * sin(angle2) + centreY;
    draw();
  }
  
  //public void setAngle(int angleInDegrees)
  //{
  //  float angle = map(angleInDegrees, 0, 361, 0, TWO_PI);
  //  setAngle(angle);
  //}
  
  public void setAngle(int angleInDegrees1, int angleInDegrees2)
  {
    currentAngle1 = angleInDegrees1;
    currentAngle2 = angleInDegrees2;
    if (isSpecial)
    {
      angleInDegrees1 = special1;
      angleInDegrees2 = special2;
    }
    float angle1 = map(angleInDegrees1%361, 0, 361, 0, TWO_PI);
    float angle2 = map(angleInDegrees2%361, 0, 361, 0, TWO_PI);
    setAngle(angle1, angle2);
  }
}
