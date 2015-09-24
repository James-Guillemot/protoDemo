ArrayList<Figurine> figurines;//stores figurines in a list of Figurine type
Figurine tom, fred, jassi, tilly, bill;//stores figurines as objects

PVector figSize = new PVector(60, 110);//set global figurine size - remove or comment if individually sizing//store the size of all figurines - remove for individually sized figs

color bgColour;//colour of background for window
PImage bgImg;//background image
String bgFile = "bg.png";//store file name for background image - bg.png

void setup(){//set up the application
  setupFigurines();
  
  size(1024, 768);//set window size
   
  bgColour = color(random(255), random(255), random(255));//set a random colour to be the background
  //bgImg = loadImage(bgFile);//use this to set a background image
  
  rectMode(CENTER);//position of a rectangle is measured from center rather than 0,0 of the rectangle
  imageMode(CENTER);//mirror this with the image mode
}

void draw() {
  background(bgColour);
  //image(bgImg, 0, 0);//used for background image
  
  for (Figurine curFig : figurines){//for each figurine in the list
    curFig.update();
    curFig.display();
  }
}

void setupFigurines(){
  figurines = new ArrayList<Figurine>();//initialize figurines list
  
  tom = new Figurine(60, 80, figSize.x, figSize.y, "tom.png");
  figurines.add(tom);
  
  /*
  fred = new Figurine(120, 80, figSize.x, figSize.y, "fred.png");
  figurines.add(fred);
  
  jassi = new Figurine(180, 80, figSize.x, figSize.y, "jassi.png");
  figurines.add(jassi);
  
  tilly = new Figurine(240, 80, figSize.x, figSize.y, "tilly.png");
  figurines.add(tilly);
  
  bill = new Figurine(300, 80, figSize.x, figSize.y, "bill.png");
  figurines.add(bill);
  
  */
}

class Figurine{//store characters to display on screen
  PVector pos;
  PVector size;
  String imageName;
  PImage img;

  Figurine(int ix, int iy, float iw, float ih, String iFile) {
    pos = new PVector(ix, iy);
    size = new PVector(iw, ih);
    imageName = iFile;
    img = loadImage(imageName);
  }

  void display(){
    image(img, pos.x, pos.y, size.x, size.y);
  }

  boolean mouseIn() {
    if (mouseX >= pos.x - size.x/2 /*if within x bounds*/
    && mouseX <= pos.x + size.x/2 

      && mouseY >= pos.y - size.y/2 /*if within y bounds*/
    && mouseY <= pos.y + size.y/2) {
      return true;
    }//mouse in me

      else return false;//mouse not in me
  } 

  void update() {
    PVector diff = new PVector();
    diff.x = mouseX - pos.x;
    diff.y = mouseY - pos.y;
    println("x: " + diff.x + ", y: " + diff.y);
    if (mouseIn() && mousePressed) {
      pos.x = mouseX + diff.x;
      pos.y = mouseY + diff.y;
    }
  }
  
}//end class figurine

