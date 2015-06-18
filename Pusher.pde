class Pusher {
  color c1, c2, cStroke;
  int size = 200;
  float externSize;
  float maxExternSize;
  int positionX = 0;
  int positionY = 0;
  float velocity = 50;
  float deceleration = 0.4;
  int strokeWidth = 10;
  int activator = 0;
  boolean activated = false;
  AudioPlayer player;
  
  Pusher(color c, String sound) {
    c1 = c;
    c2 = color(c, 30);
    cStroke = color(c, 50);
    externSize = size;
    maxExternSize = size * 2;
    player = minim.loadFile(sound, 5000);
  }
  
  void setSize(int s) {
    size = s;
    externSize = s;    
  }
  
  void draw_inner() {
    noStroke();
    fill(c1);
    ellipse(positionX, positionY, size, size);
  }
  
  void draw_extern() {
    if (!activated) return;
    
    if (externSize > maxExternSize) externSize = size;
    
    strokeWeight(strokeWidth);
    stroke(cStroke);
    noFill();
    ellipse(positionX, positionY, externSize, externSize);
    
    fill(c2);
    noStroke();
    ellipse(positionX, positionY, externSize-strokeWidth, externSize-strokeWidth);
  }
  
  void increase() {
    if (!activated) return;
    externSize = lerp(externSize, maxExternSize, 0.05);
    if (externSize > maxExternSize - 5) {
      activated = false;
    }
  }
  
  void draw() {
    draw_extern();
    draw_inner();
  }
  
  void activate() {
    externSize = size;
    activated = true;
    player.rewind(); 
    player.play();
  }
  
  boolean is_the_key() {
    println(keyCode);
    if ((keyCode == UP) && (activator == -1)) return true;
    return activator == (int)key;
  }
}
