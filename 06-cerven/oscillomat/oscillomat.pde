float time, start;

float offset = 0;
boolean sync = true;
float frag = 0;

float bars = 1.0;

ArrayList<Float> drawerx = new ArrayList<Float>();
ArrayList<Float> drawery = new ArrayList<Float>();
float headx = 0, heady = 0;

void setup() {
  size(displayWidth, displayHeight);
  textFont(createFont("Tahoma", 9));
  
  start = time = (second() + (minute() * 60) + (hour() * 3600));
}

void mousePressed(){
  drawerx.clear();
  drawery.clear();
  headx = 0;
  heady = 0;
  
  time = start;
  offset = 0;
  
  /* 
  if(sync){
    time = 0;
    offset = millis()/1000.0;
    sync = !sync;
  } else {
    time = start;
    offset = 0;
    sync = !sync;
  }
  */
}

void draw() {
  background(255);
  textAlign(CENTER);
  
  if(sync){
    text("sync", 540, 135);
  }
  
  pushMatrix();
  translate(135, 135);
  frag = time + (millis() / 1000.0) - offset;
  
  int i = 1;
  int cnt = 0;
  float x = 0, y = 0;
  float xx = 0, yy = 0;
  
  for(i = 45; i < 145; i++) {
    float bpm = i;
    float pulse = frag * (1000.0 / (60000.0 / bpm));
    
    pushMatrix();
    translate(x, y);
    
    cnt++;
    x += 40;
    if(cnt % 10 == 0) {
      x = 0;
      y += 40;
    }
    
    noStroke();
    float weight = pow(noise(x, y, millis() / 1000.0 * bpm / 120.0), 2);
    fill(255 - (weight * 255));
    text(bpm, 0, 4);
    ellipse(cos(pulse * TWO_PI) * 10, sin(pulse * TWO_PI) * 10, 5, 5);
    
    xx += cos(pulse * TWO_PI) * weight;
    yy += sin(pulse * TWO_PI) * weight;
    popMatrix();
  }
  
  headx += xx * 5.0;
  heady += yy * 5.0;
  
  drawerx.add(headx);
  drawery.add(heady);
  
  popMatrix();
  
  pushMatrix();
  translate(width / 2, height / 2);
  
  stroke(0, 75);
  noFill();
  beginShape();
  
  float lastx = 0, lasty = 0;
  for(i = 0; i < drawerx.size(); i++) {
    if(dist(drawerx.get(i), drawery.get(i), lastx, lasty) > 1) {
      curveVertex(drawerx.get(i), drawery.get(i));
    }
    
    lastx = drawerx.get(i);
    lasty = drawery.get(i);
    drawerx.set(i, drawerx.get(i) - (drawerx.get(i)) / 250.0);
    drawery.set(i, drawery.get(i) - (drawery.get(i)) / 250.0);
  }
  
  endShape();
  popMatrix();
}
