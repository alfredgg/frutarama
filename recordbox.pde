class RecordBox {
  boolean is_finished = false;
  
  void draw() {
    draw_in_the_middle(recordboxImg);

    textSize(50);
    fill(150);
    int x = width / 2;
    int y = height / 2 + 100;
    text(recordName, x, y);
  }
  
  boolean isFinished() {
    return is_finished;    
  }
  
  void keyPressed(int kcode) {
    if ((key >= 'a' && key <= 'z') || (key >= 'A' && key <= 'Z')) {
      if (recordName.length() < 15)
        recordName += key;
    } else if (key == ENTER) {
      if (recordName.length() > 1) is_finished = true;
    } else if (key == BACKSPACE) {
      if (recordName.length() > 0) recordName = recordName.substring(0, recordName.length() - 1);
    }
  }
}
