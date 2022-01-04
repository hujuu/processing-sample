int numBalls = 20;
Ball[] balls = new Ball[numBalls];
int r, g, b;
int vy = 0;
int radius;
boolean growing = false;
float spring = 0.05;

void setup() {
  size(640, 480);
  blendMode(ADD);  
  noStroke();
  imageMode(CENTER);
  for (int i = 0; i < numBalls; i++) {
    balls[i] = new Ball(random(width), random(-(height*2)), random(30, 600), i, balls);
  }
}

void draw() {
  background(0, 0, 0);
  
  // vy += 10;
  // radius += 5;
  if (growing) {
      if (radius < 25) {
        radius += 2;
      } else {
        growing = false;
      }
  } else {
      if (radius > 10) {
        radius -= 2;
      } else {
        growing = true;
      }
  }
  
  for (int x = 25; x > 0; x--) {
    float dist = sq(x);
    dist /= 25.0;
    r = constrain(int(80/dist), 0, 255);
    g = constrain(int(80/dist), 0, 255);
    b = constrain(int(200/dist), 0, 255);
    fill(r, g, b);
    ellipse(width/2, height/2 + vy, x*5 + radius, x*5 + radius);
  }
  filter(BLUR, 5);
  
  for (Ball ball : balls) {
    ball.collide();
    ball.move();
    ball.display();
  }
  
  saveFrame("frames/######.png");
}

class Ball {
  
  float x, y;
  float diameter;
  float vx = 0;
  float vy = 0;
  int id;
  Ball[] others;
 
  Ball(float xin, float yin, float din, int idin, Ball[] oin) {
    x = xin;
    y = yin;
    diameter = din;
    id = idin;
    others = oin;
  } 
  
  void collide() {
    for (int i = id + 1; i < numBalls; i++) {
      float dx = others[i].x - x;
      float dy = others[i].y - y;
      float distance = sqrt(dx*dx + dy*dy);
      float minDist = others[i].diameter + diameter;
      if (distance < minDist) { 
        float angle = atan2(dy, dx);
        float targetX = x + cos(angle) * minDist;
        float targetY = y + sin(angle) * minDist;
        float ax = (targetX - others[i].x) * spring;
        float ay = (targetY - others[i].y) * spring;
        vx = 0;
        vy = 0;
        others[i].vx += ax;
        others[i].vy += ay;
      }
    }   
  }
  
  void move() {
    x += 1;
    y += 10;
    if (y > height) {
      y = 0 - random(height); 
    }
  }
  
  void display() {
    blendMode(SCREEN);
    noFill();

    for (int i = 25; i > 0; i--) {
      float dist = sq(i);
      dist /= 25.0;
      r = constrain(int(80/dist), 0, 255);
      g = constrain(int(80/dist), 0, 255);
      b = constrain(int(200/dist), 0, 255);
      fill(r, g, b);
      ellipse(x, y, i*5, i*5);
    }
    filter(BLUR, 5);
  }
}
