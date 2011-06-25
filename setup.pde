//screen min and max
float[] smin = {0, 0};
float[] smax = {600, 600};

HashMap positions = new HashMap();
HashMap colors = new HashMap();
HashMap frequency = new HashMap();
HashMap percent = new HashMap();

year = 0;

void setup() 
{
	size(smax[0], smax[1]);
    //don't loop for now
    //noLoop();
    frameRate(30);
    
    testfunc();

    float[2] neglect = {200, 200};
    float[2] physical = {400, 200};
    float[2] sexual = {300, 300};
    float[2] emotional = {200, 400};
    float[2] medical = {400, 400};
    positions.put('neglect', neglect);
    positions.put('physical', physical);
    positions.put('sexual', sexual);
    positions.put('emotional', emotional);
    positions.put('medical', medical);

    colors.put('neglect', {128, 128, 128});
    colors.put('physical', {0, 200, 0});
    colors.put('sexual', {200, 0, 0});
    colors.put('emotional', {0, 0, 200});
    colors.put('medical', {200, 0, 200});

    //                        2000, 2001, 2002, 2003, 2004, 2005

    float[12] Neglect = {338770,49.1,517118,59.8,518014,57.3,525131,58.53,550178,61.59,518519,59.13,564765,62.79};
    float[12] Physical = {186801,27,167713,19.4,168510,18.6,167168,18.63,164689,18.44,151108,17.23,149319,16.6};
    float[12] Sexual = {119506,17.3,87770,10.2,86857,9.6,88688,9.89,87078,9.75,83221,9.49,83810,9.32};
    float[12] Emotional = {45621,6.6,66965,7.7,61776,6.8,58029,6.47,57391,6.42,61157,6.97,63497,7.06};
    float[12] Medical = { -1, -1,25498,3,17670,2,18128,2.02,17945,2.01,17211,1.96,17637,1.96};
    float[12] Other = {67272,9.7,146184,16.9,178327,19.7,170847,19.04,134964,15.11,162498,18.53,138367,15.38};

    float[6] freq = new float[6];
    float[6] perc = new float[6];
    for(int i = 0; i < 6; i++)
    {
        freq[i] = Neglect[2*i];
        perc[i] = Neglect[2*i+1];
    }
    frequency.put('neglect', freq);
    percent.put('neglect', perc);
    
    float[6] freq = new float[6];
    float[6] perc = new float[6];
    for(int i = 0; i < 6; i++)
    {
        freq[i] = Physical[2*i];
        perc[i] = Physical[2*i+1];
    }
    frequency.put('physical', freq);
    percent.put('physical', perc);
    
    float[6] freq = new float[6];
    float[6] perc = new float[6];
    for(int i = 0; i < 6; i++)
    {
        freq[i] = Sexual[2*i];
        perc[i] = Sexual[2*i+1];
    }
    frequency.put('sexual', freq);
    percent.put('sexual', perc);

    float[6] freq = new float[6];
    float[6] perc = new float[6];
    for(int i = 0; i < 6; i++)
    {
        freq[i] = Emotional[2*i];
        perc[i] = Emotional[2*i+1];
    }
    frequency.put('emotional', freq);
    percent.put('emotional', perc);

    float[6] freq = new float[6];
    float[6] perc = new float[6];
    for(int i = 0; i < 6; i++)
    {
        freq[i] = Medical[2*i];
        perc[i] = Medical[2*i+1];
    }
    frequency.put('medical', freq);
    percent.put('medical', perc);

    float[6] freq = new float[6];
    float[6] perc = new float[6];
    for(int i = 0; i < 6; i++)
    {
        freq[i] = Other[2*i];
        perc[i] = Other[2*i+1];
    }
    frequency.put('other', freq);
    percent.put('other', perc);

}

void draw() 
{

	background(255);
	// Drawing attributes for the ellipses.
	smooth( );

    //year++;
    if(year == 6) { year = 0 };

	//noStroke( );
    Iterator i = positions.entrySet().iterator();
    while(i.hasNext())
    {
        Map.Entry me = (Map.Entry)i.next();
        pos = me.getValue();
        col = colors.get(me.getKey());
	    fill(col[0], col[1], col[2]);

        scale = percent.get(me.getKey());
        float radius = 60 * scale[year] / 100.0;
        drawCircle(pos[0], pos[1], radius, radius);

        //put text
        text(me.getKey(), pos[0] + radius, pos[1]);
    }
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

