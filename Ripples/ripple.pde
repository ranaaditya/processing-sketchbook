int verts = 1000;
float scale = 5000;
float xoff = 100;
float yoff = -1000;
int centerx, centery;
int bg = color(253, 246, 227);
int fg = color(220, 50, 47);

void setup() {
    fullScreen();
    background(bg);
    stroke(fg);
    pixelDensity(displayDensity());
    fill(bg);
    initCenter();
}

void initCenter() {
    centerx = floor(width * random(1));
    centery = floor(height * random(1));
}

void draw() {
    translate(centerx, centery);
    beginShape();
    for(int i = 0; i < verts; i++) {
        PVector vert = PVector.fromAngle((float) i / verts * TWO_PI);
        float n = noise(vert.x + xoff, vert.y + yoff) * scale;
        vert.mult(n);
        curveVertex(vert.x, vert.y);
    }
    endShape(CLOSE);
    xoff += 0.002;
    yoff += 0.002;
    scale *= 0.997;

    if(scale < 5) {
        background(bg);
        scale = 5000;
        initCenter();
    }
}
