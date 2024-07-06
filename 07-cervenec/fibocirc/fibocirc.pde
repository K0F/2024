

void setup(){
	size(420,420);
}


void draw(){

	background(255);
	float num = 4.0;

 float circumference = 10;  // Obvod kruhu
  float radius = circumference / TAU;
  
	float R = 159.1;
	float total = 0.0;
	float len = 0.0;

	for(float f = 0.0 ; f < num ; f += 1.0){
		len += f;
		float in = len / circumference * TAU;
		
		
		//arc(width/2,height/2,R,R,in,out);
		float x = cos(in)*R/2.0+width/2;
		float y = sin(in)*R/2.0+height/2;
		rect(x,y,2,2);
		
	}
}
