float bx= random(50, 550);
float by= random(50, 450);
float vbx = 0;
float vby = 0;
int saveScore = 0;
int size = 0;
boolean paused = false;
boolean gameover = false;
int setting = 1;
void setup() {
  size(600, 500);
  textSize(50);
}
void draw() {
  if (!gameover) {
    //clear screen
    background(0);
  } else {
    //game over effect
    rect(50, 50, 500, 400);
    size = round(random(10, 100));
    bx = random(0, 600);
    by = random(0, 500);
    vbx = 0;
    vby = 0;
    fill(0);
    text("Game Over!", 200, 100);
    text("Score: "+saveScore, 200, 200);
    text("Click to restart.", 200, 300);
    fill(255);
  }
  if (paused) {
    //pauseUI
    rect(50, 50, 500, 400);
    fill(0);
    text("Difficulty Selected:", 130, 100);
    strokeWeight(10);
    stroke(1);
    line(100, 300, 500, 300);
    line(100, 270, 100, 330);
    line(300, 270, 300, 330);
    line(500, 270, 500, 330);
    //setting display
    if (setting == 1) {
      text("Easy", 230, 175);
      fill(255);
      circle(100, 300, 50);
    } else if (setting == 2) {
      text("Medium", 200, 175);
      fill(255);
      circle(300, 300, 50);
    } else if (setting == 3) {
      text("Hard", 230, 175);
      fill(255);
      circle(500, 300, 50);
    }
    noStroke();
    fill(255);
  } else {
    bx = bx+vbx;
    by = vby+by;
    circle(bx, by, 100-size);
  }
  //flip direction if wall
  if (by<50||by>450) {
    vby = vby*-1;
  }
  if (bx<50||bx>550) {
    vbx = vbx*-1;
  }
  //pausebutton
  rect(0, 400, 100, 100);
  fill(0);
  rect(25, 425, 10, 50);
  rect(65, 425, 10, 50);
  fill(255);
}
void mouseReleased() {
  if (dist(mouseX, mouseY, bx, by) <= 50&&!gameover) {
    size++;
    noStroke();
    bx = random(50, 550);
    by = random(50, 450);
    vbx = random(-1, 1) * size*setting/2;
    vby = random(-1, 1) * size*setting/2;
  } else if (mouseX<100&&mouseY>400) {
    paused = !paused;
  } else if (paused) {
    setting++;
    if (setting == 4) {
      setting = 1;
    }
  } else if (!gameover) {
    saveScore = size;
    gameover = true;
  } else {
    background(0);
    gameover = false;
    saveScore = 0;
    size = 0;
  }
}
