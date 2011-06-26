
class YearBubble {
  float x;
  float y;
  float w;
  float h;
  float r,g,b;
  float[3] ocolor;
  float[3] tcolor;
  Tween t;

  boolean active;
  
  public YearBubble(float x, float y, float w, float h, float[3] orig_color, float[3] target_color) {
    //console.log(x + ' ' + y);
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    //this.blueLevel = blueLevel;
    //this.blueLevelTarget = blueLevelTarget;
    this.ocolor = orig_color;
    this.tcolor = target_color;
    this.r = orig_color[0];
    this.g = orig_color[1];
    this.b = orig_color[2];
    this.active = false;



    bto = new Tween(this, "b", Tween.strongEaseInOut, tcolor[2], ocolor[2], .5);
    btt = new Tween(this, "b", Tween.strongEaseInOut, ocolor[2], tcolor[2], .5);
    //t.start();
  }
  
  public void update() {
    bto.tick();
    btt.tick();
  }
  
  public void draw() {    
    fill(r, g, b);
    noStroke();
    ellipse(x, y, w, h);
  }
  
  public void restart() {
    //t.start();
  }

  public void inside(x, y)
  {
    if( x > this.x - this.w / 2 && 
        x < this.x + this.w / 2 && 
        y > this.y - this.h / 2 && 
        y < this.y + this.h / 2)
    {
      if(!active)
      {
        this.r = tcolor[0];
        this.g = tcolor[1];
        btt.start();
        active = true;
      }
    }
    else
    {
      if(active)
      {
        this.r = ocolor[0];
        this.g = ocolor[1];
        bto.start();
        active = false;
      }
    }
  }
}

class YearAxis {
  float x;
  float y;
  int w;
  int h;
  
  public YearAxis(float x, float y, float w, float h)
  {
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    //console.log(x + ' : ' + y + ' : ' + w + ' : ' + h);

    int spacing = 125;
    float min = x - spacing/3.;
    float ybw = 100;
    float ybh = 40;
    float[3] ocolor = {200, 100, 200};
    float[3] tcolor = {100, 200, 50};
    for(int i = 0; i < yearbubbles.length; i++)
    {
      yearbubbles[i] = new YearBubble(min + (i+1) * spacing, y, ybw, ybh, ocolor, tcolor);
    }
 

  }

  public void update()
  {
    for(int i = 0; i < yearbubbles.length; i++)
    {
      yearbubbles[i].update();
      yearbubbles[i].draw();
    } 
  }

  public void restart()
  {
    for(int i = 0; i < yearbubbles.length; i++)
    {
      yearbubbles[i].restart();
    } 
  }

  public void inside(int x, int y)
  {
    //check for mouse in one of the year boxes
    for(int i = 0; i < yearbubbles.length; i++)
    {
      yearbubbles[i].inside(x, y);
    } 
  }

}
 

