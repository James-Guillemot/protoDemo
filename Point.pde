class Point{//store points to check
  int x, y;
  
  Point(int ix, int iy) {
    x = ix;
    y = iy;
  }

  void display(){
    stroke(#000000);
    point(x, y);//otherwise draw my background colour
  }
}//end class Point


