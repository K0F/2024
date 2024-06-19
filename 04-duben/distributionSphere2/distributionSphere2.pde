int totalPoints = 10;
PVector[] points = new PVector[totalPoints];

void setup() {
  size(400, 400, P3D);
  ortho();
  generatePoints();
}

void draw() {
  background(255);
  translate(width/2, height/2, 0);
  rotateY(frameCount * 0.01);
  rotateX(frameCount * 0.01);
  
  for (int i = 0; i < totalPoints; i++) {
    PVector p = points[i];
    pushMatrix();
    translate(p.x, p.y, p.z);
    fill(255, 0, 0);
    sphere(5);
    popMatrix();
  }
}

void generatePoints() {
  float increment = PI * (3 - sqrt(5)); // Golden ratio increment
  float offset = TWO_PI / totalPoints;
  float radius = 150;

  for (int i = 0; i < totalPoints; i++) {
    float y = 1 - (i / (float)(totalPoints - 1)) * 2; // y goes from 1 to -1
    float latitude = asin(y); // Convert y to latitude

    float longitude = i * increment; // Golden ratio increment for longitude

    float x = cos(longitude) * cos(latitude) * radius;
    float z = sin(longitude) * cos(latitude) * radius;
    
    points[i] = new PVector(x, y * radius, z);
  }
}
