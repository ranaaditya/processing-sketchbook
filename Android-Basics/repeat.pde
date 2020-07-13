void setup() {
size(600, 600);
smooth();
}
void draw() {
strokeWeight(2);
background(204);
ellipseMode(RADIUS);

// Neck
strokeWeight(8);
for (int i = 20; i < 500; i += 60) {
line(i, 40, i + 60, 80);
}
}
