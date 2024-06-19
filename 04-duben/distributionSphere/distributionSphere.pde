
ArrayList pnts;
ArrayList uvs;

int radius = 205;
int num = 10;

PVector getRandomPointOnSphere(float _radius) {
  float u = random(0, TWO_PI);
  float v = random(0, PI);
  
  float x = _radius * sin(v) * cos(u);
  float y = _radius * sin(v) * sin(u);
  float z = _radius * cos(v);
  
  return new PVector(x, y, z);
}


PVector projectUV(float _u, float _v) {

  float u = map(_u,0,360,0, TWO_PI);
  float v = map(_v,0,360,0, PI);
  
  float x = radius * sin(v) * cos(u);
  float y = radius * sin(v) * sin(u);
  float z = radius * cos(v);
  
  return new PVector(x, y, z);
}


void regen(){
	pnts = new ArrayList();
	uvs = new ArrayList();

	for(int i = 0 ; i < num; i ++){
	PVector p = new PVector(random(360),random(360));

	uvs.add(p);
	pnts.add(projectUV(p.x,p.y));

	}
}


void align(){
	
	for(int i = 0 ; i < num; i ++){

	PVector tmpuv1 = (PVector)uvs.get(i);

		for(int ii = 0 ; ii < num; ii++){


		PVector tmpuv2 = (PVector)uvs.get(ii);

		if(i!=ii){
			PVector p1 = (PVector)pnts.get(i);
			PVector p2 = (PVector)pnts.get(ii);

			
			float d = dist(tmpuv1.x,tmpuv1.y,tmpuv2.x,tmpuv2.y)+0.1;
			float d2 = dist(tmpuv1.x,tmpuv1.y,180,180) + 0.1;

			tmpuv1.x -= (tmpuv2.x-tmpuv1.x)/d;
			tmpuv1.y -= (tmpuv2.y-tmpuv1.y)/d;


			

			tmpuv1.x += (180-tmpuv1.x)/d;
			tmpuv1.y += (180-tmpuv1.y)/d;


						
			p1 = projectUV(tmpuv1.x,tmpuv1.y);
			pnts.set(i,p1);
							
		}

		}
	}

}

void setup(){
	size(474/6*7,474,P3D);
    ortho();
    regen();

    trace = new ArrayList();
}

ArrayList trace;

void draw(){
background(255);
	noFill();

	//regen();
	align();
	stroke(0,120);
	pushMatrix();
	translate(width/2,height/2,0);
	rotateY( (frameCount/360.0)*TAU );
	strokeWeight(10);

	for(int i = 0 ; i < pnts.size(); i++){
		PVector uv = (PVector)uvs.get(i);
		PVector point = (PVector)pnts.get(i);

	//	point(uv.x,uv.y);

		pushMatrix();
		translate(point.x,point.y,point.z);

		if(i==0) //i==((frameCount/360) %pnts.size()))
		trace.add(new PVector(point.x,point.y,point.z));

		point(0,0,0);
		popMatrix();
		
	}

noFill();
stroke(128,60);
	beginShape();
	for(int i = 0 ; i < trace.size(); i++){
		PVector tmp = (PVector)trace.get(i); 

	//	float phase = sin((frameCount+i)/360.0*TAU)*10.0;
		vertex(tmp.x,tmp.y,tmp.z);


		
		}
		endShape();

popMatrix();


	
}
