import boofcv.processing.*;
import boofcv.struct.image.*;

import geomerative.*;

import georegression.struct.point.*;

import gab.opencv.*;
//=============================================

class Converter{//Convert and perform various operations on Contours, RPolygons, RShapes, Lists of these
  Converter(){
  
  }
//=============================================

   ArrayList<RShape> ContoursToRShapes(ArrayList<Contour> input) {
    ArrayList<RShape> shapes = new ArrayList<RShape>();
    
    if(input.size()>0){//println("some contours to poly");
      for (Contour c : input) {
        RContour cont = new RContour();
        
        for (PVector p : c.getPoints()) {
          cont.addPoint(new RPoint(p.x, p.y));
        } 
        RPolygon newPolygon = new RPolygon(cont);
        shapes.add(newPolygon.toShape());
      }
      return shapes;
    }else{return null;}
  }

  ArrayList<RPolygon> ContoursToRPolygons(ArrayList<Contour> input){
   ArrayList<RPolygon> polygons = new ArrayList<RPolygon>();
    if(input.size()>0){//println("some contours to poly");
      for (Contour c : input) {
        RContour cont = new RContour();
          
        for (PVector p : c.getPoints()) {
          cont.addPoint(new RPoint(p.x, p.y));
        } 
        RPolygon newPolygon = new RPolygon(cont);
        polygons.add(newPolygon);
      }
      return polygons;
    }else{return null;}
  }
//=============================================
  
  ArrayList<RPolygon> RShapesToRPolygons(ArrayList<RShape> input){
    ArrayList<RPolygon> polygons = new ArrayList<RPolygon>();
    for(int i = 0; i<input.size(); i++){
      RShape newShape = (input.get(i));//replacement does not polygonize
      polygons.add(newShape.toPolygon());
    }
    return polygons;
  }
//=============================================

  ArrayList<RPolygon> polygonizeRShapesToRPolygons(ArrayList<RShape> input, float pointSeparation){
    RG.setPolygonizer(RG.UNIFORMLENGTH);
    RG.setPolygonizerLength(pointSeparation);//mouse val
    //RG.setPolygonizerLength(30);//nice value
  
    ArrayList<RPolygon> polygons = new ArrayList<RPolygon>();
    for(int i = 0; i<input.size(); i++){
      RShape newShape = (RG.polygonize(input.get(i)));//polygonize the current shape
      polygons.add(newShape.toPolygon());
    }
    return polygons;
  }
//=============================================

  ArrayList<RShape> polygonizeRShapesToRShapes(ArrayList<RShape> input, float pointSeparation){
    ArrayList<RShape> shapes = new ArrayList<RShape>();
   
    if(!input.isEmpty()){
      RG.setPolygonizer(RG.UNIFORMLENGTH);
      
      RG.setPolygonizerLength(pointSeparation);//if there is a value set
    
      shapes = new ArrayList<RShape>();
      for(int i = 0; i<input.size(); i++){
        RShape newShape = (RG.polygonize(input.get(i)));//polygonize the current shape
        shapes.add(newShape);
      }
      return shapes;
    }
    else return null;
  }
  
//=============================================
}//end class
