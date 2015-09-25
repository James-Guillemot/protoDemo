class Wall{//store walls to display on screen
  PVector pos;
  PVector size;
  color lineCol = #000000, bgCol = #000000;//store line and background fill colour
 
  Wall() {
    pos = new PVector();
    size = new PVector();
  }

  Wall(int ix, int iy, float iw, float ih) {
    pos = new PVector(ix, iy);
    size = new PVector(iw, ih);
  }

  void display(){
    fill(bgCol);
    stroke(lineCol);
    rectMode(CORNER);//position of a rectangle is measured from center rather than 0,0 of the rectangle
    rect(pos.x+200, pos.y, size.x, size.y);//otherwise draw my background colour
    fill(#FFFFFF);
  }

  
}//end class Wall
