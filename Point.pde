class Point{//store points to check
  int x, y;
  
  Point(float ix, float iy) {
    x = (int)ix;
    y = (int)iy;
  }

  void display(){
    stroke(#000000);
    point(x, y);//otherwise draw my background colour
  }
}//end class Point


