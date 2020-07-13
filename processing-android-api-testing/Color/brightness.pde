noStroke();
colorMode(HSB, 255);
color c = color(0, 126, 255);
fill(c);
rect(15, 20, 35, 60);
float value = brightness(c);  // Sets 'value' to 255
fill(value);
rect(50, 20, 35, 60);
