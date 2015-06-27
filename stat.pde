import java.util.Arrays;

State current_state = new ShowPlay(); 
int record = 0;
String recordName = "";
int time_try = 0;

void draw_in_the_middle(PImage img) {
  int x = width / 2 - img.width / 2;
  int y = height / 2 - img.height / 2;
  image(img, x, y);
}

void draw_in_the_middle(PImage img, int xmarg, int ymarg) {
  int x = width / 2 - img.width / 2 + xmarg;
  int y = height / 2 - img.height / 2 + ymarg;
  image(img, x, y);
}

PImage get_image_by_kcode(int kcode) {
  int idx = -1;
  for (int i=0; i<options.length; i++) {
    if (options[i] == kcode) {
      idx = i;
      break;
    }
  }
  if (idx < 0) return null;
  return iOptions[idx]; 
}

long get_current_mill() {
  return (System.nanoTime() / 1000000);
}

void print_code(int kcode) {
  if (kcode == -5) println("click");
  else if (kcode == (int)' ') println("space");
  else if (kcode == 37) println("left");
  else if (kcode == 38) println("up");
  else if (kcode == 39) println("right");
  else if (kcode == 40) println("down");
}

class State {
  int punt = 0;
  
  public void _draw() {}
  public void _update() {}
  public void keyPressed(int kcode) {}
  
  public void draw() {
    _update();
    drawRecord();
    drawPunt();
    _draw();
  }
    
  void drawRecord() {
    textSize(28);
    fill(150, 150, 150);
    text("Record: " + recordName + ", " + new Integer(record).toString(), 10, 60);
  }
  
  void drawPunt() {
    if (punt == 0) return;
    int x = width - 100;
    int y = height - 100;
    noFill();
    strokeWeight(10);
    stroke(120, 170, 200);
    ellipse(x, y, 100, 100);
    
    textSize(60);
    fill(150);
    String p = new Integer(punt).toString();
    text(p, x - 20 * p.length(), y + 20);
  }
}

class ShowPlay extends State {
  Stars stars;
  String[] values = {
    "el magnífico",
    "el sorprendente",
    "el increíble",
    "el alucinante",
    "el magnificiente",
    "el insondable",
    "el impredecible",
    "el inconcebible",
    "el inverosímil",
    "el fabuloso",
    "el asombroso",
    "el grande y poderoso",
    "el espléndido",
    "el soberbio",
    "el mítico",
    "el legendario",
    "el quimérico",
    "el extraordinario",
    "el estupendo",
    "el ilusorio"
  };
  String current_value;
  long next_time;
  int idx = 0;
  float v = 0;
  
  ShowPlay() {
    println("ShowPlay State");
    stars = new Stars(500, 30);
    choose_one();
  }
  
  void choose_one() {
    current_value = values[idx];
    idx++;
    if (idx == values.length) idx = 0;
   next_time = (get_current_mill() + 500); 
  }

  void _draw() {
    stars.draw();
    draw_in_the_middle(gamestartLogo, 0 , -80);
    textSize(25);
    fill(150);
    
    int y = height / 2 - 130;
    String txt = "Presentan " + current_value;
    float cw = textWidth(txt);
    int x = width / 2 - (int)cw / 2;
    text(txt, x, y);
    
    int w = (int)map(sin(v) + 1, 0, 1, aprieta.width - 100, aprieta.width - 50);
    int h = (int)map(sin(v) + 1, 0, 1, aprieta.height - 30, aprieta.height - 10);
    image(aprieta, width /2 - w/2, height - 150, w, h);
    v+= 0.05;
  }
  
  void _update() {
    if (get_current_mill() > next_time) {
      choose_one();
    }
  }
  
  public void keyPressed(int kcode) {
    current_state = new MyTry(1);
  }
}

class ShowTest extends State {
  ArrayList<Integer> list;
  int current_element = 0;
  long next_second = 0;
  PImage current_img;
  long next_draw = 0;
  
  ShowTest (int nelements) {
    println("ShowTest State");
    
    list = new ArrayList<Integer>();
    for (int i=0; i<nelements; i++) {
      int new_option = (int)random(options.length);
      list.add(options[new_option]);
    }
    
    punt = list.size() - 1;
    
    next_second = get_current_mill() + 1000;
    int code = list.get(current_element);
    current_img = get_image_by_kcode(code);
    print_code(code);
  }

  void _update() {
    if (get_current_mill() > next_second) {
      if (current_element < (list.size() - 1)) {
        next_second = get_current_mill() + 1000;
        next_draw = get_current_mill() + 250;
        current_element++;
        int code = list.get(current_element);
        current_img = get_image_by_kcode(code);
        print_code(code);
      } else {
        current_state = new YourTry(list);
      }      
    }
  }
  
