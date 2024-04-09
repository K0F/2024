void setup(){
  size(1280,640,P2D);
}


void draw(){
  background(0);
  
  stroke(255,12);
  for(int i = 0 ; i < 1000;i++){
  float x = noise((millis()+i*10.0)/30000.0*TAU)*width;
  
    line(x,0,x,height);
  }
  
}
