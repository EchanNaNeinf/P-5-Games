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
float power = 0;
int pd = 1;
int lowScore;
int pastFlag = 1;
void setup() {
  size(1000, 600);
  font = createFont("Font.ttf", 10);
}

void draw() {
  if (mode == 'g') {//past flag
    if (x > fx) {
      pastFlag = -1;
    } else {
      pastFlag = 1;
    }
    x = x+vx;
    y = y+vy;
    pushMatrix();
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
      if (vx < 0.5 && vx > -0.5) {
        vx = 0;
      }
    }
    textFont(font, 128);
    background(100, 150, 200);
    if (mousePressed) {
      if (x < 400) {
        line(x, y, mouseX, mouseY);
      } else {
        line(x, y, mouseX+x-400, mouseY);
      }
    }
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
    fill(100);
    rect(fx-5, 400, 10, 115);
    fill(200, 50, 50);
    triangle(fx-5, 400, fx-60, 410, fx-5, 420);
    fill(0);
    ellipse(fx, 510, 30, 20);
    if (x > fx-30 &&x < fx + 30 && !airborne) {// inHole
      mode = 'o';
      if (score < lowScore) {
        lowScore = score;
      }
    }
    popMatrix();
    if (mousePressed) {
      fill(200, 50, 50);
      rect(100, 100, 20, 100);
      fill(200, 200, 50);
      rect(100, 200, 20, 100);
      fill(50, 200, 50);
      rect(100, 300, 20, 100);
      triangle(140, map(power,50,0,95,395), 120, map(power,50,0,100,400), 140, map(power,50,0,105,405));
      power = power+pd;
      if(power <= 1){
        pd = 1;
      }else if(power >= 50){
        pd = -1;
      }
    }
  } else if (mode == 'm') {
    background(100, 150, 200);

    fill(255);
    textSize(100);
    text("''golf''", 350, 200);
    rect(400, 300, 200, 100);
    fill(0);
    textSize(50);
    text("Play", 440, 360);
  } else if (mode == 'o') {
    background(100, 150, 200);
    fill(100, 200, 100);
    rect(-900, 500, 10000, 100);
    fill(100);
    rect(400-5, 400, 10, 115);
    fill(200, 50, 50);
    triangle(400-5, 400, 400-60, 410, 400-5, 420);
    fill(0);
    ellipse(400, 510, 30, 20);
    textSize(100);
    if (score == 1) {
      text("Hole in One", 200, 130);
    } else if (score == 2) {
      text("Double", 200, 130);
    } else if (score == 3) {
      text("Par", 200, 130);
    } else {
      text("Par Plus "+(score-3), 200, 130);
    }
    textSize(50);
    text("High Score:"+score, 200, 360);
  }
}
void mouseReleased() {
  //start button
  if (mode == 'g' && !airborne) {
    float n = atan(float(mouseY-500)/float(mouseX-400));
    print(" "+atan(float(mouseY-500)/float(mouseX-400)));
    vx = cos(n)*power*float(pastFlag);
    vy = sin(n)*power;
    score++;
    lpx = x;
    lpy = y;
  }
  if (mode == 'm' && mouseX > 400 && mouseX < 600 && mouseY > 300 && mouseY < 400) {
    mode = 'g';
  }
  if (mode == 'o') {
    mode = 'g';
    score = 0;
    x = 100;
    y = 500;
  }
}