  void _draw() {
    if (get_current_mill() > next_draw) draw_in_the_middle(current_img);
  }
}

class YourTry extends State {
  long time;
  ArrayList<Integer> list;
  
  YourTry (ArrayList<Integer> lst) {
    println("YourTry State");
    time = get_current_mill() + 1250;
    list = lst;
    punt = lst.size() - 1;
  }
  
  void _draw () {
    int x = 10;
    int y = height - 20 - te_toca.height;
    image(te_toca, x, y);
  }
  
  void _update () {
    if (get_current_mill() > time) current_state = new Try(list);
  }
  
    void keyPressed(int kcode) {
      current_state = new Try(list, kcode);
    }
}

class Try extends State {
  boolean draw_stars = false;
  int current_element = 0;
  ArrayList<Integer> list;
  int show_time = 50;
  PImage image = null;
  boolean pass = false;
  
  long endDrawTime;
  long endTry;
  long startDrawRight;
  long beginDraw = 0;
  
  Try (ArrayList<Integer> listOfTries) {
    println("Try State");
    list = listOfTries;
    current_element = 0;
    endTry = get_current_mill() + time_try * 1000; 
    punt = list.size() - 1;
  }
  
  Try (ArrayList<Integer> listOfTries, int kcode) {
    this(listOfTries);
    keyPressed(kcode);
  }
  
  void _draw() {
    if (image == null) return;
    if (get_current_mill() < beginDraw) return;
    if (endDrawTime < get_current_mill()) return;
    draw_in_the_middle(image);
    draw_in_the_middle(right_img);    
  }
  
  void _update() {
    //if (pass && (get_current_mill() > endDrawTime)) the_end();
    if ((get_current_mill() > endDrawTime) && (pass)) {
      current_state = new MyTry(list.size() + 1);
      return;
    }
    if (get_current_mill() > endTry) {
      image = null;
      the_end();
    }
  }
  
  void keyPressed(int kcode) {
    image = get_image_by_kcode(kcode);
    if ((list.size() <= current_element) || (kcode != list.get(current_element))) 
      wrong();
    else
      right();
  }
  
  void right() {
    play_sound(little_right_sound);
    int margin = 0;
    if (get_current_mill() < endDrawTime) margin = 150; 
    beginDraw = get_current_mill() + margin;
    endDrawTime = get_current_mill() + 1000 + margin;
    endTry = get_current_mill() + time_try * 1000;
    current_element ++;
    if (current_element == list.size()) pass = true;
  }
  
  void wrong() {
    the_end();
  }
  
  void the_end () {
    current_state = new WrongSelection(image, list.size() - 1);
  }
}

class MyTry extends State {
  long time;
  int nelems;
  int counter = 3;
  
  MyTry (int n) {
    println("MyTry State");
    time = get_current_mill() + 500;
    nelems = n;
    if (n > 1) {
      play_sound(right_sound);
      punt = n - 1;
    }
  }
  
  void _draw () {
    int x = 10;
    int y = height - 20 - me_toca.height;
    image(me_toca, x, y);
    textSize(80);
    fill(255, 255, 255);
    text(new Integer(counter).toString(), x + 335, y + 150);
  }
  
  void _update () {
    if (get_current_mill() > time) {
      counter --;
      time = get_current_mill() + 1500;
      if (counter == 0) {
        current_state = new ShowTest(nelems);
        return;
      }
    }
  }
}

class EndWithRecord extends State {
  Stars stars;
  RecordBox recordbox = new RecordBox();
  
  EndWithRecord(int points) {
    println("EndWithRecord State");
    stars = new Stars(record_party_size, 30, recordParty, 75);
    recordName = "";
    record = points;
    play_sound(record_sound);
  }
  
  void _draw() {
    stars.draw();
    recordbox.draw();
  }
  
  void _update() {
   if (recordbox.isFinished()) current_state = new ShowPlay();
  } 
  
  void keyPressed(int kcode) {
    recordbox.keyPressed(kcode);
  }
}

class WrongSelection extends State {
  PImage img = null;
  long endTime = get_current_mill() + 10000;
  long endDraw = get_current_mill() + 3000;
  boolean pass = false;
  
  WrongSelection(PImage theirOption, int n) {
    println("EndWithoutRecord State");
    img = theirOption;
    play_sound(wrong_sound);
    punt = n;
  }
  
  void _draw() {
    if (img != null)
      draw_in_the_middle(img);
    draw_in_the_middle(wrong_img);
  }
  
  void _update() {
    if (get_current_mill() > endDraw) {
      if (punt <= record) {
        pass = true;
      } else {
        current_state = new EndWithRecord(punt);
      }
    }
    if (get_current_mill() > endTime)
      current_state = new ShowPlay();      
  }
  
  void keyPressed(int kcode) {
    if (pass) current_state = new ShowPlay();
  }
}
