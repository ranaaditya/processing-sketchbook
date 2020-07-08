/* Lines by Andres Colubri
  Description: Draws and rotates a wireframe 3D cube
  Note: Please note that examples are read-only, therefore if you modify an example you must save it as a new project for the changes to apply).
*/

PShape cube;
PShader lineShader;
float angle;

float weight = 10;

void setup() {
  size(640, 360, P3D);
  
  lineShader = loadShader("linefrag.glsl", "linevert.glsl");
  
  cube = createShape(BOX, 150);
  cube.setFill(false);
  cube.setStroke(color(255));
  cube.setStrokeWeight(weight);
}

void draw() {
  background(0);
  
  translate(width/2, height/2);
  rotateX(angle);
  rotateY(angle);

  shader(lineShader, LINES);
  shape(cube);
  
  angle += 0.01;  
}
