

import java.awt.*;
import java.awt.event.*;
import java.awt.MouseInfo;

Robot robot;
PFont pfont;
Point save_p;

void setup() {
  size(320, 240,P2D);
  try { 
    robot = new Robot();
    robot.setAutoDelay(0);
  } 
  catch (Exception e) {
    e.printStackTrace();
  }

  pfont = createFont("Impact", 11);
}

void draw() {
  background(#ffffff);
  fill(#000000);


  /*

     int x = MouseInfo.getPointerInfo().getLocation().x; 
     int y = MouseInfo.getPointerInfo().getLocation().y;
   */

  Point p = getGlobalMouseLocation();

  textFont(pfont);
  text("now x=" + (int)p.getX() + ", y=" + (int)p.getY(), 10, 32);

  if (save_p != null) {
    text("save x=" + (int)save_p.getX() + ", y=" + (int)save_p.getY(), 10, 64);
  }
}

void keyPressed() {
  switch(key) {
    case 's':
      save_p = getGlobalMouseLocation();
      break;
    case 'm':
      if (save_p != null) {
        mouseMove((int)save_p.getX(), (int)save_p.getY());
      }
      break;
    case 'c':
    case ' ':
      if (save_p != null) {
        mouseMoveAndClick((int)save_p.getX(), (int)save_p.getY());
      }
      break;
  }
}

Point getGlobalMouseLocation() {
  // java.awt.MouseInfo
  PointerInfo pointerInfo = MouseInfo.getPointerInfo();
  Point p = pointerInfo.getLocation();
  return p;  
}

void mouseMove(int x, int y) {
  robot.mouseMove(x, y);
}

void mouseMoveAndClick(int x, int y) {
  robot.mouseMove(x, y);
  robot.mousePress(InputEvent.BUTTON1_DOWN_MASK);
  robot.mouseRelease(InputEvent.BUTTON1_DOWN_MASK);
  robot.waitForIdle();
}

