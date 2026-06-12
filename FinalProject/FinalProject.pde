float test;
float modX;
float modY;
int t, t1, e = 1;
boolean cooldown;
boolean a;
boolean d;
boolean w;
boolean s;
int activated = 1;
int cd = 0;
int charge = 100;
int recharge = 0;
float px, py, vx, vy;
float ex, ey, test1;
int sl = 5;
void setup() {
  size(600, 600);
  test = 0;
  px = 50;
  py = 0;
  vx = 0;
  vy = 0;
}

void draw() {
  //---------SETUP / ACTIONS ---------
  modX = mouseX-300;
  modY = mouseY-300;
  if (mouseX<300) {
    t = -1;
  } else {
    t = 1;
  }
  if (recharge != 0) {
    recharge--;
  } else if (charge < 100) {
    charge++;
  }
  if (cd == 0 && activated == 1) {
    enemyActions();
  }
  playerActions();
  px = px+vx;
  py = py+vy;
  translate(300, 300);
  //image(d, -300, -300); //LAG HEAVY
  if (modX != 0) {//rise over run stuff
    test = atan(modY/modX);
  }
  if (ex != 0) {//rise over run stuff
    test1 = atan(ey/ex);
  }
  //--------------Object Layer----------
  background(100);
  //translate(-modX/50,(-modY/50));
  if (cd!=0) {
    fill(255, 255, 255, map(cd, 0, 8, 0, 255));
    beginShape();
    vertex(cos(test)*10*t, sin(test)*10*t);
    vertex(cos(test-0.5)*500*t, sin(test-0.5)*500*t);
    vertex(cos(test+0.5)*500*t, sin(test+0.5)*500*t);
    endShape(CLOSE);
    cd--;
  }
  pushMatrix();
  translate(-px, -py);
  stroke(0);
  fill(0);
  circle(ex, ey, 100);
  rect(-1000, -1000, 2000, 500);
  rect(-1000, -1000, 500, 2000);
  rect(500, -500, 500, 2000);
  rect(-500, 500, 2000, 500);
  popMatrix();
  //-----------------DARK COVER ----------------
  strokeWeight(5);
  noStroke();
  fill(0, 230);
  beginShape();
  vertex(cos(test)*10*t, sin(test)*10*t);
  vertex(cos(test-0.5)*500*t, sin(test-0.5)*500*t);
  vertex(cos(test-2)*1000*t, sin(test-2)*1000*t);
  vertex(cos(test+2)*1000*t, sin(test+2)*1000*t);
  vertex(cos(test+0.5)*500*t, sin(test+0.5)*500*t);
  endShape(CLOSE);
  fill(0, 130);
  if (cd == 0) {
    beginShape();
    vertex(cos(test)*10*t, sin(test)*10*t);
    vertex(cos(test-0.5)*500*t, sin(test-0.5)*500*t);
    vertex(cos(test+0.5)*500*t, sin(test+0.5)*500*t);
    endShape(CLOSE);
  }
  //-------------- UI LAYER -----------------
  fill(0, 0, 0);
  stroke(100, 0, 0);
  circle(modX, modY, 1);
  stroke(0);
  rect(200, 125, 75, 100);
  fill(120, 100, 85);
  circle(0, 0, 50);
  fill(80, 80, 80);
  beginShape();
  vertex(cos(test-0.5)*20*t, sin(test-0.5)*20*t);
  vertex(cos(test+0.5)*20*t, sin(test+0.5)*20*t);
  vertex(cos(test+0.5)*50*t, sin(test+0.5)*50*t);
  vertex(cos(test-0.5)*50*t, sin(test-0.5)*50*t);
  endShape(CLOSE);
  fill(255);
  rect(200, 225, 75, -charge);
  rect(225, 115, 25, 10);
}
void enemyActions() {
  if (px > ex) {
    ex = ex+0.3;
  } else if (px < ex) {
    ex = ex-0.3;
  }
  if (py > ey) {
    ey = ey+0.3;
  } else if (py < ey) {
    ey = ey-0.3;
  }
}
void playerActions() {
  if (a && vx > -sl) {
    vx = vx-0.3;
  } else if (d && vx < sl) {
    vx = vx+0.3;
  }
  if (w && vy > -sl) {
    vy = vy-0.3;
  } else if (s && vy < sl) {
    vy = vy+0.3;
  }
  //friction
  if (vx != 0) {
    if (vx > 0.2) {
      vx=vx-0.2;
    } else if (vx < -0.2) {
      vx=vx+0.2;
    } else {
      vx = 0;
    }
  }
  if (vy != 0) {
    if (vy > 0.2) {
      vy=vy-0.2;
    } else if (vy < -0.2) {
      vy=vy+0.2;
    } else {
      vy = 0;
    }
  }
  //bounce
  if (px < -475 || px > 475) {
    px = -px;
    if (px < -400) {
      px = 475;
    } else {
      px = -475;
    }
  }
  if (py < -475 || py > 475) {
    py = -py;
    if (py < -400) {
      py = 475;
    } else {
      py = -475;
    }
  }
}
void mouseClicked() {
  for (int i = 0; i < 10; i++) {//detection
    if (dist(-ex, -ey, 10*i, test1*i*10) < 100) {
      activated = 2;
    }
    print(dist(-ex, -ey, 10*i, test1*i*10) + "   ");
  }
  if (activated == 1) {
    activated = 0;
  } else if (activated == 2) {
    activated = 1;
  }
  if (cd==0 && charge >= 20 ) {
    cd = 10;
    vx = 0;
    vy = 0;
    charge = charge-20;
    recharge = 100;
  }
}
void keyPressed() {
  if (key == 'a') {
    a = true;
  } else if (key == 'd') {
    d = true;
  }
  if (key == 'w') {
    w = true;
  } else if (key == 's') {
    s = true;
  }
}
void keyReleased() {
  if (key == 'a') {
    a = false;
  } else if (key == 'd') {
    d = false;
  }
  if (key == 'w') {
    w = false;
  } else if (key == 's') {
    s = false;
  }
}
