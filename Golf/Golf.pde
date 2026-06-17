boolean airborne;
float x = 100;
float y = 500;
float vx, vy;
float cx = 500;
char mode = 'm';
int score = 0;
float lpx, lpy;
PFont font;
float fx = 2000;
void setup() {
  size(1000, 600);
  font = createFont("Font.ttf", 10);
}

void draw() {
  x = x+vx;
  y = y+vy;
  if (x > 400)
    translate(400-x, 0);
  if (y > 500) {//if on ground
    vy = -vy*0.5;
    airborne = false;
    y = 500;
    if (vy < 2 && vy > -2) {
      vy = 0;
    }
  } else {
    airborne = true;
  }
  if (airborne) {//if in the air
    vy = vy + 1;
  }
  if (!airborne && vx != 0) {
    vx = sqrt(vx*vx*0.8);
    if (vx < 0) {
      vx = 0;
    }
  }
  textFont(font, 128);
  background(100, 150, 200);

  pushMatrix();
  translate(x, 0);
  fill(100, 200, 100);
  rect(-900, 500, 10000, 100);
  fill(255);
  translate(0, y);
  rotate(x/10);
  scale(500/y);
  circle(0, 0, 20);
  circle(6, 0, 5);
  circle(-4, 4, 5);
  circle(-4, -4, 5);
  popMatrix();
  rect(fx-5, 400, 10, 100);
  if (mode == 'm') {
    textSize(100);
    text("''golf''", 350, 200);
    rect(400, 300, 200, 100);
    fill(0);
    textSize(50);
    text("Play", 440, 360);
  }
  if (mousePressed) {
    line(x+10, y-20, mouseX+x, mouseY);
  }
}
void mouseReleased() {
  //start button
  if (mode == 'g') {
    float n = atan((mouseY)/(mouseX));
    vx = cos(n)*(dist(mouseX+x, mouseY, x, y))/20;
    vy = sin(n)*(dist(mouseX+x, mouseY, x, y))/20;
    score++;
    lpx = x;
    lpy = y;
  }
  if (mode == 'm' && mouseX > 400 && mouseX < 600 && mouseY > 300 && mouseY < 400) {
    mode = 'g';
  }
}
