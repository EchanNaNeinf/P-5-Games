char gameState = 'm';
float mom1 = 0;
float pos1 = 200;
float ballX = 200;
float ballY = 300;
float vx = 0;
float vy = 2;
int score1 = 0;
int timer = 120;
boolean a = false;
boolean d = false;
boolean p = false;
boolean[][] g = {
  {false, false, false, false, false, false, false, false, false},
  {false, false, false, false, false, false, false, false, false},
  {false, false, false, false, false, false, false, false, false},
  {false, false, false, false, false, false, false, false, false},
  {false, false, false, false, false, false, false, false, false},
  {false, false, false, false, false, false, false, false, false},
  {false, false, false, false, false, false, false, false, false},
  {false, false, false, false, false, false, false, false, false}, };
void setup() {
  size(400, 600);
}

void draw() {
  fill(0);
  if (gameState == 'm') {
    background(255);
    textSize(50);
    text("Welcome to", 50, 150);
    text("Breakout.", 100, 200);
    text("Click to continue.", 10, 250);
  } else if (gameState == '1') {
    background(100);
    fill(255);
    stroke(255);
    stroke(0);
    text(score1, 200, 40);
    fill(100, 200, 100);
    circle(pos1, 600, 100);
    fill(50, 50, 50);
    fill(255);
    circle(ballX, ballY, 50);
    for (int i = 0; i < 5; i++) {
      for (int j = 0; j < 9; j++) {
        if (!g[i][j]) {
          circle(j*45+25, i*45+75, 30);
        }
      }
    }
    if (!p) {
      pos1 = pos1 + mom1;
      ballX = ballX + vx;
      ballY = ballY + vy;
      //movement controls
      player1();
      ballCollision();
    } else if (gameState == 'o') {
      background(0);
      fill(255);
      text("Score: "+score1, 100, 200);
      text("Click to return to Home.", 100, 200);
    }
    if (p&&(gameState == '1')) {
      text("Paused.", 200, 300);
    }
  }
}
void player1() {
  if (a) {
    mom1 = mom1-2;
  } else if (d) {
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
}
void ballCollision() {
  if (dist(ballX, ballY, pos1, 600)<75) {
    vx = (ballX-pos1)/20+mom1;
    vy = (ballY-600)/20-vx/4;
  }
  for (int i = 0; i < 5; i++) {
    for (int j = 0; j < 9; j++) {
      if (!g[i][j] && dist(ballX, ballY, j*45+25, i*45+75)<40) {
        vx = (ballX-j*45-25)/10;
        vy = (ballY-i*45-50)/10-vx/4;
        g[i][j] = true;
      }
    }
  }

  if (ballY < 25) {
    vy = -vy;
    ballY = 25;
  }
  if (ballX < 25 || ballX > 375) {
    vx = -vx;
    if (ballX < 25) {
      ballX = 25;
    } else {
      ballX = 375;
    }
  }
  for (int i = 0; i > 4; i++) {
    for (int j = 0; j > 5; j++) {
      if (g[i][j] == false) {
        g[i][j] = true;
        score1++;
      }
    }
  }
  if (ballY > 800) {
    vy = 0;
    vx = 0;
    ballX = 200;
    ballY = 300;
  }
}
void mouseReleased() {
  if (gameState == 'm') {
    gameState = '1';
  } else if (gameState == 'o') {
    gameState = 'm';
  }
}
void keyPressed() {
  if (key == 'a') {
    a = true;
  }
  if (key == 'd') {
    d = true;
  }
}
void keyReleased() {
  if (key == 'a') {
    a = false;
  }
  if (key == 'd') {
    d = false;
  }
  if (key == 'p') {
    p = !p;
  }
}
