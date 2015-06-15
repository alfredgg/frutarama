//The MIT License (MIT) - See Licence.txt for details

//Copyright (c) 2013 Mick Grierson, Matthew Yee-King, Marco Gillies


void brush1(PGraphics g, float x,float y, float px, float py, float lineWidth) {
  g.strokeWeight(lineWidth);
  g.ellipse(x,y,px,py); 
}


void brush2(PGraphics g, float x,float y, float px, float py, float lineWidth) {
  g.strokeWeight(lineWidth);
  g.pushMatrix();
  g.translate(x,y);
  g.rotate(random(px));
  g.rect(0+random(50),0+random(50),10,10); 
  g.popMatrix();
}

void brush3(PGraphics g, float x,float y, float px, float py, float lineWidth) {
  g.strokeWeight(lineWidth);
  g.pushMatrix();
  g.translate(x,y);
  g.rotate(random(px));
  g.line(0+random(50),0+random(50),0,0);
  g.rotate(random(px));
  g.line(0+random(50),0+random(50),0,0);
  g.rotate(random(px));
  g.line(0+random(50),0+random(50),0,0);
  g.popMatrix();
}

void brush4(PGraphics g, float x,float y, float px, float py, float lineWidth) {
  g.strokeWeight(lineWidth);
  g.line(px,py,x,y);
  g.line(px,py,x,y);
  g.line(width/2+((width/2)-px),py,width/2+((width/2)-x),y);
  g.line(px,height/2+((height/2)-py),x,height/2+((height/2)-y));
  g.line(width/2+((width/2)-px),height/2+((height/2)-py),width/2+((width/2)-x),height/2+((height/2)-y));
}

void brush5(PGraphics g, float x,float y, float px, float py, float lineWidth) {
  g.strokeWeight(lineWidth);
  g.line(px,py,x,y);
  g.line(width/2+((width/2)-px),py,width/2+((width/2)-x),y);
  g.line(px,height/2+((height/2)-py),x,height/2+((height/2)-y));
  g.line(width/2+((width/2)-px),height/2+((height/2)-py),width/2+((width/2)-x),height/2+((height/2)-y));
  g.line(width/2+((width/2)-py),width/2-((width/2)-px),width/2+((width/2)-y),width/2-((width/2)-x));
  g.line(height/2-((height/2)-py),width/2-((width/2)-px),height/2-((height/2)-y),width/2-((width/2)-x));
  g.line(width/2+((width/2)-py),height/2+((height/2)-px),width/2+((width/2)-y),height/2+((height/2)-x));
  g.line(width/2-((width/2)-py),height/2+((height/2)-px),width/2-((width/2)-y),height/2+((height/2)-x));
}

void brush6(PGraphics g, float x,float y, float px, float py, float lineWidth) {
  g.strokeWeight(lineWidth);
  px=px+random(50);
  py=py+random(50);
  g.ellipse(x,y,px,py);
  g.ellipse(width/2+((width/2)-x),y,px,py);
  g.ellipse(x,height/2+((height/2)-y),px,py);
  g.ellipse(width/2+((width/2)-x),height/2+((height/2)-y),px,py);
  g.ellipse(width/2+((width/2)-y),width/2-((width/2)-x),px,py);
  g.ellipse(height/2-((height/2)-y),width/2-((width/2)-x),px,py);
  g.ellipse(width/2+((width/2)-y),height/2+((height/2)-x),px,py);
  g.ellipse(width/2-((width/2)-y),height/2+((height/2)-x),px,py);  
}

void brush7(PGraphics g, float x,float y, float px, float py, float lineWidth) {
  g.strokeWeight(lineWidth);
  g.line(px,py,x,y);
  g.line(width/2+((width/2)-px),py,width/2+((width/2)-x),y);
}
