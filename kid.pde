dt = .1;

float distance(float x0, y0, x1, y1)
{
  float dx = x0 - x1;
  float dy = y0 - y1;
  return sqrt(dx*dx + dy*dy);
}

class Kid
{
  float[2] pos;
  float [2] velocity;
  float[4] color;
  String type;

  float size;
  float radius;

  float anchor;
  float tribal; //cohesion with similar types
  float others; //goal or avoid behavior with other types
  float mouse; //avoid behavior with the mouse

  boolean active = false;

  public Kid()
  {

  }

  public void draw()
  {
    fill(color[0], color[1], color[2], color[4]);
    stroke(color[0], color[1], color[2], 255);
    ellipse(pos[0], pos[1], size, size);
  }

  public void inside(int x, int y)
  {
    //check if mouse inside
    float dist = distance(pos[0], pos[1], x, y);
    if(dist < radius)
    {
      //do inside code
    }
    else
    {
      //mouse left
    }
    //avoid / goal behavior for mouse goes here
  }

  public void neighbor_search(Kid kidj)
  {
    float dist = distance(pos[0], pos[1], kidj.pos[0], kidj.pos[1]);
    if(dist < radius)
    {
      if(type == kidj.type)
      {
        //tribal behavior
      }
      else
      {
        //others
      }
      //random

    }
  }

}


void kidloop(HashMap kids)
{
  //iterate over each kid and do neighborsearches
  Iterator i = kids.entrySet().iterator();
  while(i.hasNext())
  {
      Map.Entry me = (Map.Entry)i.next();
      kidi = me.getValue();
      Iterator j = kids.entrySet().iterator();
      while(j.hasNext())
      {
          Map.Entry mej = (Map.Entry)j.next();
          kidj = mej.getValue();
      }
  }

}
