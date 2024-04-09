


void setup(){

	size(1400,400);
	background(#ffffff);
}

float x = -400;

void draw(){
stroke(#222222,128);
    x += 4;
	arc(x,0,800,800,HALF_PI,PI);

if(x>width+400){
	save("bck.png");
	exit();
}
}

