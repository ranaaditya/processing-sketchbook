void setup() {
  // loads the image from the sketchbook/${sketchname} folder
  // palce dummy.jpg image in the forementioned location
    PImage img = loadImage("dummy.jpg");
    img.filter(GRAY);
    img.filter(INVERT);
    img.resize(75, img.height/img.width * 56);
    for(int i = 0; i < img.height; i++) {
        for(int j = 0; j < img.width; j++) {
            int c = round(green(img.get(j, i)));
            if(c < 42) {
                print("#");
            } else if(c < 85) {
                print("@");
            } else if(c < 128) {
                print("+");
            } else if(c < 170) {
                print("-");
            } else if(c < 213) {
                print(".");
            } else {
                print(" ");
            }
        }
        println();
    }
}
