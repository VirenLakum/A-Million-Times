class ClockGrid
{
  Clock[][] ClockGrid = null;
  int handLen = 0;
  int clockCount = 0;
  int countX = 0;
  int countY = 0;
  int minute = 0;
  int hour = 0;
  int seconds = 0;
  int[] Q1 = {270,0};
  int[] Q2 = {0,90};
  int[] Q3 = {90,180};
  int[] Q4 = {270,180};
  int[] HORIZONTAL = {180,0};
  int[] VERTICAL = {270,90};
  int[] BOTH_DOWN = {90,90};
  int[] BOTH_UP = {270,270};
  int[] NOT_SPL = {-1, -1};
  
  public ClockGrid(int len)
  {
    handLen = len; //<>//
    countX = (width/handLen-1)/2;
    countY = (height/handLen-1)/2;
    clockCount = countX * countY;
    ClockGrid = new Clock[countX][countY];
    
    println(clockCount);
    println(countX);
    println(countY);
    
    for (int x=1; x<=countX; x++)
    {
      for (int y=1; y<=countY; y++)
      {
        ClockGrid[x-1][y-1] = new Clock(x*handLen*2, y*handLen*2, 0, handLen, x); //<>//
        if (x%2 != 0)
          ClockGrid[x-1][y-1].setAngle(315, 45);
        else
          ClockGrid[x-1][y-1].setAngle(135, 225);
      }
    }
  }
  
  public void reset()
  {
    for (int x=0; x<countX; x++)
    {
      for (int y=0; y<countY; y++)
      {
        if (x%2 != 0)
          ClockGrid[x][y].setAngle(315, 45);
        else
          ClockGrid[x][y].setAngle(135, 225);
        ClockGrid[x][y].transition1();
      }
    }
  }
  
  public void draw(int HH, int mm, int sec, int transition)
  {
    showTime(HH, mm, sec);
    background(0);
    for (int x=0; x<countX; x++)
    {
      for (int y=0; y<countY; y++)
      {
        switch(transition)
        {
          case 0:
            ClockGrid[x][y].setTime(sec);
            break;
          case 1:
            ClockGrid[x][y].transition1();
            break;
          case 2:
            ClockGrid[x][y].transition1();
            break;
        }
      }
    } 
  }
  
  private void showTime(int HH, int mm, int ss)
  {
    int midClockX = countX/2;
    int midClockY = countY/2;
    
    int hour1StartX = midClockX - 3;
    int hour2StartX = midClockX ;
    int min1StartX = midClockX - 3;
    int min2StartX = midClockX;
    int sec1StartX = midClockX - 3;
    int sec2StartX = midClockX;
    
    int hour1StartY = midClockY - 9;
    int hour2StartY = midClockY - 9;
    int min1StartY = midClockY - 3;
    int min2StartY = midClockY - 3;
    int sec1StartY = midClockY + 3;
    int sec2StartY = midClockY + 3;
    
    drawDigit(hour1StartX, hour1StartY, HH/10);
    drawDigit(hour2StartX, hour2StartY, HH%10);
    drawDigit(min1StartX, min1StartY, mm/10);
    drawDigit(min2StartX, min2StartY, mm%10);
    drawDigit(sec1StartX, sec1StartY, ss/10);
    drawDigit(sec2StartX, sec2StartY, ss%10);
  }
  
  public void drawDigit(int startPosX, int startPosY, int digit)
  {
    int[][][] number = getDigit(digit);
    for (int x=startPosX, i=0; x<startPosX+3; x++, i++)
    {
      for (int y=startPosY, j=0; y<startPosY+6; y++, j++)
      {
        if (number[i][j][0] != -1 && number[i][j][1] != -1)
          ClockGrid[x][y].setSpecial(number[i][j][0], number[i][j][1]);
        else
          ClockGrid[x][y].setNotSpecial();
      }
    }
  }
  
  private int[][][] getDigit(int digit)
  {
    switch(digit)
    {
      case 0:
        return getZero();
      case 1:
        return getOne();
      case 2:
        return getTwo();
      case 3:
        return getThree();
      case 4:
        return getFour();
      case 5:
        return getFive();
      case 6:
        return getSix();
      case 7:
        return getSeven();
      case 8:
        return getEight();
      case 9:
        return getNine();
    }
    return null;
  }
  
  private int[][][] getZero()
  {
    int[][][] zero = new int[3][6][];
    zero[0][0] = Q2;         zero[1][0] = HORIZONTAL;          zero[2][0] = Q3;
    zero[0][1] = VERTICAL;   zero[1][1] = BOTH_DOWN;           zero[2][1] = VERTICAL;
    zero[0][2] = VERTICAL;   zero[1][2] = VERTICAL;            zero[2][2] = VERTICAL;
    zero[0][3] = VERTICAL;   zero[1][3] = VERTICAL;            zero[2][3] = VERTICAL;
    zero[0][4] = VERTICAL;   zero[1][4] = BOTH_UP;             zero[2][4] = VERTICAL;
    zero[0][5] = Q1;         zero[1][5] = HORIZONTAL;          zero[2][5] = Q4;
    
    return zero;
  }
  
  private int[][][] getOne()
  {
    int[][][] num = new int[3][6][];
    num[0][0] = NOT_SPL;   num[1][0] = Q2;          num[2][0] = Q3;
    num[0][1] = NOT_SPL;   num[1][1] = VERTICAL;    num[2][1] = VERTICAL;
    num[0][2] = NOT_SPL;   num[1][2] = VERTICAL;    num[2][2] = VERTICAL;
    num[0][3] = NOT_SPL;   num[1][3] = VERTICAL;    num[2][3] = VERTICAL;
    num[0][4] = NOT_SPL;   num[1][4] = VERTICAL;    num[2][4] = VERTICAL;
    num[0][5] = NOT_SPL;   num[1][5] = Q1;          num[2][5] = Q4;
    
    return num;
  }
  
  private int[][][] getTwo()
  {
    int[][][] num = new int[3][6][];
    num[0][0] = Q2;       num[1][0] = HORIZONTAL;  num[2][0] = Q3;
    num[0][1] = Q1;       num[1][1] = Q3;          num[2][1] = VERTICAL;
    num[0][2] = Q2;       num[1][2] = Q4;          num[2][2] = VERTICAL;
    num[0][3] = VERTICAL; num[1][3] = Q2;          num[2][3] = Q4;
    num[0][4] = VERTICAL; num[1][4] = Q1;          num[2][4] = Q3;
    num[0][5] = Q1;       num[1][5] = HORIZONTAL;  num[2][5] = Q4;
    
    return num;
  }
  
  private int[][][] getThree()
  {
    int[][][] num = new int[3][6][];
    num[0][0] = Q2;       num[1][0] = HORIZONTAL;  num[2][0] = Q3;
    num[0][1] = Q1;       num[1][1] = Q3;          num[2][1] = VERTICAL;
    num[0][2] = Q2;       num[1][2] = Q4;          num[2][2] = VERTICAL;
    num[0][3] = Q1;       num[1][3] = Q3;          num[2][3] = VERTICAL;
    num[0][4] = Q2;       num[1][4] = Q4;          num[2][4] = VERTICAL;
    num[0][5] = Q1;       num[1][5] = HORIZONTAL;  num[2][5] = Q4;
    
    return num;
  }
  
  private int[][][] getFour()
  {
    int[][][] num = new int[3][6][];
    num[0][0] = Q2;         num[1][0] = Q3;        num[2][0] = NOT_SPL;
    num[0][1] = VERTICAL;   num[1][1] = VERTICAL;  num[2][1] = NOT_SPL;
    num[0][2] = VERTICAL;   num[1][2] = Q1;        num[2][2] = Q3;
    num[0][3] = Q1;         num[1][3] = Q3;        num[2][3] = VERTICAL;
    num[0][4] = NOT_SPL;  num[1][4] = VERTICAL;  num[2][4] = VERTICAL;
    num[0][5] = NOT_SPL;  num[1][5] = Q1;        num[2][5] = Q4;
    
    return num;
  }
  
  private int[][][] getFive()
  {
    int[][][] num = new int[3][6][];
    num[0][0] = Q2;         num[1][0] = HORIZONTAL;  num[2][0] = Q3;
    num[0][1] = VERTICAL;   num[1][1] = Q2;          num[2][1] = Q4;
    num[0][2] = VERTICAL;   num[1][2] = Q1;          num[2][2] = Q3;
    num[0][3] = Q1;         num[1][3] = Q3;          num[2][3] = VERTICAL;
    num[0][4] = Q2;         num[1][4] = Q4;          num[2][4] = VERTICAL;
    num[0][5] = Q1;         num[1][5] = HORIZONTAL;  num[2][5] = Q4;
    
    return num;
  }
  
  private int[][][] getSix()
  {
    int[][][] num = new int[3][6][];
    num[0][0] = Q2;         num[1][0] = HORIZONTAL;  num[2][0] = Q3;
    num[0][1] = VERTICAL;   num[1][1] = Q2;          num[2][1] = Q4;
    num[0][2] = VERTICAL;   num[1][2] = Q1;          num[2][2] = Q3;
    num[0][3] = VERTICAL;   num[1][3] = BOTH_DOWN;   num[2][3] = VERTICAL;
    num[0][4] = VERTICAL;   num[1][4] = BOTH_UP;     num[2][4] = VERTICAL;
    num[0][5] = Q1;         num[1][5] = HORIZONTAL;  num[2][5] = Q4;
    
    return num;
  }
  
  private int[][][] getSeven()
  {
    int[][][] num = new int[3][6][];
    num[0][0] = Q2;          num[1][0] = HORIZONTAL;  num[2][0] = Q3;
    num[0][1] = Q1;          num[1][1] = Q3;          num[2][1] = VERTICAL;
    num[0][2] = NOT_SPL;   num[1][2] = VERTICAL;    num[2][2] = VERTICAL;
    num[0][3] = NOT_SPL;   num[1][3] = VERTICAL;    num[2][3] = VERTICAL;
    num[0][4] = NOT_SPL;   num[1][4] = VERTICAL;    num[2][4] = VERTICAL;
    num[0][5] = NOT_SPL;   num[1][5] = Q1;          num[2][5] = Q4;
    
    return num;
  }
  
  private int[][][] getEight()
  {
    int[][][] zero = new int[3][6][];
    zero[0][0] = Q2;         zero[1][0] = HORIZONTAL;          zero[2][0] = Q3;
    zero[0][1] = VERTICAL;   zero[1][1] = BOTH_DOWN;           zero[2][1] = VERTICAL;
    zero[0][2] = VERTICAL;   zero[1][2] = BOTH_UP;             zero[2][2] = VERTICAL;
    zero[0][3] = VERTICAL;   zero[1][3] = BOTH_DOWN;           zero[2][3] = VERTICAL;
    zero[0][4] = VERTICAL;   zero[1][4] = BOTH_UP;             zero[2][4] = VERTICAL;
    zero[0][5] = Q1;         zero[1][5] = HORIZONTAL;          zero[2][5] = Q4;
    
    return zero;
  }
  
  private int[][][] getNine()
  {
    int[][][] num = new int[3][6][];
    num[0][0] = Q2;       num[1][0] = HORIZONTAL;  num[2][0] = Q3;
    num[0][1] = VERTICAL; num[1][1] = BOTH_DOWN;   num[2][1] = VERTICAL;
    num[0][2] = VERTICAL; num[1][2] = BOTH_UP;     num[2][2] = VERTICAL;
    num[0][3] = Q1;       num[1][3] = Q3;          num[2][3] = VERTICAL;
    num[0][4] = Q2;       num[1][4] = Q4;          num[2][4] = VERTICAL;
    num[0][5] = Q1;       num[1][5] = HORIZONTAL;  num[2][5] = Q4;
    
    return num;
  }
}
