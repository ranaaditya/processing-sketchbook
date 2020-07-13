void setup() {
size(600, 600);
smooth();
}
void draw() {
strokeWeight(2);
background(0);
ellipseMode(RADIUS);

// Neck
noStroke();
for (int y = 0; y <= height; y += 40) {
for (int x = 0; x <= width; x += 40) {
fill(255, 140);
ellipse(x, y, 40, 40);
}
}
}
