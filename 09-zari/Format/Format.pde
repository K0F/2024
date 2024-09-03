

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

void setup(){
	size(700,300);	
}

void draw(){
	background(0);
	stroke(255,90);
	float x = sin(frameCount/600.0*TAU)*(width/2.0)+(width/2.0);
	line(x,0,x,height);
}
