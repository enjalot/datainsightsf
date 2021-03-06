int spacing = 16;
float ybw = 10;
float ybh = 10;



void drawUI()
{
    fill(0, 0, 0, 255);
    stroke(200, 200, 200, 150);
    rect(bbmin[0], bbmin[1], bbsize[0], bbsize[1]);


    //year
    fill(200, 200, 200, 150);
    textFont(createFont("Arial Black",12));
    text(years[year], bbmax[0] - textWidth("" +years[year]), 54);



    fill(200, 200, 200, 150);
    stroke(200, 200, 200, 150);
    textFont(createFont("Arial Black",32));
    text("CATEGORY", 31, bbmin[1] + 24);


    fill(200, 200, 200, 255);
    textFont(createFont("Helvetica",24));
    String cat = categories[ca.active];
    //category name
    text(cat, 31, 144);

    //arrow
    stroke(255, 240, 240, 255);
    fill(255, 240, 240, 255);
    line(31, 155, bbmin[0] - 65, 155);
    

    fill(200, 200, 200, 100);
    //percent
    textFont(createFont("Arial Black",80));
    text((int)percent.get(cat)[year] + "%", 31, 240);

    //warning signs
    fill(200, 200, 200, 150);
    textFont(createFont("Helvetica",20));
    text("Signs", 31, 290);

    String signs[] = symptoms.get(cat);
    textLeading(19);
    textFont(createFont("Helvetica",14));
    for(int i= 0; i < signs.length; i++)
    {
      noStroke();
      fill(200, 200, 200, 150);
      ellipse(31, 316 + i * 20, 4, 4);
      fill(200, 200, 200, 220);
      text(signs[i], 41, 320 + i * 20);
    }

    //instructions
    text("Move the mouse within the bounding box to view the behavior", bbmin[0], bbmin[1] + bbsize[1] + 14);
    text("associated with the type of abuse", bbmin[0], bbmin[1] + bbsize[1] + 28);


}

class Bubble {
  float x;
  float y;
  float w;
  float h;
  float r,g,b,a;
  float[3] ocolor;
  float[3] tcolor;
  Tween bto; //alpha to original
  Tween btt;  //alpha to target
  Tween bt0, bt1;  //blink

  boolean active;
  boolean blink_mode = false;
  
  public Bubble(float x, float y, float w, float h, float[4] orig_color, float[4] target_color) {
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
    this.a = orig_color[3];
    this.active = false;


    bto = new Tween(this, "a", Tween.strongEaseInOut, tcolor[3], ocolor[3], .5);
    btt = new Tween(this, "a", Tween.strongEaseInOut, ocolor[3], tcolor[3], .5);
    //blinking tweens
    //bt0 = new Tween(this, "a", Tween.strongEaseInOut, ocolor[3], tcolor[3], 1);
    //bt1 = new Tween(this, "a", Tween.strongEaseInOut, tcolor[3], ocolor[3], 1);
    bt0 = new Tween(this, "a", Tween.regularEaseIn, ocolor[3], tcolor[3], 1);
    bt1 = new Tween(this, "a", Tween.regularEaseIn, tcolor[3], ocolor[3], 1);

    //t.start();
  }
  
  public void update() {
    bto.tick();
    btt.tick();
  }

  public void start_blink()
  {
    bt1.start();
  }
  public void blink()
  {
    bt0.tick();
    bt1.tick();
    if(!bt0.isPlaying() && blink_mode)
    {
      bt1.start();
      blink_mode = false;
    }
    if(!bt1.isPlaying() && !blink_mode)
    {
      bt0.start();
      blink_mode = true;
    }
  }
  
  public void draw() {    
    fill(r, g, b, a);
    noStroke();
    ellipse(x, y, w, h);
  }
  
  public void restart() {
    bto.start();
    //btt.start();
  }

  public boolean inside(x, y)
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
      return true;
    }
    else
    {
      if(active)
      {
        this.r = ocolor[0];
        this.g = ocolor[1];
        //bto.start();
        active = false;
      }
      return false;
    }
  }
}


class CatAxis {
  float x;
  float y;
  int w;
  int h;
  int active = 0; //id of the active category
  
  public CatAxis(float x, float y, float w, float h)
  {
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    //console.log(x + ' : ' + y + ' : ' + w + ' : ' + h);

    float min = x - spacing/3.;
    float[4] ocolor = {200, 200, 200, 100};
    float[4] tcolor = {200, 200, 200, 200};
    for(int i = 0; i < catbubbles.length; i++)
    {
      catbubbles[i] = new Bubble(min + (i+1) * spacing, y, ybw, ybh, ocolor, tcolor);
    }

 

  }

  public void update()
  {
    for(int i = 0; i < catbubbles.length; i++)
    {
      catbubbles[i].update();
      catbubbles[i].draw();
    } 
    catbubbles[active].blink();
  }

  public void restart()
  {
    for(int i = 0; i < catbubbles.length; i++)
    {
      catbubbles[i].restart();
    } 
  }

  public void inside(int x, int y)
  {
    //check for mouse in one of the year boxes
    boolean ins;
    for(int i = 0; i < catbubbles.length; i++)
    {
       ins = catbubbles[i].inside(x, y);
       if(ins && active != i)
       {
          catbubbles[active].restart();
          active = i;
          catbubbles[i].start_blink();
          updateKids(categories[active]);
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
    float[4] ocolor = {200, 100, 200, 200};
    float[4] tcolor = {100, 200, 50, 200};
    for(int i = 0; i < yearbubbles.length; i++)
    {
      yearbubbles[i] = new Bubble(min + (i+1) * spacing, y, ybw, ybh, ocolor, tcolor);
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
 

