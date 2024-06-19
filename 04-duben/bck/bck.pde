


void setup(){

	size(1600,400);
	background(#ffffff);
}

float x1 = -400;
float x2 = -400;
float x3 = -400;

void draw(){
stroke(#222222,32);
noFill();
    x1 += 4;
	arc(x1,0,height*2,height*2,HALF_PI,PI);

x2 += 5;
	arc(x2,0,height*2,height*2,HALF_PI,PI);


x3 += 6;
	arc(x3,0,height*2,height*2,HALF_PI,PI);


if(x1>width+400){
	save("bck.png");
	exit();
}
}

