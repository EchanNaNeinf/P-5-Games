float bx= random(50, 550);
float by= random(50, 450);
float vbx = 0;
float vby = 0;
float rand = 0;
float score = 0;
float highScore = 0;
int size = 0;
float colorSet = 255;
float startSize = 100;
boolean paused = false;
boolean gameover = false;
boolean inSettings = false;
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
    if (score != 0){
        text("Game Over!", 200, 100);
    }else{
      textSize(25);
      text("I told you to click on the circle...",100,100);
    }
    textSize(50);
    text("Score: "+score*setting*map(colorSet,0,255,1,2), 100, 200);
    text("High Score: "+highScore*map(colorSet,0,255,1,2), 100, 250);
    text("Click to restart.", 100, 300);
    fill(255);
  }
  if(size == 0){
    textSize(13);
    rect(500, 400, 100, 100);
    fill(0);
    textSize(25);
    text("Settings",510,440);
    fill(255);
    text("Welcome to Monochrome Clicker Game!",100,50);
    textSize(50);
  }
  if(paused){
    rect(50, 50, 500, 400);
    fill(0);
    text("Paused.", 200, 300);
    fill(255);
  }else{
    bx = bx+vbx;
    by = vby+by;
    fill(colorSet);
    circle(bx, by, startSize-size);
    fill(255);
    if(size == 0){
      textSize(13);
      fill(0);
      text("Click me to start!",bx-45,by);
    }
  }
  
  if (inSettings) {
    //pauseUI
    fill(255);
    rect(50, 50, 500, 400);
    fill(0);
    text("Difficulty Selected:", 130, 100);
    textSize(25);
    text("Visibility", 170, 270);
    text("Starting Size", 170, 370);
    textSize(50);
    strokeWeight(10);
    stroke(1);
    line(100, 200, 500, 200);
    line(100, 170, 100, 230);
    line(300, 170, 300, 230);
    line(500, 170, 500, 230);
    line(100, 300, 500, 300);
    line(100, 400, 500, 400);
    fill(colorSet);
    circle(map(colorSet,0,255,100,500),300,25);
    circle(map(startSize,0,100,100,500),400,25);
    fill(0);
    //setting display
    if (setting == 1) {
      text("Easy", 230, 150);
      fill(255);
      circle(100, 200, 50);
    } else if (setting == 2) {
      text("Medium", 200, 150);
      fill(255);
      circle(300, 200, 50);
    } else if (setting == 3) {
      text("Hard", 230, 150);
      fill(255);
      circle(500, 200, 50);
    }
    noStroke();
    fill(255);
  } 
  //flip direction if wall
  if (by<50||by>450) {
    vby = vby*-1;
  }
  if (bx<50||bx>550) {
    vbx = vbx*-1;
  }
  //pausebutton
  fill(255);
  rect(0, 400, 100, 100);
  fill(0);
  rect(25, 425, 10, 50);
  rect(65, 425, 10, 50);
  fill(255);
}
void mouseReleased() {
  if (mouseX<100&&mouseY>400) {
    paused = !paused;
  } else if (mouseX>500&&mouseY>400 && size == 0) {
    inSettings = !inSettings;
  } else if (paused) {
    
  } else if (inSettings) {
    if(mouseX>100&&mouseX<200&&mouseY>170&&mouseY<230){
      setting = 1;
    }else if(mouseX>200&&mouseX<400&&mouseY>170&&mouseY<230){
      setting = 2;
    }else if(mouseX>400&&mouseX<500&&mouseY>170&&mouseY<230){
      setting = 3;
    }
  } else if (dist(mouseX, mouseY, bx, by) <= (startSize-size)/2&&!gameover) {
    size++;
    noStroke();
    rand = random(-PI,PI);
    bx = random(50, 550);
    by = random(50, 450);
    vbx = sin(rand) * size*setting/2;
    vby = cos(rand) * size*setting/2;
  } else if (!gameover) {
    score = size;
    gameover = true;
    if (highScore < score*setting){
      highScore = score*setting;
    }
  } else {
    background(0);
    gameover = false;
    score = 0;
    size = 0;
  }
}
void mouseDragged(){
  if(inSettings&&mouseX>100&&mouseX<500&&mouseY>270&&mouseY<330){
    colorSet = map(mouseX,100,500,0,255);
  }
  if(inSettings&&mouseX>100&&mouseX<500&&mouseY>370&&mouseY<430){
    startSize = map(mouseX,100,500,0,100);
  }
}
