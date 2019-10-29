import java.util.Calendar; //<>//

int handLen = 10;
int clockCount = 0;
int i = 0;

ClockGrid clocks = null;
int HH = 0;
int MM = 0;
int currentMillis = 0;
int prevMillis = 0;

int transition = 0;
Calendar currentTime = Calendar.getInstance();

void settings()
{
  size(500, 700);
}

void setup()
{
  background(0);
  stroke(255);
  strokeWeight(2); //<>//
  
  clocks = new ClockGrid(handLen);
  currentMillis = currentTime.get(Calendar.SECOND);
  prevMillis = currentMillis;
}

void draw()
{
  currentTime = Calendar.getInstance();
  currentMillis = currentTime.get(Calendar.SECOND);
  if (currentMillis - prevMillis > 0 || transition >= 1)
  {
    clocks.draw(currentTime.get(Calendar.HOUR), 
    currentTime.get(Calendar.MINUTE), currentTime.get(Calendar.SECOND), transition);
    prevMillis = currentMillis;
    
    if (prevMillis == 59)
      prevMillis = -1;
  }
}

void mousePressed()
{
   transition++;
   transition%=3;
   
   if (transition == 2)
   {
     clocks.reset();
   }
}
