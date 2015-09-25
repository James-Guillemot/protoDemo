class Carpet{//store room spaces to display on screen
  PVector pos;
  PVector size;
  color lineCol = #000000, bgCol = color(0,0,0,0.8), textCol = #FFFFFF;
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
    fill(textCol);
    textSize(18);
    textAlign(CENTER, CENTER);
    text(roomName, pos.x, pos.y, size.x, size.y);    
    fill(#FFFFFF);
  }

  
}//end class Carpet
