float bx= random(50, 550);
float by= random(50, 450);
float vbx = 0;
float vby = 0;
int saveScore = 0;
int size = 0;
boolean gameover = false;
void setup() {
  size(600, 500);
  textSize(50);
}
void draw() {
  if (!gameover) {
    background(0);
  } else {
    size = round(random(10, 100));
    bx = random(0, 600);
    by = random(0, 500);
    vbx = 0;
    vby = 0;
    fill(0);
    text("Game Over!", 200, 200);
    text("Score: "+saveScore, 200, 300);
    fill(255);
  }
  bx = bx+vbx;
  by = vby+by;
  circle(bx, by, 100-size);
  if (by<50||by>450) {
    vby = vby*-1;
  }
  if (bx<50||bx>550) {
    vbx = vbx*-1;
  }
}
void mouseReleased() {
  if (dist(mouseX, mouseY, bx, by) <= 50&&!gameover) {
    size++;
    bx = random(50, 550);
    by = random(50, 450);
    vbx = random(-1, 1) * size;
    vby = random(-1, 1) * size;
  }else if (!gameover){
    saveScore = size;
    gameover = true;
  }
}
