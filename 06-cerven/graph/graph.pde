import oscP5.*;
import netP5.*;
import java.util.Date;
import java.util.Calendar;

OscP5 oscP5;

void setup() {
  size(400,400,P2D);
  frameRate(60);
  oscP5 = new OscP5(this,10000);
  vals = new ArrayList(0);
r = b =0;
}

ArrayList vals;

float r,b;

void draw() {
  r += (((sin(val*10.0*TAU)+1.0)*128)-r)/20.0;
  b += (((sin(millis()/1000.0*TAU)+1.0)*128)-b)/20.0;

vals.add(r);
      if(vals.size()>width)
      vals.remove(0);

      if(gotnew){
  background( r,b,b) ;
  gotnew = false;
  }else{
  background(0);
  }
  
//  String tt = timestampToString(t);
  fill(255-r,255-b,255-b);
  noStroke();
  textAlign(CENTER);
  text((int)t,width/2,height/2+3);

  stroke(255-b);
  noFill();
  beginShape();
  for(int i = 0; i < vals.size();i++){
  	float tmp = map((Float)vals.get(i),255,0,height,0);
  	vertex(i,tmp);
  }
  endShape();
}

double t;
float val;
boolean gotnew;

void oscEvent(OscMessage theOscMessage) {  
    if(theOscMessage.checkTypetag("diiiff")) {
      t = (theOscMessage.get(0).doubleValue());  
      val = (float)theOscMessage.get(5).floatValue();
		gotnew = true;
      return;    
  }
}

