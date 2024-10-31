
int num = 50;
ArrayList neurons;
float R;
color barva;

void setup() {
  size(420, 595, OPENGL);

  frameRate(50);

  R = width / 3.0;

  neurons = new ArrayList();

  neurons.add(new Neuron(0, neurons));

  textFont(loadFont("Uni0553-8.vlw"), 8.0);


  for (int i = 1; i < num; i++) {
    neurons.add(new Neuron(i, neurons));
  }
}


void draw() {
  background(#222223);

  pushMatrix();
  translate(width/2, height/2);
  //rotate(-HALF_PI);



  for (int i = 0; i < neurons.size(); i++) {
    Neuron current = (Neuron)neurons.get(i);
    current.draw();
  }
  popMatrix();

  if (frameCount>60000)
    exit();

  saveFrame("/home/kof/kof17/render/######.tga");
}

class Neuron {
  ArrayList others, axons;

  int id;
  float x, y, angle;

  Neuron(int _id, ArrayList _others) {
    id=_id;
    others = _others;


    axons = new ArrayList();
    for (int i = 0; i < others.size(); i++) {
      Neuron tmp = (Neuron)others.get(i);
      axons.add(new Axon(this, tmp, 0.5));
    }
  }

  void tick() {
    angle = (TAU)*id/(num+0.0) + frameCount/(50.0*15.0) + (noise(id/(num+0.0), frameCount/2500.0, angle)*TAU/10.0);
    x = cos(angle)*R;
    y = sin(angle)*R;
  }

  void compute() {
    for (int i = 0; i < axons.size(); i++) {
      Axon tmp = (Axon)axons.get(i);
      tmp.w = ((sin( (frameCount) / 490.4 * TAU * ((id+1.0) /(num+0.0)) * (tmp.B.id-tmp.A.id) )) + 1.0)/5.0;
      //*(pow(id,map(atan2(tmp.B.y-tmp.A.y,tmp.B.x-tmp.A.x),-PI,PI,-1.0,1.0)) ) );
    }
  }

  void draw() {
    tick();
    compute();
    noStroke();
    fill(barva);
    //rect(x, y, 2, 2);
    //text("x"+id, x-3, y-4);

    for (int i = 0; i < axons.size(); i++) {
      Axon tmp = (Axon)axons.get(i);
      tmp.draw();
    }
  }
}

int cnt =0;

class Axon {
  Neuron A, B;
  float w, slope;

  Axon(Neuron _A, Neuron _B, float _w) {
    A = _A;
    B = _B;
    w = _w;
    slope = random(1, 99)/100.0 * sin(cnt++/num*TAU);
  }

  void draw() {

    barva = color(250);// lerpColor(lerpColor(color(#0f2403),color(#3d1500),pow(w,(A.y-B.y+A.x-B.x) ) ),color(#aec6fb), (1/slope)*w );
    stroke(barva, map(w, 0.0, 1.0, 0, 255.0));
    line(A.x, A.y, B.x, B.y);
    noStroke();
  }
}
