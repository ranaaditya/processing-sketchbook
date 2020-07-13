void setup() {

}
void settings() {
  size(100, 100);
}

void draw() {
  if (mouseX < 50) {
    cursor(CROSS);
  } else {
    cursor(HAND);
  }
}
