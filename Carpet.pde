import java.awt.*;
import java.awt.geom.*;

class Carpet{//store room spaces to display on screen
  PVector pos;
  boolean gen = false;
  color col = #FFFFFF, lineCol = #000000, bgCol = color(col, 180), textCol = #FFFFFF;
  String roomName = "Room Name";
  Polygon p;
  Area a;
  
  
  ArrayList<PVector> vertices;
  
  Carpet(ArrayList<PVector> iVert, String iName) {
    vertices = new ArrayList<PVector>();
    
    gen = false;
    //vertices = iVert;
      
    if(iName != "" && iName != null){roomName = iName;} 
      
    for(PVector vertex : iVert){
    vertices.add(vertex);}
    
    genShape();  
  }

  void display(){
    if(!gen){genShape();}
    else{ 
      fill(bgCol);
      stroke(lineCol);
      strokeWeight(2);
      beginShape();
      for (int i = 0; i < p.npoints; i++) {
        vertex(p.xpoints[i], p.ypoints[i]);//draw the polygon
      }
      endShape(); 
    } 
       
    stroke(255,0,0);
    strokeWeight(10);
    //point(290,65); point(420,450);
  }
  
  void genShape(){
   p = new Polygon();
   for(int i=0; i < vertices.size(); i++){
     p.addPoint((int)vertices.get(i).x,(int)vertices.get(i).y);//draw the polygon
     //println("x: " + vertices.get(i).x + ", y: " + vertices.get(i).y); 
   }    
   gen = true;
   
   a = new Area(p);

  } 
  
  boolean contains(Point point1, Point point2){
  if(p.contains(point1.x, point1.y, point2.x, point2.y)){return true;}
  else return false; 
   
   /*if(p.contains(mouseX, mouseY)){println(roomName + ": DO have point"); return true;}
   else {println(roomName + ": DON'T have point");return false;}*/
  }
  
}//end class Carpet


