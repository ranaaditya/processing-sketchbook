float angle = 0;
void setup() {
  fill(#AD71B7);
}
void settings() {
  fullScreen(P3D);

}
void draw() {
  background(#81B771);
  lights();
  translate(width/2, height/2);
  rotateY(angle);
  rotateX(angle*2);
  box(300);
  angle += 0.01;
}

void mousePressed() {
exit();
//noLoop();
}
