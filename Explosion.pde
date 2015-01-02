class Explosion {
  boolean done;
  float time;
  float maxTime;

  int num;
  float[] x, y, velX, velY;
  color[] c;

  Explosion(float _x, float _y, int _num, float _time, color _c) {
    num = _num;

    x = new float[num];
    y = new float[num];
    
    velX = new float[num];
    velY = new float[num];
    c = new color[num];

    for (int i = 0; i < num; i++) {      
      x[i] = _x;
      y[i] = _y;
      
      float angle = radians(random(360));
      velX[i] = 1.5 * cos(angle);
      velY[i] = 1.5 * sin(angle);

      c[i] = _c;
    }

    maxTime = _time;
    time = _time;
    done = false;
  }

  void update() {
    time--;
    if (time < 0) done = true;

    for (int i = 0; i < num; i++) {
      stroke(red(c[i]), green(c[i]), blue(c[i]), 255 * time / maxTime);
      beginShape(LINES);
      vertex(x[i], y[i]);
      
      x[i] += velX[i];
      y[i] += velY[i];
      
      vertex(x[i], y[i]);
      endShape();
    }
  }
}

