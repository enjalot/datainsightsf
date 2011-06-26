
void initData()
{

    /*
    years.put('2000', 2000);
    years.put('2001', 2001);
    years.put('2002', 2002);
    years.put('2003', 2003);
    years.put('2004', 2004);
    years.put('2005', 2005);
    */
    years = { 2000, 2001, 2002, 2003, 2004, 2005 };
    categories = {'medical', 'emotional', 'sexual', 'physical', 'neglect', 'unkown'};

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
    frequency.put('unkown', freq);
    percent.put('unkown', perc);



}
