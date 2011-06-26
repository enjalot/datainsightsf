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
  float [2] velocity = {0, 0};
  float [2] force = {0, 0};     //force is really just added to velocity
  float[4] col;                 //color
  String type;

  float size;     //size of kid
  float radius;   //neighbor search radius

  float[2] anchor; //home base gravitate towards
  float tribal; //cohesion with similar types
  float others; //goal or avoid behavior with other types
  float mouse; //avoid behavior with the mouse

  float M = 0; //number of neighbors
  float[2] alignment = {0,0};
  float[2] separation = {0,0};
  float[2] cohesion = {0,0};
  float sscale, cscale, ascale;
  boolean active = false;

  public Kid(pos, type, anchor, size, radius)
  {
    this.pos = pos;
    this.type = type;
    this.anchor = anchor;
    this.size = size;
    this.radius = radius;
    //console.log(type);
    
    sscale = .3;
    cscale = .03;
    ascale = .03;
    mouse = 1;
    float alpha = 100;
    if(type == 'neglect')
    {
      col = {100, 0, 0, alpha};
      tribal = .001;
      other = .001;
    }
    else if(type == 'physical')
    {
      col = {0, 100, 0, alpha};
      tribal = .001;
      other = -.001;
    }
    else if(type == 'sexual')
    {
      col = {0, 0, 100, alpha};
      tribal = .001;
      other = -.001;
    }
    else if(type == 'emotional')
    {
      col = {100, 0, 100, alpha};
      tribal = .001;
      other = -.001;
    }
    else if(type == 'medical')
    {
      col = {100, 100, 0, alpha};
      tribal = .001;
      other = -.001;
    }
    else if(type == 'unkown')
    {
      col = {0, 100, 100, alpha};
      tribal = .001;
      other = -.001;
    }
  }

  public void draw()
  {
    stroke(col[0], col[1], col[2], 255);
    fill(col[0], col[1], col[2], col[4]);
    ellipse(pos[0], pos[1], size, size);
  }

  public void inside(int x, int y)
  {
    //check if mouse inside
    float[2] r = {pos[0] - x, pos[1] - y};
    float dist = sqrt(r[0]*r[0] + r[1]*r[1]);
    float scale = dist / radius;
    //avoid / goal behavior for mouse goes here
    if(dist < radius)
    {
      //do inside code
      force[0] += r[0] * mouse * scale;
      force[1] += r[1] * mouse * scale;

    }
    else
    {
      //mouse left
    }
    //mouse activation of a kid goes here
    if(dist < size)
    {
    }
    else
    {
    }
    
  }

  public void nns(Kid kidj)
  {
    //Nearest Neighbor Search
    //float dist = distance(pos[0], pos[1], kidj.pos[0], kidj.pos[1]);
    float[2] r = {pos[0] - kidj.pos[0], pos[1] - kidj.pos[1]};
    float dist = sqrt(r[0]*r[0] + r[1]*r[1]);
    /*
    console.log("kidi.pos "+pos);
    console.log("kidj.pos "+kidj.pos);
    console.log("dist: " + dist);
    */
    float scale = dist / radius;
    if(dist < radius)
    {
      if(type == kidj.type)
      {
        //tribal behavior
        force[0] += r[0] * tribal * scale;
        force[1] += r[1] * tribal * scale;
      }
      else
      {
        //others
        force[0] += r[0] * others * scale;
        force[1] += r[1] * others * scale;

      }

      //flocking rules
      //separation
      separation[0] += sscale * r[0] / dist;
      separation[1] += sscale * r[1] / dist;
      alignment[0] += ascale * velocity[0];
      alignment[1] += ascale * velocity[1];
      cohesion[0] += -cscale * r[0] / dist;
      cohesion[1] += -cscale * r[1] / dist;


      M++;
    }

  }

  public void prep()
  {
    force[0] = 0;
    force[1] = 0;
    separation[0] = 0;
    separation[1] = 0;
    cohesion[0] = 0;
    cohesion[1] = 0;
    alignment[0] = 0;
    alignment[1] = 0;
    M = 0;

  }

  public void integrate()
  {
    //anchor
    float[2] r = {pos[0] - anchor[0], pos[1] - anchor[1]};
    //console.log(r);
    //float dist = distance(pos[0], pos[1], anchor[0], anchor[1]);
    float scale = -.01;
    force[0] += r[0] * scale;// * dist / width;
    force[1] += r[1] * scale;// * dist / width;
    //goal behavior
    //force[0] += r[0] * velocity[0] - velocity[0];//scale * dist / width;
    //force[1] += r[1] * velocity[0] - velocity[1];//scale * dist / width;



    //random

    //add in the various contributions to the behavior
    velocity[0] += force[0];
    velocity[1] += force[1];

    /*
    console.log("M: " + M);
    console.log("alignment: " + alignment);
    console.log("separation: " + separation);
    */
    if ( M > 0 )
    {
      velocity[0] += alignment[0] / M;// - velocity[0];
      velocity[1] += alignment[1] / M;// - velocity[1];
      //add in the flocking rules
      velocity[0] += separation[0] / M;
      velocity[1] += separation[1] / M;
      //console.log("velocity: " + velocity);
      //cohesiont
      velocity[0] += cohesion[0] / M;// - pos[0];
      velocity[1] += cohesion[1] / M;// - pos[1];
    }



    //cap velocity
    float maxvel = 16;
    float minvel = -16;
    if(velocity[0] > maxvel) { velocity[0] = maxvel; }
    if(velocity[1] > maxvel) { velocity[1] = maxvel; }
    if(velocity[0] < minvel) { velocity[0] = minvel; }
    if(velocity[1] < minvel) { velocity[1] = minvel; }

    //integrate
    pos[0] = pos[0] + velocity[0]*dt;
    pos[1] = pos[1] + velocity[1]*dt;
    if (pos[0] < smin[0]) { pos[0] = smin[0];}
    if (pos[1] < smin[1]) { pos[1] = smin[1];}
    if (pos[0] > smax[0]) { pos[0] = smax[0];}
    if (pos[1] > smax[1]) { pos[1] = smax[1];}
    //console.log(velocity);
    
  }


}

