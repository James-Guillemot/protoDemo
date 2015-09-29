class Carpet{//store room spaces to display on screen
  PVector pos;
  boolean hdrawn;
  color lineCol = #000000, bgCol = color(0,0,0,0.7), textCol = #FFFFFF;
  String roomName = "Room Name";
  java.awt.Polygon p;
  ArrayList<PVector> vertices = new ArrayList<PVector>();
 
  Carpet() {
    //vertices = new ArrayList<PVector>();
  }
  
  Carpet(ArrayList<PVector> iVert, String iName) {
  
    if(iName != "" && iName != null){roomName = iName;} 
    
   /* for(PVector vertex : iVert){
     vertices.add(vertex);}
      
       beginShape();
        for(int i=0; i < vertices.size(); i++){
           float x = vertices.get(i).x;
           float y = vertices.get(i).y;
           vertex(x,y);//draw the polygon
        }
     endShape(CLOSE);  //drawn=true;
     
    }*/
  }

  void display(){ 
   /* if(hdrawn == false){hdrawn=true;  
    drawShape();}else{
      //pushMatrix();
        //translate(pos.x, pos.y);
        //translate(mouseX, mouseY);
        shape(p);
      //popMatrix();
  
      fill(#FFFFFF);
      }*/
      
      p.draw(bgCol, lineCol);
  }
  
 
}//end class Carpet


