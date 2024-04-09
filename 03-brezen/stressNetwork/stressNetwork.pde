

ArrayList neurons;

void setup(){
  size(320,230);
  neurons = new ArrayList();

  for(int i = 0 ; i < numNeurons;i++){

  }
}


void draw(){

}

class Connection{
	float weight;
}

class Neuron{
	ArrayList connections;
	int id;
	float value;

	Neuron(int _id){
		id = _id;
	}

	float activation(float input){
		return 1 / ( 1 + exp(-input) );
	}	
}
