void setup() {
    size(800, 800, P3D);
    background(0);
    stroke(255);
    strokeWeight(5);
}

float changerate = 0.005;
float timeslice = 0.0;
float noiseScale = 0.005;
void draw() {
    translate(width/2, height/2);
    background(0);
    rotateX((mouseY - height/2)*2*PI/width);
    rotateZ((mouseX - width/2)*2*PI/height);
    for(int i = -250; i < 250; i+=10) {
        for(int j = -250; j < 250; j+=10) {
            point(i, j, noise(i * noiseScale, j * noiseScale, timeslice) * 100 - 50);
        }
    }
    timeslice += changerate;
}
