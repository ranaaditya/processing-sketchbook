
import processing.ar.*;

ARTracker tracker;
ARAnchor anchor;

void setup() {
  fullScreen(AR);
  tracker = new ARTracker(this);
  tracker.start();  
}

void draw() {
  lights();
  
  if (mousePressed) {
    if (anchor != null) anchor.dispose();
    ARTrackable hit = tracker.get(mouseX, mouseY);
    if (hit != null) anchor = new ARAnchor(hit);
    else anchor = null;
  }

  if (anchor != null) {
    anchor.attach();
    box(100);
    anchor.detach();
  }
}
