boolean airborne;
float x = 100;
float y = 500;
float vx, vy;
float cx = 500;
char mode = 'm';
int score = 0;
PFont font;
void setup() {
  size(1000, 600);
  font = createFont("Font.ttf", 10);
}

void draw() {
  x = x+vx;
  y = y+vy;
  if(x > 400)
  translate(400-x,0);
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
  fill(100, 200, 100);
  rect(0, 500, 1000, 100);
  fill(255);
  pushMatrix();
  translate(x,y);
  rotate(x/10);
  circle(0, 0, 20);
  circle(6, 0, 5);
  circle(-4, 4, 5);
  circle(-4, -4, 5);

  popMatrix();
  if (mode == 'm') {
    textSize(100);
    text("''golf''", 350, 200);
    rect(400, 300, 200, 100);
    fill(0);
    textSize(50);
    text("Play", 440, 360);
    if (mousePressed) {
      line(x+10, y-20, mouseX, mouseY);
    }
  }
}
void mouseReleased() {
  //start button
  if (mode == 'g') {
    float n = atan((mouseY-y)/(mouseX-x));
    vx = cos(n)*(dist(mouseX, mouseY, x, y))/20;
    vy = sin(n)*(dist(mouseX, mouseY, x, y))/20;
    score++;
  }
  if (mode == 'm' && mouseX > 400 && mouseX < 600 && mouseY > 300 && mouseY < 400) {
    mode = 'g';
  }
}
