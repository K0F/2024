void setup() {
  size(400, 400);
  background(220);
}

void draw() {
  // Head
  fill(200);
  ellipse(width/2, height/2, 100, 120);

  // Eyes
  fill(0);
  ellipse(width/2 - 20, height/2 - 20, 10, 15);
  ellipse(width/2 + 20, height/2 - 20, 10, 15);

  // Beak
  triangle(width/2 - 10, height/2 + 10, width/2 + 10, height/2 + 10, width/2, height/2 + 20);

  // Wings
  fill(180);
  triangle(width/2 - 50, height/2 + 20, width/2 - 20, height/2 - 40, width/2 + 20, height/2 - 40);
  triangle(width/2 + 50, height/2 + 20, width/2 + 20, height/2 - 40, width/2 - 20, height/2 - 40);
}
