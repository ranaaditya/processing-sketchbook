// enter an image(in place of xyz.jpg) to be used by this sketch
String img_name = "xyz.jpg";

PImage swirl_img;

float swirlDensity = 0.03;
float swirlResolution = 0.05;

float swirlAngle = 0;
float magnification = 0;
PVector pre = new PVector(0, 0);
PVector neo = new PVector(0, 0);

void setup() {
    swirl_img = loadImage(img_name);
    swirl_img.resize(900, 0);
    swirl_img.filter(GRAY);
    size(800, 800);
    background(255);
    stroke(0);
    strokeWeight(1);
}

void draw() {
    translate(width/2, height/2);
    neo = PVector.fromAngle(swirlAngle);
    neo.mult(magnification);
    color swirlColor = swirl_img.get(450 + round(neo.x), 450 + round(neo.y));
    strokeWeight((255-green(swirlColor)) * 6 / 255);
    line(pre.x, pre.y, neo.x, neo.y);
    magnification += swirlDensity;
    swirlAngle += swirlResolution;
    pre = neo;
}
