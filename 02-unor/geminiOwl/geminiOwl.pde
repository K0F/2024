void setup() {
  size(400, 400);
  background(220);
}

float wingAngle = 0.0; // Variable for wing angle

void draw() {
  background(220);

  // Head with Bézier curve
  noFill();
  beginShape();
  // ... (same as before)
  endShape();

  // Eyes
  fill(0);
  ellipse(width/2.0 - 20.0, height/2.0 - 20.0, 10.0, 15.0);
  ellipse(width/2.0 + 20.0, height/2.0 - 20.0, 10.0, 15.0);

  // Beak
  triangle(width/2.0 - 10.0, height/2.0 + 10.0, width/2.0 + 10.0, height/2.0 + 10.0, width/2.0, height/2.0 + 20.0);

  // Wings with Bézier curves and animation
  pushMatrix(); // Save current transformation matrix
  translate(width/2.0, height/2.0 + 20.0); // Move origin to wing base
  rotate(wingAngle); // Rotate wings
  beginShape();
  bezierVertex(-30.0, 0.0, -20.0, -40.0, 0.0, -60.0, 20.0, -40.0);
  endShape();
  beginShape();
  bezierVertex(-30.0, 0.0, -20.0, -40.0, 0.0, -60.0, -20.0, -40.0);
  endShape();
  popMatrix(); // Restore original transformation matrix

  // Update wing angle for animation
  wingAngle += 0.1; // Adjust increment for wing flapping speed
}

