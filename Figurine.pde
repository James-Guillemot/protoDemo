class Figurine{//store characters to display on screen
  PVector pos;
  PVector size;
  boolean locked = false;
  
  String name;
  String imageName;
  PImage img;
  int xpos;
  int ypos;
  
  Figurine() {}

  Figurine(String iName, int ix, int iy, float iw, float ih, String iFile) {
    pos = new PVector(ix, iy);
    size = new PVector(iw, ih);
    name = iName;
    imageName = iFile;
    img = loadImage(imageName);
    diff = new PVector(0,0);
  }

  void display(){
    image(img, pos.x, pos.y, size.x, size.y);    
            //image(img, xpos, ypos, size.x, size.y);    

  }

  boolean mouseIn() {
    if (mouseX > pos.x - size.x/2 /*if within x bounds*/
    && mouseX < pos.x + size.x/2 
    && mouseY > pos.y - size.y/2 /*if within y bounds*/
    && mouseY < pos.y + size.y/2 
    && !figMoving) {//and another figurine not being moved
      locked = true;
      return true;
    }//mouse in me
    else {return false;}//mouse not in me
  } 

  /*void update() {
    
  //  println("x: " + diff.x + ", y: " + diff.y);
    if (mouseIn() && mousePressed) {
      
      pos.x = mouseX;
      pos.y = mouseY;
      //xpos=(mouseX/8)*8;
      //ypos=(mouseY/8)*8; 
     }
  }*/
}//end class figurine
