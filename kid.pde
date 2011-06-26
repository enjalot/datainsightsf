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

  int M = 0; //number of neighbors
  int MS = 0;
  float[2] alignment = {0,0};
  float[2] separation = {0,0};
  float[2] cohesion = {0,0};
  float[2] spacing = {0,0};
  float sscale, cscale, ascale;
  float anchor_scale;
  boolean active = false;

  public Kid(pos, type, anchor, size, radius)
  {
    this.pos = pos;
    this.type = type;
    this.anchor = anchor;
    this.size = size;
    this.radius = radius;
    //console.log(type);
    
    sscale = 50;
    cscale = .001;//.0001;
    ascale = .01;//.3;
    anchor_scale = -.01;
    space_scale = 10;
    mouse = 50;
    float alpha = 100;
    col = {200, 200, 200, 100};
    if(type == 'neglect')
    {
      //col = {123, 211, 247, 150};
      col[3] = 100;
      tribal = .01;
      other = 10;
      mouse = -1;
      space_scale = 25;
    }
    else if(type == 'physical')
    {
      //col = {111, 44, 145, 220};
      col[3] = 150;
      tribal = .001;
      other = 10;
      mouse = 50;
    }
    else if(type == 'sexual')
    {
      //col = {237, 28, 36, 150};
      col[3] = 100;
      tribal = .001;
      other = -.001;
      mouse = 20;
    }
    else if(type == 'emotional')
    {
      //col = {205, 129, 154, 220};
      col[3] = 150;
      tribal = .001;
      other = -.001;
      sscale = 20;
      mouse = 1;
      sscale = 100;
      space_scale = 20;
    }
    else if(type == 'medical')
    {
      //col = {255, 221, 0, 150};
      col[3] = 100;
      tribal = .001;
      other = -.001;
      mouse = .1;
    }
    else if(type == 'unkown')
    {
      //col = {219, 124, 27, 220};
      col[3] = 150;
      tribal = .001;
      other = -.001;
      mouse = .1;
    }
  }

  public void draw()
  {
    smooth();
    noStroke();
    stroke(col[0], col[1], col[2], 205);
    fill(col[0], col[1], col[2], col[3]);
    ellipse(pos[0], pos[1], size, size);
  }

  public void inside(int x, int y)
  {
    //check if mouse inside
    float[2] r = {pos[0] - x, pos[1] - y};
    float dist = sqrt(r[0]*r[0] + r[1]*r[1]);
    float scale = dist / radius;
    //avoid / goal behavior for mouse goes here
    if(dist < .75 * radius)
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
    float[2] r = {kidj.pos[0] - pos[0], kidj.pos[1] - pos[1]};
    float dist = sqrt(r[0]*r[0] + r[1]*r[1]);
    //normalize r
    r[0] /= dist;
    r[1] /= dist;
    float scale = dist / radius;

    if(dist < radius * 2)
    {
      float[2] rs = {pos[0] - kidj.pos[0], pos[1] - kidj.pos[1]};
      separation[0] += rs[0] / dist;
      separation[1] += rs[1] / dist;

      if(dist < radius)
      {
        /*
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
        */

        //flocking rules
        //separation
        alignment[0] += velocity[0];
        alignment[1] += velocity[1];
        cohesion[0] += kidj.pos[0];
        cohesion[1] += kidj.pos[1];

        if(dist < size * 1.2)
        {
          spacing[0] += rs[0] * scale * space_scale;
          spacing[1] += rs[1] * scale * space_scale;
        }
        /*
        console.log("kidi.pos "+pos);
        console.log("kidj.pos "+kidj.pos);
        console.log("dist "+dist);

        console.log("cohesion: " + cohesion);
        console.log("separation: " + separation);
        */

        M++;
      }
      MS++;
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
    spacing[0] = 0;
    spacing[1] = 1;
    M = 0;

  }

  public void integrate()
  {
    if( M > 0 )
    {
      force[0] /= M;
      force[1] /= M;
    }
    //anchor
    float[2] r = {pos[0] - anchor[0], pos[1] - anchor[1]};
    //console.log(r);
    //float dist = distance(pos[0], pos[1], anchor[0], anchor[1]);
    force[0] += r[0] * anchor_scale;// * (2 - dist/1000.);
    force[1] += r[1] * anchor_scale;// * (2 - dist/1000.);
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
      velocity[0] += ascale * (alignment[0] / M - velocity[0]);
      velocity[1] += ascale * (alignment[1] / M - velocity[1]);
      //add in the flocking rules
      velocity[0] += sscale * (separation[0] / MS);
      velocity[1] += sscale * (separation[1] / MS);
      //console.log("velocity: " + velocity);
      //cohesiont
      velocity[0] += cscale * (cohesion[0] / M - pos[0]);
      velocity[1] += cscale * (cohesion[1] / M - pos[1]);

      velocity[0] += spacing[0] / M;
      velocity[1] += spacing[1] / M;


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
    if (pos[0] < bbmin[0]) { pos[0] = bbmin[0]; velocity[0] = -velocity[0];}
    if (pos[1] < bbmin[1]) { pos[1] = bbmin[1]; velocity[1] = -velocity[1];}
    if (pos[0] > bbmax[0]) { pos[0] = bbmax[0]; velocity[0] = -velocity[0];}
    if (pos[1] > bbmax[1]) { pos[1] = bbmax[1]; velocity[1] = -velocity[1];}
    //console.log(velocity);
    
  }


}

void initKids(int N, String itype)
{
  //generate kids using percentage by type
  console.log("init kids");
  int nkids = 0;
    //console.log(me.getKey());
    perci = percent.get(itype);
    perc = perci[year] / 100.;
    //console.log('percent: ' + perc);
    int n = (int)(perc * N);
    //n = 2; 
    //console.log('n: ' + n);
    //float[2] anchor = anchors.get(itype);
    float[2] anchor = main_anchor;
    float rmax = 50;
    float rx, ry;
    for(int k = 0; k < n; k++)
    {
      //console.log(k);
      rx = random(-rmax,rmax);
      ry = random(-rmax,rmax); 
      float[2] pos = { anchor[0] + rx, anchor[1] + ry };
      Kid kid = new Kid(pos, itype, anchor, 20, 80);
      kids.put(nkids, kid);
      nkids++;
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

/*
void initKids(int N, String itype)
{
  //generate kids using percentage by type
  console.log("init kids");
  Iterator i = percent.entrySet().iterator();
  int ii = 0;
  int nkids = 0;
  while(i.hasNext())
  {
      Map.Entry me = (Map.Entry)i.next();
      //console.log(me.getKey());
      perc = me.getValue()[year] / 100.;
      //console.log('percent: ' + perc);
      int n = (int)(perc * N);
      ///
      if(me.getKey()=='neglect')
      {
        console.log(me.getKey());
        n = 2; 
        ///
      //console.log('n: ' + n);
      float[2] anchor = anchors.get(me.getKey());
      float rmax = 50;
      float rx, ry;
      for(int k = 0; k < n; k++)
      {
        console.log(k);
        rx = random(-rmax,rmax);
        ry = random(-rmax,rmax); 
        float[2] pos = { anchor[0] + rx, anchor[1] + ry };
        Kid kid = new Kid(pos, me.getKey(), anchor, 20, 80);
        kids.put(nkids, kid);
        nkids++;
      }
      }
      //break;
      ii++;
  }
  console.log("nkids: " + nkids);
}
*/

