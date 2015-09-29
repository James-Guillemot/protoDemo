import java.awt.geom.Rectangle2D;

class Figurine {//store characters to display on screen
  PVector pos;//my position
  PVector size;//my size
  boolean locked = false;//am I locked to the mouse position?
  //Area a = new Area(new Rectangle(pos.x-size.x/2, pos.y-size.y/2, size.x, size.y));
  Rectangle2D r;
  Area z;

  int roomNo;//index of room currently occupied
  boolean room;//am I in a room?

  String name;//my name
  String imageName;//path of my image
  PImage img;//memory store of loaded image

  Figurine() {
    pos = new PVector();
    size = new PVector();
    img = new PImage();
  }

  Figurine(String iName, float ix, float iy, float iw, float ih, String iFile) {
    pos = new PVector(ix, iy);
    size = new PVector(iw, ih);

    name = iName;
    imageName = iFile;
    img = loadImage(imageName);
    // diff = new PVector(0,0);
  }

  void display() {
    r = new Rectangle((int)(pos.x-size.x/2), (int)(pos.y-size.y/2), (int)size.x, (int)size.y);
    z = new Area(r);
    rectMode(RADIUS);//position of a rectangle is measured from center rather than 0,0 of the rectangle
    imageMode(CENTER);//mirror this with the image mode
    image(img, pos.x, pos.y, size.x, size.y);
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
    else {
      return false;
    }//mouse not in me
  } 

  void checkRoom() {
    room = false;
    for (Carpet c : carpets) {
      boolean in = c.contains(new Point(pos.x - size.x/2, pos.y - size.y/2), new Point(size.x, size.y));
      if (in == true) {
        room = true; 
        roomNo = carpets.indexOf(c); 
        String roomName = c.roomName; 
        println(name + ": I am in: " + roomName + " at index " + roomNo);
      }

      z.intersect(c.a);
      println("area: " + z.());

    } 
    if (!room) {
      roomNo = -1;
    }
  }
}//end class figurine

