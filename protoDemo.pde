ArrayList<Figurine> figurines;//stores figurines in a list of Figurine type
Figurine tomPos, fredPos, jassiPos, tillyPos, billPos;//stores figurines as objects

PVector figSize;//store the size of all figurines - remove for individually sized figs

PVector mousePos = new PVector();//current position of mouse

color bgColour;//colour of background for window
PImage bgImg;//background image
String bgFile = "bg.png";//store file name for background image - bg.png

void setup(){//set up the application
  size(1024, 768);//set window size
  figSize = new PVector(50, 95);//set global figurine size - remove or comment if individually sizing
  bgColour = color(random(255), random(255), random(255));//set a random colour to be the background
  //bgImg = loadImage(bgFile);//use this to set a background image
  
  rectMode(CENTER);//position of a rectangle is measured from center rather than 0,0 of the rectangle
}

void draw() {
  //update(mouseX, mouseY);//not sure if needed
  mousePos.x = mouseX; 
  mousePos.y = mouseY;
  
  background(bgColour);
  
  for (Figurine curFig : figurines){//for each figurine in the list
    curFig.display();
  }
}

void update(int x, int y) {
  if ( overCircle(circleX, circleY, circleSize) ) {
    circleOver = true;
    rectOver = false;
  } else if ( overRect(rectX, rectY, rectSize, rectSize) ) {
    rectOver = true;
    circleOver = false;
  } else {
    circleOver = rectOver = false;
  }
}

//void mousePressed() {
//  mousePos.x = mouseX;
//  mousePos.y = mouseY;
//  if (circleOver) {
//    currentColor = circleColor;
//  }
//  if (rectOver) {
//    currentColor = rectColor;
//  }
//}

boolean overRect(int x, int y, int width, int height) {
  if (mouseX >= x && mouseX <= x+width && 
    mouseY >= y && mouseY <= y+height) {
    return true;
  } else {
    return false;
  }
}

boolean overCircle(int x, int y, int diameter) {
  float disX = x - mouseX;
  float disY = y - mouseY;
  if (sqrt(sq(disX) + sq(disY)) < diameter/2 ) {
    return true;
  } else {
    return false;
  }
}

class Figurine{//store characters to display on screen
  PVector pos;
  PVector size;
  String imageName;
  PImage img;

  Figurine(int ix, int iy, int iw, int ih, String iFile) {
    pos = new PVector(ix, iy);
    size = new PVector(iw, ih);
    imageName = iFile;
    img = loadImage(imageName);
  }

  void display(){
    updatePos();
    image(img, pos.x, pos.y);
  }

  boolean mouseIn() {
    if (mousePos.x > pos.x - size.x/2 /*if within x bounds*/
    && mousePos.x > pos.x + size.x/2 

      && mousePos.y > pos.y - size.y/2 /*if within y bounds*/
    && mousePos.y > pos.y + size.y/2) {
      return true;
    }//mouse in me

      else returnfalse;//mouse not in me
  } 

  void updatePos() {
    int xDiff = mouseX - pos.x;
    int yDiff = mouseY - pos.y;
    if (mouseIn() && mousePressed) {
      pos.x = mousePos.x;
      pos.y = mousePos.y;
    }
  }
  
}//end class figurine

