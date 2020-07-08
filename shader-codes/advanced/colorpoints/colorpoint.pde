/* Taken from http://glsl.heroku.com/e#4633.5
  Description: Draws filled circles with random sizes and colors. Click and drag your mouse on the screen to generate them.
  Note: Please note that examples are read-only, therefore if you modify an example you must save it as a new project for the changes to apply).
*/

PShader pointShader;

void setup() {
  size(640, 360, P3D);
  
  pointShader = loadShader("pointfrag.glsl", "pointvert.glsl");  
  pointShader.set("sharpness", 0.9);
  
  strokeCap(SQUARE);
  background(0);  
}

void draw() {
  if (mousePressed) {
    shader(pointShader);
    
    float w = random(5, 50);
    pointShader.set("weight", w);
    strokeWeight(w);
    
    stroke(random(255), random(255), random(255));  
    point(mouseX, mouseY);
  }
}
