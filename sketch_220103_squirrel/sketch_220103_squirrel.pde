PShape shape;

void setup() {
  size(400, 400);
  colorMode(HSB, 360, 100, 100);

  shape = loadShape("./images/squirrel.svg");
  shape.disableStyle();
  shapeMode(CENTER);
  strokeJoin(ROUND);
}

void draw() {
  background(0);

  blendMode(SCREEN);
  for (int i = 1; i < 50; ++i) {
    strokeWeight(i);
    stroke(
      i, 
      80, 
      map(i, 1, 50, 15, 1), 
      100
      );

    noFill();
    shape(shape, width/2, height/2, 300, 300);
  }
}
