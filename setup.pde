//screen min and max
float[] smin = {0, 0};
float[] smax = {800, 480};
//background image
PImage bg_image;

float[] bbsize = {387, 355};
float[] bbmin = {390, 60};
float[] bbmax = {bbmin[0] + bbsize[0], bbmin[0] + bbsize[1]};


//HScrollbar hsyear, hstype;


//YearAxis ya;
CatAxis ca;
Bubble[6] yearbubbles = new Bubble[6];
Bubble[6] catbubbles = new Bubble[6];
float[6] years;

String[6] categories = new String[6];
HashMap anchors = new HashMap();
HashMap positions = new HashMap();
HashMap colors = new HashMap();
HashMap frequency = new HashMap();
HashMap percent = new HashMap();
HashMap symptoms = new HashMap();
HashMap kids = new HashMap();

year = 2;
tpf = 0;      //time per frame
cycle = 0;    //keep track of where we are in an animation cycle

float[2] main_anchor = {bbmin[0] + bbsize[0]/2, bbmin[1] + bbsize[1]/2};

void setup() 
{
	  size(smax[0], smax[1]);
	  //size(smax[0], smax[1], OPENGL);
    //don't loop for now
    //noLoop();
    frameRate(30);
    console.log(PFont.list());

	  //bg_image = loadImage("bg.png");
    //hsyear = new HScrollbar(0, 20, width, 10, 6);
    //hstype = new HScrollbar(0, 20, width, 10, 6);
    //ya = new YearAxis(0, smax[1] - 50, smax[0], smax[1] - 50);
    ca = new CatAxis(233, bbmin[1] + 20, 100, bbmin[1] + 20);
    
    N = 100;
    /* 
    float[2] neglect = {200, 100};
    float[2] physical = {400, 100};
    float[2] sexual = {300, 200};
    float[2] emotional = {200, 300};
    float[2] medical = {400, 300};
    */
    float[2] neglect = {200, 100};
    float[2] physical = {600, 100};
    float[2] sexual = {100, 240};
    float[2] emotional = {700, 240};
    float[2] medical = {600, 380};
    float[2] unkown = {200, 380};
 
    positions.put('neglect', neglect);
    positions.put('physical', physical);
    positions.put('sexual', sexual);
    positions.put('emotional', emotional);
    positions.put('medical', medical);
    positions.put('unkown', unkown);

    anchors.put('neglect', neglect);
    anchors.put('physical', physical);
    anchors.put('sexual', sexual);
    anchors.put('emotional', emotional);
    anchors.put('medical', medical);
    anchors.put('unkown', unkown);



    colors.put('neglect', {128, 128, 128});
    colors.put('physical', {0, 200, 0});
    colors.put('sexual', {200, 0, 0});
    colors.put('emotional', {0, 0, 200});
    colors.put('medical', {200, 0, 200});
    colors.put('unkown', {0, 200, 200});

    initData();
    initKids(N, categories[0]);
}

void draw() 
{
    background(0, 0, 0, 255);
    colorMode(RGB,255,255,255,255);
    drawUI();
	  //image(bg_image, 0, 0); 
    //hsyear.update();
    //hsyear.display();
    //ya.update();
    ca.update();

    cycle++;
    if(cycle >= 50) {cycle = 0 };
    //year = (int)( cycle / 10);


    //drawByYear(0);
    kidloop(kids);
 
}

void updateKids(String itype)
{
  kids = new HashMap();
  initKids(N, itype);
}

void keyPressed()
{
  console.log(key);
  if(key == 'p')
  {
    updateKids('physical');
  }
  if(key == 'e')
  {
    updateKids('emotional');
  }
}



void drawByYear(int offset)
{
    smooth();
	  noStroke();
 
    Iterator i = positions.entrySet().iterator();
    while(i.hasNext())
    {
        Map.Entry me = (Map.Entry)i.next();
        pos = me.getValue();
        col = colors.get(me.getKey());
	      fill(col[0], col[1], col[2], 50);

        scale = percent.get(me.getKey());
        //float radius = 60 * scale[year] / 100.0;
        float radius = 20;
        drawCircle(pos[0] + offset, pos[1] + offset, radius, radius);

        //put text
	      fill(col[0], col[1], col[2], 250);
        text(me.getKey(), pos[0] + radius, pos[1]);
    }

    //draw Axis
    //yearAxis(0, smax[1] - 50, smax[0], smax[1] - 50); //put the axis at the bottom

}

void mousePressed() 
{
  //ya.restart();
  console.log(mouseX + " " + mouseY);
}

void mouseMoved()
{
  //ya.inside(mouseX, mouseY);
  ca.inside(mouseX, mouseY);
}

void drawCircle(float x, float y, float w, float h)
{
    ellipse(x, y, w, h);
}


float singraph(float sa) {
  sa = (sa - 0.5) * 1.0; //scale from -1 to 1
  sa = sin(sa*PI)/2 + 0.5;
  return sa;
}

void drawGraph()
{
    stroke(40);
    beginShape();
    for(int i=0; i<width; i++) {
    vertex(i, singraph((float)i/width)*height);
    }
    endShape();
}


