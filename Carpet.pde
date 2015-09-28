class Carpet{//store room spaces to display on screen
  //PVector pos;
  color lineCol = #000000, bgCol = color(0,0,0,0.8), textCol = #FFFFFF;
  String roomName = "Room Name";
  PShape p;
  
  Carpet(PVector iVert[], String iName) {
    if(iName != "" && iName != null){roomName = iName;}    
    beginShape();
      for(int i=0; i < 10; i++){
         float x = iVert[i].x;
         float y = iVert[i].y;
         vertex(x,y);//draw the polygon
      }
    endShape(CLOSE); 

  }

  void display(){ 
    pushMatrix();
      translate(mouseX,mouseY);
      shape(p);
    popMatrix();

    fill(#FFFFFF);
  }
  
}//end class Carpet
