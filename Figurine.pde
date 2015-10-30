class Figurine {//store characters to display on screen
  PVector pos;//my position
  PVector size;//my size
  boolean locked = false;//am I locked to the mouse position?

  RPolygon r;//bounding rectangle
  Area z;//area of 

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
    r = RPolygon.createRectangle(pos.x-size.x/2, pos.y-size.y/2, size.x, size.y);
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
    float previousArea = 0;

    for (Area theArea : areas) {
     /* boolean in = c.contains(new Point(pos.x - size.x/2, pos.y - size.y/2), new Point(size.x, size.y));
      if (in == true) {
        room = true; 
        roomNo = carpets.indexOf(c); 
        String roomName = c.roomName; 
        println(name + ": I am in: " + roomName + " at index " + roomNo);
      }*/
      
      //ADD HERE AN IDENTIFIER FOR ROOOOOMMSSSSSS***

      try{
        float x=r.intersection(theArea.p).getArea();

        if (x > 0){//if the area intersected is greater than 0
          if (x > previousArea){
            previousArea = x;
            roomNo = areas.indexOf(theArea); 
            //DO SOMETHING ABOUT IT
            println("\n" + name + ": I am in " + areas.get(roomNo).areaName + "!" + x);
          }
        }
        else {previousArea = 0;}
      }
      catch(Exception e){
        //println(name + ": I am not in a room");
      }
      
      if (!room) {
        roomNo = -1;
      }
    }
  }

}//end class figurine

