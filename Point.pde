class Point{//store points to check
  PVector pos;
  Point(int ix, int iy) {
    pos = new PVector(ix, iy);
  }

  void display(){
    stroke(#000000);
    point(pos.x, pos.y);//otherwise draw my background colour
  }
}//end class Point


