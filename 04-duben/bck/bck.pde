


void setup(){

	size(975,180);
	background(#ffffff);
}

float x = -400;

void draw(){
stroke(#222222,128);
    x += 4;
	arc(x,0,height*2,height*2,HALF_PI,PI);

if(x>width+400){
	save("bck.png");
	exit();
}
}