void initKids(int N)
{
  //generate kids using percentage by type
  console.log("init kids");
  Iterator i = percent.entrySet().iterator();
  int ii = 0;
  int nkids = 0;
  while(i.hasNext())
  {
      Map.Entry me = (Map.Entry)i.next();
      String type = me.getKey();
      //console.log(me.getKey());
      perc = me.getValue()[year] / 100.;
      //console.log('percent: ' + perc);
      int n = (int)(perc * N);
      //n = 2;
      //console.log('n: ' + n);
      float[2] anchor = anchors.get(type);
      float rmax = 80;
      float rx, ry;
      for(int k = 0; k < n; k++)
      {
        rx = random(-rmax,rmax);
        ry = random(-rmax,rmax); 
        float[2] pos = { anchor[0] + rx, anchor[1] + ry };
        Kid kid = new Kid(pos, type, anchor, 20, 80);
        kids.put(nkids, kid);
        nkids++;
      }
      //break;
      ii++;
  }
  console.log("nkids: " + nkids);
}

void kidloop(ArrayList kids)
{
  //iterate over each kid and do neighborsearches
  //Iterator i = kids.entrySet().iterator();

  //int i = 0;
  //int j = 0;
  //while(i.hasNext())
  for(int i = 0; i < kids.size(); i++)
  {
      //Map.Entry me = (Map.Entry)i.next();
      //kidi = me.getValue();
      kidi = kids.get(i);
      kidi.prep();
      kidi.inside(mouseX, mouseY);

      //Iterator j = kids2.entrySet().iterator();
      //j = 0;
      //while(j.hasNext())
      for(jnt j = 0; j < kids.size(); j++)
      {
          if(i == j) { continue; }
          //Map.Entry mej = (Map.Entry)j.next();
          //kidj = mej.getValue();
          kidj = kids.get(j);
          //console.log("KIDJ " + jj + " " + kidj.pos);
          kidi.nns(kidj);
          //jj++;
      }
      //ii++;

      kidi.integrate();
      kidi.draw();
  }


}
