class Point {
  float x, y, velX, velY, px, py;
  color c;

  Point(float _x, float _y, color _c) {
    x = _x;
    y = _y;
    velX = 0;
    velY = 0;
    px = x;
    py = y;
    c = _c;
  }

  void update() {
    float dirX = mouseX - x;
    float dirY = mouseY - y;
    
    float[] comps = limitComponents(0.5, dirX, dirY);
    dirX = comps[0];
    dirY = comps[1];
    
    velX += dirX;
    velY += dirY;
    
    comps = limitComponents(4, velX, velY);
    velX = comps[0];
    velY = comps[1];

    px = x;
    py = y;
    x += velX;
    y += velY;
  }
  
  boolean moving() {
    return (sqrt(velX*velX + velY*velY) > 1);
  }
}

