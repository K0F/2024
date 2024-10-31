

void setup(){
	size(480,480);
}


void draw(){
	println(harmo(1,1.2,20));
}


float[] harmo(float in,float slope,int lim){
	float[] result = new float[lim];
	float last = in;
	float len = lim;
	
	while(lim>0){
		last = pow(result.length-lim/len+1,2);
		result[result.length-lim] = last;
		lim--;
	}

	return result;
}
