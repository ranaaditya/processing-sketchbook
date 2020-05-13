void setup() {

  size(500,500);
  surface.setTitle("Hello World!");
  surface.setResizable(true);
  surface.setLocation(width, width);
}

void draw() {
  background(204);
  line(0, 0, width, height);
  line(width, 0, 0, height); 
}
