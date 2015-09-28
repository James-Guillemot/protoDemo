class Carpet{//store room spaces to display on screen
  //PVector pos;
  //PVector size;
  color lineCol = #000000, bgCol = color(0,0,0,0.8), textCol = #FFFFFF;
  String roomName = "Room Name";
  java.awt.Polygon p;
  
  Carpet(){
    p = new java.awt.Polygon();//create the polygon
    
  
  }

  Carpet(int ix, int iy, float iw, float ih, String iName) {
    p = new java.awt.Polygon();//create the polygon
    //pos = new PVector(ix, iy);
    //size = new PVector(iw, ih);
    roomName = iName;
  }

  void display(){
    fill(bgCol);
    stroke(lineCol);
    
    //new contour polygon
    beginShape();
    for (int i = 0; i < p.npoints; i++) {
      vertex(p.xpoints[i], p.ypoints[i]);//draw the polygon
    }
    endShape(); 
    //end of carpet drawing
    
    //rect(pos.x, pos.y, size.x, size.y);//otherwise draw my background colour //OLD ONE
    
    fill(textCol);
    textSize(18);
    textAlign(CENTER, CENTER);
    //text(roomName, pos.x, pos.y, size.x, size.y);//draw text
    fill(#FFFFFF);
  }
  
}//end class Carpet
