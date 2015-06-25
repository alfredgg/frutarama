import ddf.minim.spi.*;
import ddf.minim.signals.*;
import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.ugens.*;
import ddf.minim.effects.*;

Minim minim;

void setup () {
  size(1024, 768);
  minim = new Minim(this);
  load_resources();
  load_options();
  
  if (bmusic != null) bmusic.loop();
}

void draw () {
  background(0, 0, 0);
  current_state.draw();
}

void keyPressed() {
  if (mousePressed) {
    current_state.keyPressed(-5);
    return;
  }
  current_state.keyPressed(keyCode);
}

void mousePressed() {
  keyPressed();
}
