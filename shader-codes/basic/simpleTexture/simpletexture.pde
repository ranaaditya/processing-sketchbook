/* Simple Texture by Andres Colubri
  Description: Applies a texture on a rotating 3D cylinder
  Texture from Jason Liebig's FLICKR collection of vintage labels and wrappers:
  http://www.flickr.com/photos/jasonliebigstuff/3739263136/in/photostream/
  Note: Please note that examples are read-only, therefore if you modify an example you must save it as a new project for the changes to apply).
*/

PImage label;
PShape can;
float angle;

PShader texShader;

void setup() {
  size(640, 360, P3D);  
  label = loadImage("lachoy.jpg");
  can = createCan(100, 200, 32, label);
  texShader = loadShader("texfrag.glsl", "texvert.glsl");
}

void draw() {    
  background(0);
    
  shader(texShader);  
    
  translate(width/2, height/2);
  rotateY(angle);  
  shape(can);  
  angle += 0.01;
}

PShape createCan(float r, float h, int detail, PImage tex) {
  textureMode(NORMAL);
  PShape sh = createShape();
  sh.beginShape(QUAD_STRIP);
  sh.noStroke();
  sh.texture(tex);
  for (int i = 0; i <= detail; i++) {
    float angle = TWO_PI / detail;
    float x = sin(i * angle);
    float z = cos(i * angle);
    float u = float(i) / detail;
    sh.normal(x, 0, z);
    sh.vertex(x * r, -h/2, z * r, u, 0);
    sh.vertex(x * r, +h/2, z * r, u, 1);    
  }
  sh.endShape(); 
  return sh;
}
