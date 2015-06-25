class Stars {
  int NUM_STARS = 0;
  int MAX_DEPTH = 0;
  float[][] stars;
  boolean withImage = false;
  PImage[] images;
  int[] imageIdxs;
  int sizeMultiplier = 5;
  
  Stars (int nstars, int depth) {
    NUM_STARS = nstars;
    MAX_DEPTH = depth;
    stars = new float[NUM_STARS][3];
    
    for (int i=0; i<NUM_STARS; i++) {
      stars[i][0] = random(-25, 25);
      stars[i][1] = random(-25, 25);
      stars[i][2] = random(1, MAX_DEPTH);
    }
  }
  
  Stars (int nstars, int depth, PImage[] imgs, int max_size) {
    NUM_STARS = nstars;
    MAX_DEPTH = depth;
    stars = new float[NUM_STARS][3];
    imageIdxs = new int[NUM_STARS];
    images = imgs;
    sizeMultiplier = max_size;
    
    for (int i=0; i<NUM_STARS; i++) {
      stars[i][0] = random(-25, 25);
      stars[i][1] = random(-25, 25);
      stars[i][2] = random(1, MAX_DEPTH);
      imageIdxs[i] = (int)random(images.length);
    }
    withImage = true;
  }
  
  void draw () {
    int origin_x = width / 2;
    int origin_y = height / 2;
    float k = 0;
    int x, y, ssize, scolor;
    boolean inside_x, inside_y;
    int idx = 0;
  
    for (int i=0; i<NUM_STARS; i++) {
      stars[i][2] -= 0.19;
      if (stars[i][2] <= 0) {
        stars[i][0] = random(-25, 25);
        stars[i][1] = random(-25, 25);
        stars[i][2] = MAX_DEPTH;
        if (withImage) imageIdxs[i] = (int)random(images.length);
      }
      k = 128.0 / stars[i][2];
      x = (int)(stars[i][0] * k + origin_x);
      y = (int)(stars[i][1] * k + origin_y);
      inside_x = (x > 0) && (x < width);
      inside_y = (y > 0) && (y < height);
      if (inside_x && inside_y) {
        ssize = (int)((1 - stars[i][2] / MAX_DEPTH) * sizeMultiplier);
        if (withImage) {
          idx = imageIdxs[i];
          image(images[idx], x, y, ssize, ssize);
        } else {
          scolor = (int)((1 - stars[i][2] / MAX_DEPTH) * 255);
          fill(scolor); 
          noStroke();
          ellipse(x, y, ssize, ssize);
        }
      }
    }
  }
}
