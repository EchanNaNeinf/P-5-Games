char gameState = 'm';
float mom1 = 0;
float pos1 = 200;
float mom2 = 0;
float pos2 = 200;
float ballX = 300;
float ballY = 200;
float vx = 0;
float vy = 0;
int score1 = 0;
int score2 = 0;
int timer = 120;
boolean w = false;
boolean s = false;
boolean i = false;
boolean k = false;
boolean p = false;
void setup() {
  size(600, 400);
}

void draw() {
  fill(0);
  if (gameState == 'm') {
    background(255);
    textSize(50);
    text("Welcome to Pong.", 100, 50);
    text("Choose a mode to continue.", 10, 100);
    fill(255);
    strokeWeight(5);
    if (mouseX > 100 && mouseX < 300 && mouseY > 200 && mouseY < 300) {
      strokeWeight(10);
    }
    rect(100, 200, 200, 100);
    strokeWeight(5);
    if (mouseX > 300 && mouseX < 500 && mouseY > 200 && mouseY < 300) {
      strokeWeight(10);
    }
    rect(300, 200, 200, 100);
    strokeWeight(5);
    fill(0);
    text("1 Player 2 Players", 125, 265);
  } else if (gameState == '1') {
    background(100);
    fill(255);
    stroke(255);
    line(300, 0, 300, 400);
    stroke(0);
    text(score1, 200, 40);
    text(score2, 400, 40);
    pos1 = pos1 + mom1;
    pos2 = pos2 + mom2;
    ballX = ballX + vx;
    ballY = ballY + vy;
    fill(100, 200, 100);
    circle(100, pos1, 100);
    fill(50, 50, 50);
    circle(500, pos2, 100);
    fill(255);
    circle(ballX, ballY, 50);
    ballX = ballX + vx;
    ballY = ballY + vy;
    //movement controls
    player1();
    ballCollision();
    //AI movement
    if (pos2>ballY+75) {
      mom2 = mom2-1.5;
    } else if (pos2<ballY-75) {
      mom2 = mom2+1.5;
    }
    if (mom2 != 0) {
      if (mom2 > 0) {
        mom2--;
      } else {
        mom2++;
      }
    }
  } else if (gameState == '2') {
    background(100);
    fill(255);
    stroke(255);
    line(300, 0, 300, 400);
    stroke(0);
    text(score1, 200, 40);
    text(score2, 400, 40);
    pos1 = pos1 + mom1;
    pos2 = pos2 + mom2;
    ballX = ballX + vx;
    ballY = ballY + vy;
    fill(100, 200, 100);
    circle(100, pos1, 100);
    fill(200, 100, 100);
    circle(500, pos2, 100);
    fill(255);
    circle(ballX, ballY, 50);
    //movement controls
    player1();
    ballCollision();
    if (i) {
      mom2 = mom2-2;
    } else if (k) {
      mom2 = mom2+2;
    }
    //friction
    if (mom2 != 0) {
      if (mom2 > 0) {
        mom2--;
      } else {
        mom2++;
      }
    }
    //bounce off edge
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
void player1() {
  if (w) {
    mom1 = mom1-2;
  } else if (s) {
    mom1 = mom1+2;
  }
  //friction
  if (mom1 != 0) {
    if (mom1 > 0) {
      mom1--;
    } else {
      mom1++;
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
}
void ballCollision() {
  if (dist(ballX, ballY, 100, pos1)<75) {
    vx = (ballX-100)/20-vx/4;
    vy = (ballY-pos1)/10+mom1;
  }
  if (dist(ballX, ballY, 500, pos2)<75) {
    vx = (ballX-500)/20-vx/4;
    vy = (ballY-pos2)/10+mom2;
  }
  if (ballY < 25 || ballY > 375) {
    vy = -vy;
    if (ballY < 25) {
      ballY = 25;
    } else {
      ballY = 375;
    }
  }
  if (ballX < 0 || ballX > 600 || timer != 0) {
    if (timer == 0) {
      timer = 100;
      if (ballX < 0) {
        score2++;
      } else if (ballX > 0) {
        score1++;
      }
    } else if (timer == 1) {
      ballX = 300;
      ballY = 200;
      if (score1 > score2) {
        vx = 2;
      } else {
        vx = -2;
      }
      vy = random(-3, 3);
      timer--;
    } else {
      timer--;
    }
  }
}
void mouseReleased() {
  if (mouseX > 100 && mouseX < 300 && mouseY > 200 && mouseY < 300 && gameState == 'm') {
    gameState = '1';
  } else if (mouseX > 300 && mouseX < 500 && mouseY > 200 && mouseY < 300 && gameState == 'm') {
    gameState = '2';
  }
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
  if (key == 'p'){
    p = true;
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
  if (key == 'p'){
    p = false;
  }
}
