/**
@author barbara Almedia
@edited by ranaaditya
*/

int imageSerial = 0;

final int nbWeeds = 60;
SeaWeed[] weeds;
PVector rootNoise = new PVector(random(123456), random(123456));
int mode = 1;
float radius = 220;
Boolean noiseOn = true;
PVector center;

void setup()
{
  size(600, 450, P2D);
  center = new PVector(width/2, height/2);
  strokeWeight(1);
  weeds = new SeaWeed[nbWeeds];
  for (int i = 0; i < nbWeeds; i++)
  {
    weeds[i] = new SeaWeed(i*TWO_PI/nbWeeds, 3*radius);
  }
}

void draw()
{
  //background(50);
  noStroke();
  fill(20, 10, 20);//, 50);
  rect(0, 0, width, height);
  rootNoise.add(new PVector(.01, .01));
  strokeWeight(1);
  for (int i = 0; i < nbWeeds; i++)
  {
    weeds[i].update();
  }
  stroke(120, 0, 0, 220);
  strokeWeight(2);
  noFill();
  ellipse(center.x, center.y, 2*radius, 2*radius);
}

void keyPressed()
{
  if(key == 'n')
  {
    noiseOn = !noiseOn;
  }else
  {
  mode = (mode + 1) % 2;
  }
  
  if(mousePressed){
    saveFrame("Dream"+imageSerial+".jpg");
    imageSerial++;
  }
}


class MyColor
{
  float R, G, B, Rspeed, Gspeed, Bspeed;
  final static float minSpeed = .6;
  final static float maxSpeed = 1.8;
  final static float minR = 200;
  final static float maxR = 255;
  final static float minG = 20;
  final static float maxG = 120;
  final static float minB = 100;
  final static float maxB = 140;
  
  MyColor()
  {
    init();
  }
  
  public void init()
  {
    R = random(minR, maxR);
    G = random(minG, maxG);
    B = random(minB, maxB);
    Rspeed = (random(1) > .5 ? 1 : -1) * random(minSpeed, maxSpeed);
    Gspeed = (random(1) > .5 ? 1 : -1) * random(minSpeed, maxSpeed);
    Bspeed = (random(1) > .5 ? 1 : -1) * random(minSpeed, maxSpeed);
  }
  
  public void update()
  {
    Rspeed = ((R += Rspeed) > maxR || (R < minR)) ? -Rspeed : Rspeed;
    Gspeed = ((G += Gspeed) > maxG || (G < minG)) ? -Gspeed : Gspeed;
    Bspeed = ((B += Bspeed) > maxB || (B < minB)) ? -Bspeed : Bspeed;
  }
  
  public color getColor()
  {
    return color(R, G, B);
  }
}
class SeaWeed
{
  final static float DIST_MAX = 5.5;//length of each segment
  final static float maxWidth = 50;//max width of the base line
  final static float minWidth = 11;//min width of the base line
  final static float FLOTATION = -3.5;//flotation constant
  float mouseDist;//mouse interaction distance
  int nbSegments;
  PVector[] pos;//position of each segment
  color[] cols;//colors array, one per segment
  float[] rad;
  MyColor myCol = new MyColor();
  float x, y;//origin of the weed
  float cosi, sinu;

  SeaWeed(float p_rad, float p_length)
  {
    nbSegments = (int)(p_length/DIST_MAX);
    pos = new PVector[nbSegments];
    cols = new color[nbSegments];
    rad = new float[nbSegments];
    cosi = cos(p_rad);
    sinu = sin(p_rad);
    x = width/2 + radius*cosi;
    y = height/2 + radius*sinu;
    mouseDist = 40;
    pos[0] = new PVector(x, y);
    for (int i = 1; i < nbSegments; i++)
    {
      pos[i] = new PVector(pos[i-1].x - DIST_MAX*cosi, pos[i-1].y - DIST_MAX*sinu);
      cols[i] = myCol.getColor();
      rad[i] = 3;
    }
  }

  void update()
  {
    PVector mouse = new PVector(mouseX, mouseY);

    pos[0] = new PVector(x, y);
    for (int i = 1; i < nbSegments; i++)
    {
      float n = noise(rootNoise.x + .002 * pos[i].x, rootNoise.y + .002 * pos[i].y);
      float noiseForce = (.5 - n) * 7;
      if(noiseOn)
      {
        pos[i].x += noiseForce;
        pos[i].y += noiseForce;
      }
      PVector pv = new PVector(cosi, sinu);
      pv.mult(map(i, 1, nbSegments, FLOTATION, .6*FLOTATION));
      pos[i].add(pv);

      //mouse interaction
      //if(pmouseX != mouseX || pmouseY != mouseY)
      {
        float d = PVector.dist(mouse, pos[i]);
        if (d < mouseDist)// && pmouseX != mouseX && abs(pmouseX - mouseX) < 12)
        {
          PVector tmpPV = mouse.get();       
          tmpPV.sub(pos[i]);
          tmpPV.normalize();
          tmpPV.mult(mouseDist);
          tmpPV = PVector.sub(mouse, tmpPV);
          pos[i] = tmpPV.get();
        }
      }

      PVector tmp = PVector.sub(pos[i-1], pos[i]);
      tmp.normalize();
      tmp.mult(DIST_MAX);
      pos[i] = PVector.sub(pos[i-1], tmp);
      
      //keep the points inside the circle
      if(PVector.dist(center, pos[i]) > radius)
      {
        PVector tmpPV = pos[i].get();
        tmpPV.sub(center);
        tmpPV.normalize();
        tmpPV.mult(radius);
        tmpPV.add(center);
        pos[i] = tmpPV.get();
      }
    }

    updateColors();

    if (mode == 0)
    {
      stroke(0, 100);
    }     
    beginShape();
    noFill(); 
    for (int i = 0; i < nbSegments; i++)
    { 
      float r = rad[i];
      if (mode == 1)
      {
        stroke(cols[i]);
        vertex(pos[i].x, pos[i].y);
        //line(pos[i].x, pos[i].y, pos[i+1].x, pos[i+1].y);
      } else
      {
        fill(cols[i]);
        noStroke();
        ellipse(pos[i].x, pos[i].y, 2, 2);
      }
    }
    endShape();
  }

  void updateColors()
  {
    myCol.update();
    cols[0] = myCol.getColor();
    for (int i = nbSegments-1; i > 0; i--)
    {
      cols[i] = cols[i-1];
    }
  }
}
