 /*  TO DO:
 *  - Need variables for size (w&h) of objects min and max - detection in contours
 *  - Need to improve accuracy of colour recognition (orange is detecting skin better than orange paper)
 *  - Investigate erode() & dilate() before detection.
 *  - Improve detection of 'blobs' - canny / hough?
 *  - Look for *** to find areas noted.
 *  - Look into  contour setPolygonApproximationFactor() & getPolygonApproximation()
 */
import geomerative.*;

import processing.video.*;

import gab.opencv.*;

import boofcv.processing.*;
import boofcv.struct.image.*;

import georegression.struct.point.*;

import java.util.*;
import java.awt.Rectangle;

//end of imports and notes
//********************************************************
public class RoomDetector{
  Converter convert;
  
  Capture video;//video capture object
  OpenCV opencv;//OpenCV objet
  
  ArrayList<Contour> contours = new ArrayList<Contour>();//detection contours arraylist
   
   
   int maxColours = 8;//**SET MAX COLOURS to detect

  PImage[] outputs = new PImage[maxColours];//output images (cancelled out apart from selected colour)
  
  //ArrayList<List<Point2D_I32>> polygons;

  ArrayList<RShape> shapes = new ArrayList<RShape>();
  
  ArrayList<RPolygon> polygons = new ArrayList<RPolygon>();
  
  PImage src;//source image to provide detection - each frame is put into this
  boolean contoursNotEmpty[] = new boolean[maxColours];
    
  int[] hues = new int[maxColours];//hue values of selected colours
  int[] colours = new int[maxColours];//selected detection colours//array of detection colours
    
  int rangeWidth = 6;//***SET SENSITIVITY of hue detection

  //ArrayList<List<Point2D_I32>> polygons;

  //ArrayList<RShape> inShapes = new ArrayList<RShape>();
  //RShape outShape;
  
  //RPolygon inPolygon; 
  //ArrayList<RPolygon> outPolygons = new ArrayList<RPolygon>();
  
  int colourToChange = -1;//default (null) colour value
//end of global variables
//********************************************************
  
  //void setup() {
    RoomDetector(){
    
   // frameRate(20);
    convert = new Converter();
    
    video = new Capture(this.get, 640, 480);
    
    //String[] cams = video.list();
    
    //if(cams.length > 0){
      //video = new Capture(this, cams[0]);//initialise video capture object
    //}
    //else{
    //}
    
   // size(opencv.width + opencv.width/maxColours + 30, opencv.height, P2D);//set size of sketch window based on max. # of colours
 
    //textFont(createFont("BebasNeue Regular.ttf", 26));//import the BebasNeue font to Processing and set the text to use this font
  
    video.start();//start capturing video
  }//end of setup
//********************************************************
  
  void draw() {
  
    background(150);//set the background grey
  
    if (video.available()) {//if there is a video stream incoming
      video.read();//read incoming video frames
    }
    opencv.loadImage(video);//load the read video frame to OpenCV
    opencv.useColor();//make OpenCV use colour information
  
    //opencv.blur(2);
    src = opencv.getSnapshot();//use a snapshot of what OpenCV's capture sees
    opencv.useColor(HSB);//make OpenCV use the HSV colourTo space.
    
    image(src, 0, 0);//Show camera view
  
    detectColours();//
      
    shapes = convert.ContoursToRShapes(contours);
   
    polygons = convert.RShapesToRPolygons(shapes);

    drawContours();
  
    for (int i=0; i<outputs.length; i++) {
      if (outputs[i] != null) {//if there is a colour selected at i
        image(outputs[i], width - (src.width/maxColours), i*src.height/maxColours, src.width/maxColours, src.height/maxColours);//display images with other colour removed
        noStroke();//draw shape with no line
        fill(colours[i]);//set the fill for the rectangle to match the colour detected
        //rect(width-(src.width/maxColours + 30), i*src.height/maxColours, 30, src.height/maxColours);//display the selected colour on screen
      }
    }
  
    // Print text if new colourTo expected
    stroke(255);//make lines drawn from this point white
    fill(255);//fill shapes from this point white
  
    if (colourToChange > -1) {//if there is a colour to change now
      text("click to change colour " + (colourToChange+1), 10, 25);//display secondary instruction
    } else {
      text("press key [1-0 or q-t] to select colour", 10, 25);//display initial instruction
    }
  
    // displayContourBoxes();//display boxes round tracked items
  }//end of draw
  //********************************************************
  
  void detectColours() {//detect chosen colours
    contours.clear();
    for (int i=0; i< maxColours; i++) {//for each chosen hue value
     // if (hues[i] <= 0)//if no colour DEFAULT
      if (hues[i] >= 200 || hues[i] < 0)//if colour hue greater than 200
        continue;//skip detection
  
      opencv.loadImage(src);//take the source camera capture frame as an input to OpenCV
      opencv.useColor(HSB);//use HSB colours
  
      opencv.setGray(opencv.getH().clone());//copy hue channel into gray channel, which we process further
  
      int hueToDetect = hues[i];
  
      opencv.inRange(hueToDetect-rangeWidth/2, hueToDetect+rangeWidth/2);//filter by the hue values that match the object we want to track.
  
      //opencv.dilate();//thicken and join segments
      opencv.erode();//erode image - thin and seperate segments - removes some smaller noise from image
  
      //***TO DO: Add here some image filtering to detect blobs better***
  
      outputs[i] = opencv.getSnapshot();//save the output to the corresponding array item
  
      contoursNotEmpty[i] = false;//tell the program that this is an empty contour list (default value)
     
      //try this bit.. seems good
      /*opencv.blur(3);
      opencv.threshold(120);//works nice 
      opencv.erode();//
      */
      
      ArrayList<Contour> tempContours = opencv.findContours(false, true);//find the contours of the objects.. passing 'true' sorts them by descending area.
  
      for(Contour theC : tempContours){
        int numpoint = theC.getPoints().size();//find number of points in the contour
        if(numpoint < 450 && numpoint > 2){//if number within range ***
          Rectangle r = theC.getBoundingBox();//find the rectangle tightly fitting the contour
            if (r.width < 40 || r.height < 40 || r.width > 1000 || r.height > 1000){continue;}//IGNORE THE CONTOUR IF TOO BIG OR TOO SMALL
          else{
            //contours.add(theC); 
            theC.setPolygonApproximationFactor(10);//PLAY with the value
            contours.add(theC.getPolygonApproximation());//polygonize but OpenCV native ;) 
          }  //pruned list
         }
       }
    }
  }//end of detectColours
  //********************************************************
  void drawContours(){
    for(RPolygon p : polygons){
      p.draw();
    } 
  }
  //********************************************************  
  
  void takeSnapshots(){//gather series of frames for comparison
    for(int i = 0; i<8; i++){//loop 8 times - 8 frames captured
      //HOW TO DECIDE IF THE SHAPE DETECTED IS THE SAME AS ONE IN THE NEXT IMAGE? ><
    }
  }
  
  ArrayList<Area> getAreas(){//get areas from detection
    ArrayList<Area> newAreas = new ArrayList<Area>();
    //DEFINE AREAS FROM DETECTED SHAPES - MARKERS AND STUFF
    
    if(newAreas == null){return null;} 
    else{return newAreas;}
  }
  
}//end class RoomDetector

