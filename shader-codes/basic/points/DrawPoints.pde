/* Draw Points by Andres Colubri
  Description: Draws points as you move your mouse. Point sizes are random
  Note: Please note that examples are read-only, therefore if you modify an example you must save it as a new project for the changes to apply).
  
*/

PShader pointShader;

void setup() {
  size(640, 360, P3D);
  
  pointShader = loadShader("pointfrag.glsl", "pointvert.glsl");
  
  stroke(255);
  strokeWeight(50);
  
  background(0);
}

void draw() {    
  shader(pointShader);
  // It is possible to set the shader type, but not needed, Processing will try to
  // autodetect the type
  //shader(pointShader, POINTS);
  if (mousePressed) {   
    point(mouseX, mouseY);
  }  
}
