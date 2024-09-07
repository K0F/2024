
import oscP5.*;
import netP5.*;


// receiving port

int PORT = 9000;


// 17:10
// this should be perceptually nice one and hard to compute in many cases
// it is a measure from tip of thumb to index finger (right angle in between)
// 1500x900
// 1200x720
// 1800x1080

// all nice 3:7 would do better I feel ...
// 700x300
// 1400x600
// 2100x900



int LIMIT = 1000;
ArrayList graph, touch;
OscP5 oscP5;


float  sc = 2;
float rot = 0;
Graph tmp;

void setup() {
  size(700, 300, OPENGL);	
  oscP5 = new OscP5(this, PORT);
  graph = new ArrayList();

  touch = new ArrayList();
}

int cnt = 0;
float X;

// Funkce, která zpracuje příchozí OSC zprávy
void oscEvent(OscMessage msg) {
  if (msg.checkAddrPattern("/rotationvector") == true) {
    float x = msg.get(0).floatValue();  //x
    float y = msg.get(1).floatValue();  //y
    float z = msg.get(2).floatValue();  //z
    float xx = msg.get(3).floatValue();  //xx
    float yy = msg.get(4).floatValue();  //yy


    // println("Rotation Vector: ", x, y, z, xx, yy, X);
    graph.add(new Graph(x, y, z, xx, yy, X));

    if (graph.size()>LIMIT)
      graph.remove(0);
    //println("Extra Value: ", extra);
  }

  if (msg.checkAddrPattern("/touch1") == true) {
    float x = msg.get(0).floatValue();  //x
    float y = msg.get(1).floatValue();  //y


    //println("Touch Vector: ", x, y);
    touch.add(new Touch(x, 1-y));

    if (x==-1.0 && y==-1.0)
      touch = new ArrayList();
    //println("Extra Value: ", extra);
  }
}

void draw() {
  background(0);
  stroke(255, 90);
  X = sin(millis()/60000.0*TAU)*(width/2.0)+(width/2.0);

  line(X, 0, X, height);
  noFill();


  pushMatrix();
  //translate(width/2,height/2);

  if (graph.size()>0) {
    tmp = (Graph)graph.get(graph.size()-1);
    rot = tmp.y*TAU;
  }
  //rotate(rot);

  stroke(255, 0, 0);
  beginShape();
  for (int ii = 0; ii < graph.size(); ii++) {
    tmp = (Graph)graph.get(ii);
    vertex(tmp.X, map(tmp.x, -sc, sc, height, 0));
  }
  endShape();


  stroke(0, 255, 0);
  beginShape();
  for (int ii = 0; ii < graph.size(); ii++) {
    tmp = (Graph)graph.get(ii);
    vertex(tmp.X, map(tmp.y, -sc, sc, height, 0));
  }
  endShape();


  stroke(0, 0, 255);
  beginShape();
  for (int ii = 0; ii < graph.size(); ii++) {
    tmp = (Graph)graph.get(ii);
    vertex(tmp.X, map(tmp.z, -sc, sc, height, 0));
  }
  endShape();


  stroke(255);
  beginShape();
  for (int ii = 0; ii < graph.size(); ii++) {
    tmp = (Graph)graph.get(ii);
    vertex(tmp.X, map(tmp.yy+tmp.xx, -sc, sc, height, 0));
  }
  endShape();



  stroke(255);
  beginShape();
  for (int ii = 0; ii < touch.size(); ii++) {
    Touch tmp2 = (Touch)touch.get(ii);
    vertex(map(tmp2.x, 0, 1, 0, width), map(tmp2.y, 0, 1, 0, width));
  }
  endShape();

  popMatrix();
}

class Graph {
  int id;
  float x, y, z, xx, yy, X;

  Graph(float _x, float _y, float _z, float _xx, float _yy, float _X) {
    x=_x;
    y=_y;
    z=_z;
    xx=_x;
    yy=_y;
    X=_X;
  }
}


class Touch {
  int id;
  float x, y;

  Touch(float _x, float _y) {
    x=_x;
    y=_y;
  }
}
