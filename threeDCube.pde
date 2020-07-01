float angle = 0;
boolean rotating = true;
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
if(rotating){
noLoop();
rotating = false;
}
else {
  loop();
  rotating = true;
}
}
