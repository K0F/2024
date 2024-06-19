

float parts1 = 36.0;
float diameter1 = 200.0;


float parts2 = 24.0;
float diameter2 = 175.0;


float parts3 = 12.0;
float diameter3 = 150.0;
float time;

void setup(){

	size(480,480);
	//println(PFont.list());
	textFont(createFont("URWGothic-Book",16,true));
	
	time = (second()+(minute()*60)+(hour()*3600))/86400.0;
	
}




void draw(){

	background(255);
textAlign(CENTER);
	fill(0);
	stroke(0,120);

	pushMatrix();
	translate(width/2,height/2);
	float frag = time + (millis()/1000.0/86400.0);
	line(0,0,0,-height/2);
	rotate(-frag*TAU);
	for(int i = 0 ; i < parts1;i++){
		pushMatrix();
		rotate(i/parts1*TAU);
		translate(0,-diameter1);
		line(0,5,0,10);
		text(i,0,0);
		popMatrix();
	}
	fill(#ff1111);
	for(int i = 0 ; i < parts2;i++){
			pushMatrix();
			rotate(i/parts2*TAU);
			translate(0,-diameter2);
			text(i,0,0);
			line(0,4,0,10);
			popMatrix();
		}
	fill(#ffcc11);
	for(int i = 0 ; i < parts3;i++){
			pushMatrix();
			rotate(i/parts3*TAU);
			translate(0,-diameter3);
			text(i,0,0);
			line(0,3,0,10);
			popMatrix();
		}
	popMatrix();


	fill(0,200);
textAlign(LEFT);
//	  text((frag * 360.0).toFixed(3)  + "˚\n"+ (frag*1000.0).toFixed(3)+"/1000\n"+(frag).toFixed(9)+" frag", width / 2 - 25, height / 2 + 20);
	text(frag*360.0+"˚ ",width/2-25,height/2+20);
}
