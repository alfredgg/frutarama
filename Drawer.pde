
class Drawer {
  float lastX = -50;
  float lastY = -50;
  int bgColor = 0;  
  PGraphics graphics;
  ArrayList<SubDrawer> sdrawers = new ArrayList<SubDrawer>();
  
  Drawer (int bColor) {
    graphics = createGraphics(width, height);
    bgColor = bColor;
  }
  
  void draw () {
    graphics.beginDraw();
    
    graphics.noStroke();
    graphics.fill(bgColor, 15);
    graphics.rect(0,0,width, height);
    
    for (int i = sdrawers.size(); i > 0; i--) {
      SubDrawer sd = sdrawers.get(i-1);
      sd.draw(graphics);
      if (sd.stopped) {
        sdrawers.remove(i-1);
      }
    }
    
    graphics.endDraw();
    image(graphics, 0, 0);    
  }
    
  void new_dest(int _x, int _y) {   
    SubDrawer sd = new SubDrawer(lastX, lastY, _x, _y);
    lastX = _x;
    lastY = _y;
    sdrawers.add(sd);
  }
}

class SubDrawer {
  float beginX;  // Initial x-coordinate
  float beginY;  // Initial y-coordinate
  boolean stopped = false;
  float pct = 0.0;      // Percentage traveled (0.0 to 1.0)
  float distX;          // X-axis distance to move
  float distY;          // Y-axis distance to move
  float x = 0.0;        // Current x-coordinate
  float y = 0.0;        // Current y-coordinate
  float endX = 570.0;   // Final x-coordinate
  float endY = 320.0;   // Final y-coordinate
  float exponent = 4;   // Determines the curve
  int nbrush = 0;
  float step = 0.02;    // Size of each step along the path
  
  SubDrawer(float bX, float bY, float eX, float eY) {
    beginX = bX;
    beginY = bY;
    endX = eX;
    endY = eY;
    nbrush = int(random(6));
    distX = endX - beginX;
    distY = endY - beginY;
    x = bX;
    y = bY;
  }
  
  void draw(PGraphics graphics) {
    float prevX = x;
    float prevY = y; 
    
    pct += step;
    if (pct < 1.0) {
      x = beginX + (pct * distX);
      y = beginY + (pow(pct, exponent) * distY);
    }
    
    float red = map(x, 0, width, 0, 255);
    float blue = map(y, 0, width, 0, 255);
    float green = dist(x,y,width/2,height/2);
    float speed = dist(prevX, prevY, x, y);
    float alpha = map(speed, 0, 20, 0, 10);
    float lineWidth = map(speed, 0, 10, 10, 1);
    lineWidth = constrain(lineWidth, 0, 10);   

    graphics.stroke(red, green, blue, 255);
    graphics.strokeWeight(lineWidth);
    graphics.line(prevX, prevY,x, y);
    if (speed > 0) {
      //brush1(graphics, x, y,speed, speed,lineWidth);
      if (nbrush == 0) brush2(graphics, x, y,speed, speed,lineWidth);
      if (nbrush == 1) brush3(graphics, x, y,speed, speed,lineWidth);
      if (nbrush == 2) brush4(graphics, prevX, prevY,x, y,lineWidth);
      if (nbrush == 3) brush5(graphics, prevX, prevY, x, y,lineWidth);
      if (nbrush == 4) brush6(graphics, x, y,speed, speed,lineWidth);
      if (nbrush == 5) brush7(graphics, prevX, prevY, x, y,lineWidth);
    }
    else {
      stopped = true;
    }
  }
}
