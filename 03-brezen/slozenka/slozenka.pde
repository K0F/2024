import processing.pdf.*;

PFont font;
PImage vzor;
boolean render = false;


void setup() {
  size(592, 283);

  vzor = loadImage("vzor.jpg");
  font = createFont("Calluna", 12);

  //exit();
}

void draw() {

  image(vzor, 0, 0, width, height);


  if (render) {
    beginRecord(PDF, "output.pdf");
    background(255);
  }

  fill(0);
  textFont(font);
  textSize(12);

  //textAlign(CENTER, CENTER);
  text("Hello, world!", width/2, height/2);
  if (render) {
    endRecord();
    render = false;
  }
}




class Slozenka {
  String arguments[];

  Slozenka(String[] args) {
    arguments = new String[args.length];
    for (int i= 0; i < arguments.length; i++) {
      arguments[i] = "" + args[i];
    }
  }
}
