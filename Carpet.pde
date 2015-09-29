class Carpet{//store room spaces to display on screen
  PVector pos;
  boolean gen = false;
  color lineCol = #000000, bgCol = color(0,0,0,0.7), textCol = #FFFFFF;
  String roomName = "Room Name";
  java.awt.Polygon p;
  ArrayList<PVector> vertices;
 
  Carpet() {
    vertices = new ArrayList<PVector>();
  }
  
  Carpet(ArrayList<PVector> iVert, String iName) {
    vertices = new ArrayList<PVector>();
  
    if(iName != "" && iName != null){roomName = iName;} 
      
    for(PVector vertex : iVert){
    vertices.add(vertex);}
    
    genShape();
  }

  void display(){
    if(!gen){genShape();}
    else{ 
      beginShape();
      for (int i = 0; i < p.npoints; i++) {
        vertex(p.xpoints[i], p.ypoints[i]);//draw the polygon
      }
      endShape(); 
    } 
  }
  
  void genShape(){
   p = new java.awt.Polygon();
   for(int i=0; i < vertices.size(); i++){
     p.addPoint((int)vertices.get(i).x,(int)vertices.get(i).y);//draw the polygon
     //println("x: " + vertices.get(i).x + ", y: " + vertices.get(i).y); 
   }    
   gen=true;
  } 
}//end class Carpet


