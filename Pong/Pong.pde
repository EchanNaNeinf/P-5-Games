char gameState = 'm';
int mom1 = 0;
int pos1 = 100;
int mom2 = 0;
int pos2 = 100;
boolean w = false;
boolean s = false;
boolean i = false;
boolean k = false;
void setup() {
  size(600, 400);
}

void draw() {
  fill(0);
  if (gameState == 'm') {
    background(255);
    textSize(50);
    text("Welcome to Pong.", 100, 50);
    text("Press Play to continue.", 100, 100);
    fill(255);
    if (mouseX > 200 && mouseX < 400 && mouseY > 200 && mouseY < 300) {
      strokeWeight(10);
    }
    rect(200, 200, 200, 100);
    strokeWeight(5);
    fill(0);
    text("Play", 250, 265);
  } else if (gameState == 'p') {
    background(200);
  } else if (gameState == '1') {
    background(100);
    pos1 = pos1 + mom1;
    circle(100, pos1, 100);
    circle(500, pos2, 100);
    //movement controls
    if (w) {
      mom1 = mom1-2;
    } else if (s) {
      mom1 = mom1+2;
    }
    if (i) {
      mom2 = mom2-2;
    } else if (k) {
      mom2 = mom2+2;
    }
    //friction
    if (mom1 != 0) {
      if (mom1 > 0) {
        mom1--;
      } else {
        mom1++;
      }
    }
    if (mom2 != 0) {
      if (mom2 > 0) {
        mom2--;
      } else {
        mom2++;
      }
    }
    //bounce off edge
    if (pos1 < 50 || pos1 > 350) {
      mom1 = -mom1;
      if (pos1 < 50) {
        pos1 = 50;
      } else {
        pos1 = 350;
      }
    }
    if (pos2 < 50 || pos2 > 350) {
      mom2 = -mom2;
      if (pos2 < 50) {
        pos2 = 50;
      } else {
        pos2 = 350;
      }
    }

  } else if (gameState == 'o') {
    background(0);
  }
}
void mouseReleased() {
  if (mouseX > 200 && mouseX < 400 && mouseY > 200 && mouseY < 300 && gameState == 'm') {
    gameState = '1';
  }
}
void mouseDragged() {
}
void keyPressed() {
  if (key == 'w') {
    w = true;
  }
  if (key == 's') {
    s = true;
  }
  if (key == 'i') {
    i = true;
  }
  if (key == 'k') {
    k = true;
  }
}
void keyReleased() {
  if (key == 'w') {
    w = false;
  }
  if (key == 's') {
    s = false;
  }
  if (key == 'i') {
    i = false;
  }
  if (key == 'k') {
    k = false;
  }
}
