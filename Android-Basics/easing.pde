float x;
float easing = 0.01;
float diameter = 12;

void setup() {
size(800, 800);
smooth();
}
void draw() {
float targetX = mouseX;
x += (targetX - x) * easing;
ellipse(x, 40, 12, 12);
println(targetX + " : " + x);
}
