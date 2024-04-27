int windowSize = 10; // Size of the input window
float[] data = new float[48000]; // Your time series data
int numHidden = 33; // Number of hidden neurons
float learningRate = 0.01; // Learning rate
int epochs = 1000000; // Number of training epochs
int printout = 10000;

// Neural network parameters
float[][] inputWeights;
float[] hiddenWeights;
float[] hiddenBiases;
float outputWeight;
float outputBias;

void setup() {
  size(400, 400);
println("initializing layers");
  initializeWeights();
  println("training");
  train();
}

void initializeWeights() {

// generate random data
for(int i = 0 ; i < data.length;i++){
	  data[i] = random(-100,100)/100.0;
}

  // Initialize input weights
  
  inputWeights = new float[windowSize][numHidden];
  for (int i = 0; i < windowSize; i++) {
    for (int j = 0; j < numHidden; j++) {
      inputWeights[i][j] = random(-1, 1);
    }
  }
  
  // Initialize hidden weights and biases
  hiddenWeights = new float[numHidden];
  hiddenBiases = new float[numHidden];
  for (int i = 0; i < numHidden; i++) {
    hiddenWeights[i] = random(-1, 1);
    hiddenBiases[i] = random(-1, 1);
  }
  
  // Initialize output weight and bias
  outputWeight = random(-1, 1);
  outputBias = random(-1, 1);
}

void train() {
  for (int epoch = 0; epoch < epochs; epoch++) {
  	float totalError = 0;
    for (int i = windowSize; i < data.length - 1; i++) {
      // Prepare input window
      float[] inputWindow = new float[windowSize];
      for (int j = 0; j < windowSize; j++) {
        inputWindow[j] = data[i - windowSize + j];
      }
      
      // Forward pass
      float[] hiddenLayer = new float[numHidden];
      for (int j = 0; j < numHidden; j++) {
        float sum = 0;
        for (int k = 0; k < windowSize; k++) {
          sum += inputWindow[k] * inputWeights[k][j];
        }
        hiddenLayer[j] = sigmoid(sum + hiddenBiases[j] );
      }
      
      float output = 0;
      for (int j = 0; j < numHidden; j++) {
        output += hiddenLayer[j] * hiddenWeights[j] ;
      }
      output = sigmoid(output + outputBias);
      
      // Backpropagation
      float target = data[i + 1]; // Next value in the series
      float error = target - output;
      totalError += abs(target - output);

          
      
      // Update output layer weights and bias
      float deltaOutput = error * dsigmoid(output);
      for (int j = 0; j < numHidden; j++) {
        hiddenWeights[j] += learningRate * deltaOutput * hiddenLayer[j] ;
      }
      outputBias += learningRate * deltaOutput;
      
      // Update hidden layer weights and biases
      for (int j = 0; j < numHidden; j++) {
        float deltaHidden = hiddenWeights[j] * deltaOutput * dsigmoid(hiddenLayer[j]);
        for (int k = 0; k < windowSize; k++) {
          inputWeights[k][j] += learningRate * deltaHidden * inputWindow[k] ;
        }
        hiddenBiases[j] += learningRate * deltaHidden;
      }
      
    }

          if (epoch % printout == 0) { // Print every 10 epochs (adjust as needed)
            float averageError = totalError / (data.length - windowSize - 1);
            println("Epoch " + epoch + ", Average Error: " + averageError);
            stroke(0);
            point(map(epoch,0,data.length,0,width),map(averageError,0,1,height,0));
          }
    
  }//end epoch
}

float predict(float[] input) {
  // Forward pass
  float[] hiddenLayer = new float[numHidden];
  for (int j = 0; j < numHidden; j++) {
    float sum = 0;
    for (int k = 0; k < windowSize; k++) {
      sum += input[k] * inputWeights[k][j];
    }
    hiddenLayer[j] = sigmoid(sum + hiddenBiases[j]);
  }
  
  float output = 0;
  for (int j = 0; j < numHidden; j++) {
    output += hiddenLayer[j] * hiddenWeights[j];
  }
  output = sigmoid(output + outputBias);
  
  return output;
}

float sigmoid(float x) {
  return 1 / (1 + exp(-x));
}

float dsigmoid(float x) {
  return x * (1 - x);
}
