
import java.util.Arrays;


ArrayList<boolean[]> cells = new ArrayList();
int scale = 3;
int rule = 18;
boolean[] startingcondition = {true};
boolean[] rules;

void setup() {
    fullScreen();
    stroke(0);
    strokeWeight(scale);
    // precompute rule array
    rules = new boolean[8];
    regenerateRules();
    //noSmooth();
    smooth();
}

int cheapocounter = 0;
void draw() {
        background(255);
        genRows();
        drawRows();
        cheapocounter++;
}

void genRows() {
    if (cells.size() == 0) {
        cells.add(startingcondition);
    } else {
        if (cells.size() >= height / scale) cells.remove(0);
        cells.add(next(cells.get(cells.size() - 1)));
    }
}

boolean[] next(boolean[] previous) {
    // pad previous with two whites on both sides
    boolean[] x = new boolean[previous.length + 4];
    x[0] = false;
    x[1] = false;
    x[x.length - 2] = false;
    x[x.length - 1] = false;
    for(int i = 0; i < previous.length; i++) {
        x[i + 2] = previous[i];
    }

    // compute next row
    boolean[] result = new boolean[previous.length + 2];

    for(int i = 0; i < x.length - 2; i++) {
        int ruleindex = 0;
        if(x[i]) ruleindex += 4;
        if(x[i+1]) ruleindex +=2;
        if(x[i+2]) ruleindex += 1;

        result[i] = rules[ruleindex];
    }

    return result;
}

void drawRows() {
    int start = (width + startingcondition.length) / 2;
    for(int i = 0; i < cells.size(); i++) {
        for(int j = 0; j < cells.get(i).length; j++) {
            if(cells.get(i)[j]) stroke(255);
            else stroke(0);
            rect(j*scale + start, i*scale, scale, scale);
        }
        start-=scale;
    }
}

void regenerateRules() {
    for(int i = 0; i < rules.length; i++) {
        rules[i] = ((rule >> i) & 0x01) != 0;
    }
}
