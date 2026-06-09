float test;
float modX;
float modY;
int t;
boolean cooldown;
boolean a;
boolean d;
boolean w;
boolean s;
int cd = 0;
int charge = 0;
float px;
float py;
float vx;
float vy;
int sl = 5;
void setup() {
  size(600, 600);
  test = 0;
  px = 500;
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
  playerActions();
  px = px+vx;
  py = py+vy;
  translate(300, 300);
  //image(d, -300, -300); //LAG HEAVY
  if (modX != 0) {
    test = atan(modY/modX);
  } else {
    t=-t;
  }
  //--------------Object Layer----------
  background(100);
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
  rect(-1000, -1000, 2000, 500);
  rect(-1000, -1000, 500, 2000);
  rect(500, -500, 500, 2000);
  rect(-500, 500, 2000, 500);
  popMatrix();
  //-----------------DARK COVER ----------------
  strokeWeight(5);
  stroke(0);
  fill(0);
  beginShape();
  vertex(cos(test)*10*t, sin(test)*10*t);
  vertex(cos(test-0.5)*500*t, sin(test-0.5)*500*t);
  vertex(cos(test-2)*1000*t, sin(test-2)*1000*t);
  vertex(cos(test+2)*1000*t, sin(test+2)*1000*t);
  vertex(cos(test+0.5)*500*t, sin(test+0.5)*500*t);
  endShape(CLOSE);
  //-------------- UI LAYER -----------------
  fill(0, 0, 0);
  stroke(100,0,0);
  circle(modX, modY, 1);
  stroke(0);
  circle(0, 0, 50);
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
  if (cd==0) {
    cd = 10;
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
