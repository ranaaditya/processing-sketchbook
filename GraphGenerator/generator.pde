int MAX_RADIUS = 200;
FourierSegment root;
ArrayList<Float> test = new ArrayList<Float>();

void setup() {
  fullScreen();
  frameRate(60);
  root = new FourierSegment();
  root.radius = 200;
  root.offset = 0;
  root.frequency = 1 / TWO_PI;
  FourierSegment previous = root;
  for(int i = 1; i < 2; i++) {
    FourierSegment nextSegment = new FourierSegment();
    nextSegment.radius = root.radius / (2 * i + 1);
    nextSegment.frequency = (2 * i + 1) / TWO_PI;
    nextSegment.offset = (2 * i + 1) / TWO_PI;
    previous.childSegment = nextSegment;
    previous = nextSegment;
  }
  smooth();
}

void draw() {
  background(0);
  stroke(20);
  line(500, 0, 500, height);
  stroke(130);
  noFill();
  pushMatrix();
  translate(500, 0);
  strokeWeight(1);
  beginShape();
  for(int i = 0; i < test.size(); i++) {
    vertex(i*2, test.get(i));
  }
  endShape();
  strokeWeight(1);
  popMatrix();
  root.updateAndRedrawAllChildren(250, height/2, 0);
  if(test.size() > 600) {
    test.remove(test.size() - 1);
  }
}

class FourierSegment {

  public float frequency, radius, colour, offset;
  public FourierSegment childSegment;

  public FourierSegment() {
    this(random(-1, 1),
         random(1, MAX_RADIUS),
         color(random(0,255), random(0,255), random(0, 255)),
         random(TWO_PI)
    );
  }
  public FourierSegment(float frequency,
      float radius,
      float colour,
      float initOffset) {
    this.frequency = frequency;
    this.radius = radius;
    this.colour = colour;
    this.offset = initOffset;
  }

  public void updateAndRedrawAllChildren(float x, float y, float parentOffset) {
    PVector child = PVector.fromAngle(this.offset + parentOffset);
    child.mult(this.radius/2);
    if(this.childSegment != null) {
      this.childSegment.updateAndRedrawAllChildren(x + child.x, y + child.y, this.offset + parentOffset);
    } else {
      stroke(130);
      fill(130);
      test.add(0,y+child.y);
      line(x+child.x, y+child.y, 500, y+child.y);
      ellipse(500, y+child.y, 5, 5);
    }
    this.offset += TWO_PI / ((1 / this.frequency) * 30);
    stroke(255);
    noFill();
    ellipse(x, y, this.radius, this.radius);
    //child = PVector.fromAngle(this.offset + parentOffset);
    //child.mult(this.radius/2);
    line(x, y, x + child.x, y + child.y);
    fill(255);
    ellipse(x + child.x, y + child.y, 5, 5);
  }
}
