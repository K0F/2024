int windowSize = 72; // Size of the input window
float[] data = new float[144]; // Your time series data
int numHidden = 72; // Number of hidden neurons
float learningRate = 0.0001; // Learning rate
int epochs = 1000000; // Number of training epochs
int printout = 10;

boolean trained = false;

String stat = "";
PFont font;

// number of threads
int noThreads = 1;

// Neural network parameters
float[][] inputWeights;
float[] hiddenWeights;
float[] hiddenBiases;
float outputWeight;
float outputBias;

void setup() {
  size(720, 384);

	font = createFont("Semplice Regular",6,false);
  
  println("initializing layers");
  generateRandomData();

  initializeWeights();
  println("training");
  for(int i = 0 ; i < noThreads;i++)
  thread("train");
}

void keyPressed() {
  generateRandomData();
}

void generateRandomData() {
  //noiseSeed(int(random(1, 10000)));
  //float scale = random(10, 100);
  // generate random data
  for (int i = 0; i < data.length; i++) {
    data[i] = (noise( (i+frameCount)/100.0)-0.5)*2.0;
  }
}


float original[] = new float[data.length];
float predicted[] = new float[data.length];

void draw() {

  if (trained) {
  }

  //if (frameCount%1200==0) {
    generateRandomData();
    original = new float[data.length];
    for (int i = 0; i < data.length; i++) {
      original[i] = data[i];
    }
//	}

  

	
    predicted = predictNFields(original, original.length);
    for (int i = 0; i < predicted.length; i++) {
      original[i] = predicted[i];
    }

  background(255);
fill(0);

  text(stat,10,14);
  
  noFill();

  beginShape();
  for (int i = 0; i < data.length; i++) {
    stroke(0);
    vertex(map(i, 0, data.length, 0, width/2), map(data[i], -1, 1, height, 0));
  }
  endShape();


  beginShape();
  for (int i = 0; i < predicted.length; i++) {
    stroke(#ff0000);
    vertex(map(i, 0, predicted.length, width/2, width), map(predicted[i], -1, 1, height, 0));
  }
  endShape();

  saveImg();
}

void saveImg(){
	saveFrame("frameCount_#####.png");
}


void initializeWeights() {


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

  float prevTotalError = 0;

  for (int epoch = 0; epoch < epochs; epoch++) {
    // windowSize = int(random(5,24));

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
stat = "Epoch: " + epoch + ", Average Error: " + averageError+ ", Accuracy: "+ (1.0-averageError)*100.0 + "%" + ", Slope: " + (((1.0-averageError)*100.0-prevTotalError))+"%";
      println(stat);
      prevTotalError = (1.0-averageError)*100.0;
    }
  }//end epoch

  trained = true;
}

float[] expandArray(float[] arr) {
  float[] newArr = new float[arr.length + 1];
  // Copy elements from the original array to the new array
  for (int i = 0; i < arr.length; i++) {
    newArr[i] = arr[i];
  }
  return newArr;
}

float[] removeFirstElement(float[] arr) {
  // Check if the array is empty or has only one element
  if (arr.length <= 1) {
    return new float[0]; // Return an empty array
  }

  float[] newArr = new float[arr.length - 1];
  // Copy elements from the original array to the new array, skipping the first element
  for (int i = 1; i < arr.length; i++) {
    newArr[i - 1] = arr[i];
  }
  return newArr;
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

float[] predictNFields(float[] input, int n) {
  float[] predictions = new float[n];
  for (int i = 0; i < n; i++) {
    // Forward pass
    float[] _hiddenLayer = new float[numHidden];
    for (int j = 0; j < numHidden; j++) {
      float sum = 0;
      for (int k = 0; k < windowSize; k++) {
        sum += input[k] * inputWeights[k][j];
      }
      _hiddenLayer[j] = sigmoid(sum + hiddenBiases[j]);
    }

    float _output = 0;
    for (int j = 0; j < numHidden; j++) {
      _output += _hiddenLayer[j] * hiddenWeights[j];
    }
    _output = sigmoid(_output + outputBias);

    // Store the prediction
    predictions[i] = _output;

    // Update input window for the next prediction
    input = shiftInput(input, _output);
  }
  return predictions;
}

// Helper function to shift input window for the next prediction
float[] shiftInput(float[] input, float newValue) {
  for (int i = 0; i < input.length - 1; i++) {
    input[i] = input[i + 1];
  }
  input[input.length - 1] = newValue;
  return input;
}

float sigmoid(float x) {
  return 1 / (1 + exp(-x));
}

float dsigmoid(float x) {
  return x * (1 - x);
}
