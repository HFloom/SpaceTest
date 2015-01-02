ArrayList<Point> points;
ArrayList<Explosion> explosions;

void setup() {
  size(500, 500);
  noSmooth();
  frameRate(30);
  background(0);

  points = new ArrayList<Point>();
  for (int i = 0; i < 200; i++) {
    points.add(new Point(random(width), random(height), (random(1) <= 0.33) ? color(0, 255, 0) : (random(1) > 0.5) ? color(255, 0, 0) : color(0, 0, 255)));
  }
  explosions = new ArrayList<Explosion>();
}

void draw() {
  println(frameRate);
  loadPixels();

  fade(15);

  strokeWeight(1);
  for (int i = 0; i < points.size (); i++) {
    Point p = points.get(i);
    p.update();
    stroke(p.c);

    if (p.moving()) {
      color collide = pixels[floor(p.y) * width + floor(p.x)];
      if (red(collide) > 254 || green(collide) > 254 || blue(collide) > 254) {
        explosions.add(new Explosion(p.x, p.y, 10, 50, p.c));
        points.remove(i);
      }
    }

    if (p.x < 0 || p.y < 0 || p.x > width || p.y > height) {
      explosions.add(new Explosion(p.x, p.y, 10, 50, p.c));
      points.remove(i);
    }

    line(round(p.x), round(p.y), round(p.px), round(p.py));
  }

  strokeWeight(2);
  for (int i = 0; i < explosions.size (); i++) {
    Explosion e = explosions.get(i);
    e.update();
    if (e.done) {
      explosions.remove(i);
    }
  }
}

void mousePressed() {
  if (mouseButton == RIGHT) {
    explosions.add(new Explosion(mouseX, mouseY, 10, 50, color(255)));
  } else {  
    points.add(new Point(random(width), random(height), (random(1) <= 0.33) ? color(0, 255, 0) : (random(1) > 0.5) ? color(255, 0, 0) : color(0, 0, 255)));
  }
}

void fade(int amnt) {  
  int v;  
  color c;  
  for (int y = 0; y < height; y++) {  
    for (int x = 0; x < width; x++) {  
      c = get(x, y);  
      v = color(max(int(red(c)) - amnt, 0), max(int(green(c)) - amnt, 0), max(int(blue(c)) - amnt, 0)); 
      set(x, y, v);
    }
  }
}

float[] limitComponents(float maxLength, float x, float y) {
  float lengthSquared = x*x + y*y;

  if ((lengthSquared > maxLength * maxLength) && (lengthSquared > 0)) {
    float ratio = maxLength / sqrt(lengthSquared);
    x *= ratio;
    y *= ratio;
  }
  return new float[] { 
    x, y
  };
}

