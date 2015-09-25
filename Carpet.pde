class Carpet{//store room spaces to display on screen
  PVector pos;
  PVector size;
  color lineCol = #000000, bgCol = color(0,0,0,0.8);
  String roomName = "placeholder";
 
  Carpet(){
  
  
  }

  Carpet(int ix, int iy, float iw, float ih, String iName) {
    pos = new PVector(ix, iy);
    size = new PVector(iw, ih);
    roomName = iName;
  }

  void display(){
    fill(bgCol);
    stroke(lineCol);
    rect(pos.x, pos.y, size.x, size.y);//otherwise draw my background colour
  }

  
}//end class Carpet
