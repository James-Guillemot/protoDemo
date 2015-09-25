class Wall{//store walls to display on screen
  PVector pos;
  PVector size;
  color lineCol, bgCol;
 
  Wall() {}

  Wall(int ix, int iy, float iw, float ih) {
    pos = new PVector(ix, iy);
    size = new PVector(iw, ih);
  }

  void display(){
    fill(bgCol);
    stroke(lineCol);
    rect(pos.x, pos.y, size.x, size.y);//otherwise draw my background colour
  }

  
}//end class Wall
