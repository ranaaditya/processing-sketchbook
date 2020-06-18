float x, y;
void setup() {
  size(800, 800);
  background(64, 71, 87);
}
void drawPoint() {
  stroke(0, 158, 82);
  strokeWeight(0.5);
  float px = map(x, -2.1820, 2.6558, 100, width-100);
  float py = map(y, 0, 9.9983, height-100, 100);
  point(px, py);
}
void nextPoint() {
  float nextX, nextY;
  float r = random(1);
  if (r < 0.01) {
    nextX =  0;
    nextY =  0.16 * y;
  } else if (r < 0.86) {
    nextX =  0.85 * x + 0.04 * y;
    nextY = -0.04 * x + 0.85 * y + 1.6;
  } else if (r < 0.93) {
    nextX =  0.20 * x - 0.26 * y;
    nextY =  0.23 * x + 0.22 * y + 1.6;
  } else {
    nextX = -0.15 * x + 0.28 * y;
    nextY =  0.26 * x + 0.24 * y + 0.44;
  }
  x = nextX;
  y = nextY;
}
void draw() {
  for (int i = 0; i < 100; i++) {
    drawPoint();
    nextPoint();
  }
}
