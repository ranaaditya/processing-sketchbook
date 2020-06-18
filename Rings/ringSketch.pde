int bg = 0;
int verts = 100;
float xoff = 100;
float yoff = -1000;
float scale = 120;
float e = 300;
float ee = 0.4;
float ringsspace = 12;
float ringx = -(scale + e);
float z = 111;

int[][] colar = {

    // red-orange
    { color(255, 0, 0)    , color(255, 160, 0)  },

    // blue-purple
    { color(0, 100, 230)  , color(160, 0, 255)  },

    // green-aquamarine
    { color(55, 220, 60)  , color(0, 221, 195)  },

    // kye meh
    { color(131, 96, 195) , color(46, 191, 145) },

    // vanusa
    { color(218, 68, 83)  , color(137, 33, 107) },

    // shifty
    { color(99)           , color(162, 171, 88) },

    // bighead
    { color(201, 75, 75)  , color(75, 19, 79)   },

    // orange coral
    { color(255, 153, 102), color(255, 94, 98)  },

    // scooter
    { color(54, 209, 220) , color(91, 134, 229) },

    // purplepine
    { color(32, 0, 44)    , color(203, 180, 212)},

    // shades of grey
    { color(189, 195, 199), color(44, 62, 80)   },

    // dusk
    { color(44, 62, 80)   , color(253, 116, 108)}
};

int fg1, fg2;

void initScheme() {
    int[] scheme = colar[floor(random(0, colar.length))];
    if(round(random(1)) == 0) {
        fg1 = scheme[0];
        fg2 = scheme[1];
    } else {
        fg1 = scheme[1];
        fg2 = scheme[0];
    }
}

void setup() {
    fullScreen();
    background(bg);
    stroke(255);
    pixelDensity(displayDensity());
    noFill();
    strokeWeight(2);
    initScheme();
    smooth();
}

void draw() {
    stroke(lerpColor(fg1, fg2, ringx / width));
    beginShape();
    for(int i = 0; i < verts; i++) {
        PVector vert = PVector.fromAngle((float) i / verts * TWO_PI);
        vert.mult(scale + noise((vert.x + xoff) * ee, (vert.y + yoff) * ee) * e);
        curveVertex(vert.x + ringx, vert.y + height * noise(z));
    }
    endShape(CLOSE);
    xoff += 0.01;
    yoff += 0.01;
    ringx += ringsspace;
    z += 0.02;
    if(ringx > width + (scale + e)) {
        ringx = -(scale + e);
        delay(2000);
        background(bg);
        initScheme();
    }
}
