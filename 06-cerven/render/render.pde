
void setup(){
	size(1920,1080,P2D);
	textFont(createFont("Semplice Regular",8));
}



void draw(){
	background(4);
	stroke(255,15);
	
	fill(255,120);
	for(int i = 0;i<1000;i++){
		float x = (noise((i+frameCount)/100.0 )-0.5)*800.0+sin( (i+frameCount)/10000.0*TAU)*10.0+width/2; 
		line(x,height/2-20,x,height/2+20);
		if(i%100==0){
			text(i,x,height/2+32);
		}
	}
	noStroke();
	text("iteration @"+nf(frameCount,5),width/2,height/2-25);

	saveFrame("it_#####.png");
	if(frameCount>3600)
	exit();
}
