float test;
float modX;
float modY;
int t;
PImage d;
void setup() {
  size(600, 600);
  test = 0;
  d = loadImage("Darkness.png");
}

void draw() {
  background(100);
  modX = mouseX-300;
  modY = mouseY-300;
  if (mouseX<300) {
    t = -1;
  } else {
    t = 1;
  }
  translate(300, 300);
   //image(d, -300, -300); LAG HEAVY
  if (modX != 0) {
    test = atan(modY/modX);
  }
  strokeWeight(5);
  stroke(0);
  fill(0);
  beginShape();//DARK COVER ----------------
  vertex(cos(test)*10*t, sin(test)*10*t);
  vertex(cos(test-0.5)*500*t, sin(test-0.5)*500*t);
  vertex(cos(test-2)*1000*t, sin(test-2)*1000*t);
  vertex(cos(test+2)*1000*t, sin(test+2)*1000*t);
  vertex(cos(test+0.5)*500*t, sin(test+0.5)*500*t);
  endShape(CLOSE);
  //-------------- UI LAYER -----------------
  stroke(150, 50, 50);
  line(cos(test)*500*t, sin(test)*500*t, 0, 0);
}
