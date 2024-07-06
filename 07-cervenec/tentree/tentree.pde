

ArrayList seq;
float angles[] = {36.0,72.0,108.0,144.0,180.0,0.0,36.0,72.0,108.0,144.0,180.0,0.0};
float lens[] = {1.0,2.0,3.0,4.0,0.0,-1.0,-2.0,-3.0,4.0,0.0};

float siz = 10.0;

void setup(){
	size(1920,1080);

	seq = new ArrayList();

	for(int i = 0 ; i < 100 ; i++){
		int which = (int)random(10);
		seq.add(new PVector(angles[which],lens[which]));
	}

		background(255);

}


void draw(){

if(frameCount%1==0){
		int which = (int)random(10);
		seq.add(new PVector(angles[which],lens[which]));

	seq.remove(0);
	}


	stroke(0,15.0);

	translate(width/2,height/2);
	
	for(int i = 0 ; i < seq.size();i++){
		PVector current = (PVector)seq.get(i);
		float nois = noise((i+frameCount) / 1000.0)*10.0;
		rotate(radians(current.x));
		translate(0,current.y*siz+nois);
		line(0,0,0,-current.y*siz-nois);
				
	}
	
		
}
