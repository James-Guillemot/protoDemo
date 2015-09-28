class Carpet{//store room spaces to display on screen
  PVector pos;
  color lineCol = #000000, bgCol = color(0,0,0,0.7), textCol = #FFFFFF;
  String roomName = "Room Name";
  PShape p;
  ArrayList<PVector> vertices;
  boolean drawn = false;
 
  Carpet() {
    vertices = new ArrayList<PVector>();
  }
  
  Carpet(ArrayList<PVector> iVert, String iName) {
    vertices = new ArrayList<PVector>();
    
    if(iName != "" && iName != null){roomName = iName;} 
    
    for(PVector vertex : iVert){
      vertices.add(vertex);}
      
  }

  void display(){ 
    if(drawn == false){drawn=true;  
    drawShape();}else{
      //pushMatrix();
        //translate(pos.x, pos.y);
        //translate(mouseX, mouseY);
        shape(p);
      //popMatrix();
  
      fill(#FFFFFF);
      }
  }
  
  void drawShape(){
    beginShape();
        for(int i=0; i < vertices.size(); i++){
           float x = vertices.get(i).x;
           float y = vertices.get(i).y;
           vertex(x,y);//draw the polygon
        }
      endShape(CLOSE);  //drawn=true;
  }
  
}//end class Carpet
