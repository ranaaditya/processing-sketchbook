import processing.pdf.*;
import toxi.math.conversion.*;
import toxi.geom.*;
import toxi.math.*;
import toxi.geom.mesh2d.*;
//import toxi.geom.nurbs.*;
import toxi.util.datatypes.*;
import toxi.util.events.*;
import toxi.geom.mesh.subdiv.*;
import toxi.math.waves.*;
import toxi.geom.mesh.*;
import toxi.util.*;
import toxi.math.noise.*;
import toxi.processing.*;

//Image for portrait
PImage img;

// ranges for x/y positions of points
FloatRange xpos, ypos;

// helper class for rendering
ToxiclibsSupport gfx;

// empty voronoi mesh container
Voronoi voronoi = new Voronoi();

// optional polygon clipper
PolygonClipper2D clip;

// switches
boolean doShowPoints = false;
boolean doShowDelaunay;
boolean doShowHelp=false;
boolean doClip;
boolean doSave;

void setup() {
  //image must be same size as sketch
  size(400, 300);
  noLoop();
  smooth();
   PGraphics pdf=beginRecord(PDF, "rune.pdf");
  //make 400x300, grayscale before loading
  img = loadImage("rune.jpg");
  // focus x positions around horizontal center (w/ 33% standard deviation)
  xpos=new BiasedFloatRange(0, width, width/2, 0.333f);
  // focus y positions around bottom (w/ 50% standard deviation)
  ypos=new BiasedFloatRange(0, height, height, 0.5f);
  // setup clipper with centered rectangle
  clip=new SutherlandHodgemanClipper(new Rect(width*0.125, height*0.125, width*0.75, height*0.75));
  gfx = new ToxiclibsSupport(this);
  textFont(createFont("SansSerif", 10));
 
  
//  saveFrame("voronoi-" + DateUtils.timeStamp() + ".dxm");

 
  pixelArray();
  //comment out the following line to see the sketch
  gfx.setGraphics(pdf);
  veronoiFunctions();  
  endRecord();
  exit();
}



void keyPressed() {
  switch(key) {
  case ' ':
    doSave = true;  
    break;
  case 't':
    doShowDelaunay = !doShowDelaunay;
    break;
  case 'x':
    voronoi = new Voronoi();
    break;
  case 'p':
    doShowPoints = !doShowPoints;
    break;
  case 'c':
    doClip=!doClip;
    break;
  case 'h':
    doShowHelp=!doShowHelp;
    break;
  case 'r':
    for (int i = 0; i < 10; i++) {
      voronoi.addPoint(new Vec2D(xpos.pickRandom(), ypos.pickRandom()));
    }
    break;
  }
}



void addPoint(int x, int y){
        
         voronoi.addPoint(new Vec2D(x,y)); 
  
}


 
  


void veronoiFunctions(){
 // draw all voronoi polygons, clip them if needed...
  for (Polygon2D poly : voronoi.getRegions()) {
    if (doClip) {
      gfx.polygon2D(clip.clipPolygon(poly));
    } 
    else {
      gfx.polygon2D(poly);
    }
  }
  // draw delaunay triangulation
  if (doShowDelaunay) {
    stroke(0, 0, 255, 50);
    beginShape(TRIANGLES);
    for (Triangle2D t : voronoi.getTriangles()) {
      gfx.triangle(t, false);
    }
    endShape();
  }
  // draw original points added to voronoi
  if (doShowPoints) {
    fill(255, 0, 255);
    noStroke();
    for (Vec2D c : voronoi.getSites()) {
      ellipse(c.x, c.y, 5, 5);
    }
  }
 
  if (doShowHelp) {
    fill(255, 0, 0);
    text("p: toggle points", 20, 20);
    text("t: toggle triangles", 20, 40);
    text("x: clear all", 20, 60);
    text("r: add random", 20, 80);
    text("c: toggle clipping", 20, 100);
    text("h: toggle help display", 20, 120);
    text("space: save frame", 20, 140);
  } 
  
}

void pixelArray(){
 loadPixels();

  // We must also call loadPixels() on the PImage since we are going to read its pixels.
  img.loadPixels();
  for (int y = 0; y < height; y++ ) {
    for (int x = 0; x < width; x++ ) {
      int loc = x + y*width;
      // The functions red(), green(), and blue() pull out the three color components from a pixel.
      float r = red(img.pixels [loc]); 
      float g = green(img.pixels[loc]);
      float b = blue(img.pixels[loc]);

      float h = hue(img.pixels [loc]);
      float s = saturation(img.pixels [loc]);
      float br = brightness(img.pixels [loc]);


      colorMode(HSB);


      //This number controls the brightness threshold (0-255)
      if (br < 250) {
        //This is the percentage of points that are drawn at above threshold (5-10% is best)
        if(random(1) < 0.07){
        
        addPoint(x,y);
        println("x: " + x + ", y: " + y);
        }        
  }

      pixels[loc] = color(h, s, br);
    }
  }

}
