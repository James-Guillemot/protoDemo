import geomerative.*;

import boofcv.processing.*;
import boofcv.struct.image.*;
import georegression.struct.point.*;
import java.util.*;

List<List<Point2D_I32>> polygons;


ArrayList<Figurine> figurines;//stores figurines in a list of Figurine type
ArrayList<Area> areas;//stores carpets in a list of Carpet type
ArrayList<Button> buttons;//stores buttons in a list of Button type

Figurine currentFigurine;//stores an address to the figurine currently in use
Button currentButton;//stores an address to the figurine currently in use

PVector diff = new PVector(), figSize = new PVector(90, 65);//set global figurine size - remove or comment if individually sizing//store the size of all figurines - remove for individually sized figs

boolean figMoving = false;//is a figurine moving?
int theFig = -1;//is a figurine moving?

color bgColour, areaCol, lineCol;//colour of background for window
PImage bgImg;//background image
//String bgFile = "bg.jpg";//store file name for background image - bg.png
String bgFile = "bg3.jpg";//store file name for background image - bg.png
//end of global variables and imports
//==========================================

//default setup and draw methods
//==========================================
void setup() {//set up the application
  RG.init(this);
  size(1440, 900);//set window size

  figurines = new ArrayList<Figurine>();//initialize figurines list
  //walls = new ArrayList<Wall>();//initialize walls list
  areas = new ArrayList<Area>();//initialize walls list
  buttons = new ArrayList<Button>();//initialize walls list

  setupFigurines();//to reset the default figurines - currently not used as figs can be loaded!
  //setupWalls();//initial wall area
 // setupCarpets();//initial carpet areas
  setupGUI();//******

  currentFigurine = new Figurine();

  bgColour = color(random(255), random(255), random(255));//set a random colour to be the background
  areaCol = #FFFFFF;
  lineCol = #000000;
  bgImg = loadImage(bgFile);//use this to set a background image

  rectMode(RADIUS);//position of a rectangle is measured from center rather than 0,0 of the rectangle
  imageMode(CENTER);//mirror this with the image mode
}
//------------------------------------------
void draw() {
  background(bgColour);
  //background(bgImg);
  fill (areaCol);
  stroke(lineCol);
  strokeWeight(2);
  rect(0, 0, 200, height);//draw area on left

    //image(bgImg, 0, 0);//used for background image

  /*for (Wall curWall : walls) {//for each figurine in the list
   curWall.display();//draw the current figurine (one by one)
   }*/
  for (Area curArea : areas) {//for each figurine in the list
    curArea.display();//draw the current figurine (one by one)
  }
  for (Button curBut : buttons) {//for each figurine in the list
    curBut.display();//draw the current figurine (one by one)
  }
  for (Figurine curFig : figurines) {//for each figurine in the list
    curFig.display();//draw the current figurine (one by one)
  }
}
//==========================================

//program setup 
//==========================================
void setupFigurines() {//creates figurines for initialisation too
  Figurine tom, fred, jassi, tilly, bill;//stores figurines as objects

  tom = new Figurine("Tom", 50, 60, figSize.x, figSize.y, "tom.png");
  figurines.add(tom);

  fred = new Figurine("Fred", 150, 60, figSize.x, figSize.y, "fred.png");
  figurines.add(fred);

  jassi = new Figurine("Jassi", 50, 180, figSize.x, figSize.y, "jassi.png");
  figurines.add(jassi);

  tilly = new Figurine("Tilly", 150, 180, figSize.x, figSize.y, "tilly.png");
  figurines.add(tilly);

  bill = new Figurine("Bill", 50, 300, figSize.x, figSize.y, "bill.png");
  figurines.add(bill);
}
//------------------------------------------

void setupCarpets() {//creates initial carpets
  Area c1, c2, c3, c4, c5, c6, c7, c8;//stores figurines as objects
  
  ArrayList<PVector> a1 = new ArrayList<PVector>();
  ArrayList<PVector> a2 = new ArrayList<PVector>();
  ArrayList<PVector> a3 = new ArrayList<PVector>();
  ArrayList<PVector> a4 = new ArrayList<PVector>();
  ArrayList<PVector> b1 = new ArrayList<PVector>();
  ArrayList<PVector> b2 = new ArrayList<PVector>();
  ArrayList<PVector> b3 = new ArrayList<PVector>();
  ArrayList<PVector> b4 = new ArrayList<PVector>();

  a1.add(new PVector(240, 40));
  a1.add(new PVector(290, 40));
  a1.add(new PVector(290, 90));
  a1.add(new PVector(240, 90));

  //*********************************
  a2.add(new PVector(290, 40));
  a2.add(new PVector(340, 40));
  a2.add(new PVector(340, 90));
  a2.add(new PVector(290, 90));
  //*********************************

  a3.add(new PVector(340, 40));
  a3.add(new PVector(390, 40));
  a3.add(new PVector(390, 90));
  a3.add(new PVector(340, 90));

  //*********************************
  a4.add(new PVector(390, 40));
  a4.add(new PVector(440, 40));
  a4.add(new PVector(440, 90));
  a4.add(new PVector(390, 90));
  //*********************************
  
  b1.add(new PVector(240, 90));
  b1.add(new PVector(290, 90));
  b1.add(new PVector(290, 140));
  b1.add(new PVector(240, 140));

  //*********************************
  b2.add(new PVector(290, 90));
  b2.add(new PVector(340, 90));
  b2.add(new PVector(340, 140));
  b2.add(new PVector(290, 140));
  //*********************************

  b3.add(new PVector(340, 90));
  b3.add(new PVector(390, 90));
  b3.add(new PVector(390, 140));
  b3.add(new PVector(340, 140));

  //*********************************
  b4.add(new PVector(390, 90));
  b4.add(new PVector(440, 90));
  b4.add(new PVector(440, 140));
  b4.add(new PVector(390, 140));
  //*********************************
  c1 = new Area(a1, "1");
  c2 = new Area(a2, "2");
  c3 = new Area(a3, "3");
  c4 = new Area(a4, "4");
  c5 = new Area(b1, "5");
  c6 = new Area(b2, "6");
  c7 = new Area(b3, "7");
  c8 = new Area(b4, "8");

  areas.add(c1);
  areas.add(c2);
  areas.add(c3);
  areas.add(c4);
  areas.add(c5);
  areas.add(c6);
  areas.add(c7);
  areas.add(c8);
}
//------------------------------------------

void setupGUI() {//generates a GUI    --store buttons in JSON too
  //Button addFig = new Button(100, 900-50, 50, 15, "Add");
  //buttons.add(addFig);
}
//end of program setup
//==========================================

//menu and actions
//==========================================
void saveExit() {
  saveJSONs(genJSONs());//save generated JSON files
  exit();//stop runtime
}
//==========================================

//action handlers
//==========================================
void mousePressed() {
  for (Figurine curFig : figurines) {//for each figurine in the list
    if (curFig.mouseIn()) {
      figMoving=true; 
      theFig = figurines.indexOf(curFig);
      currentFigurine = curFig;
      diff.x = mouseX - currentFigurine.pos.x;
      diff.y = mouseY - currentFigurine.pos.y;
    }
  }
  for (Button curBut : buttons) {//for each figurine in the list
    if (curBut.mouseIn()) {
      //curBut
    }
  }
}
//------------------------------------------
void mouseDragged() {
  if (figMoving) {
    currentFigurine.pos.x = mouseX-diff.x; 
    currentFigurine.pos.y = mouseY-diff.y;
  }
}
//------------------------------------------
void mouseReleased() {
  figMoving=false;
  theFig = -1;
println();
  currentFigurine.checkRoom();  
  //println(figMoving);
}
//------------------------------------------

void keyPressed() {
  switch(key) {
  default: 
    println("INVALID OPTION SELECTED! Press 'H' for key bindings"); 
    break;
  case 'q': 
  case 'Q': 
    println("SAVED AND EXITED!"); 
    saveExit(); 
    break;
  case 'r': 
  case 'R': 
    println("LOADING ROOMS!"); 
    //walls = readWallsJSON(); 
    areas = readAreasJSON(); 
    break;
  case 'f': 
  case 'F': 
    println("LOADING FIGURINES!"); 
    figurines = readFigsJSON(); 
    break;
  case 'h': 
  case 'H': 
    println("Help: press 'R' to load rooms!"); 
    println("Press 'F' to load figurines!"); 
    println("Press 'Q' to quit and save figurines & rooms!"); 
    break;
  }
}
//end of action handlers
//==========================================

//JSON input and output
//==========================================
ArrayList<Figurine> readFigsJSON() {
  figurines.clear();
  ArrayList<Figurine> input = new ArrayList<Figurine>();
  JSONArray figsJSON = loadJSONArray("data/figs.JSON");
  Figurine f;

  for (int i = 0; i < figsJSON.size (); i++) {

    JSONObject curF = figsJSON.getJSONObject(i);

    f = new Figurine();//needed to initialise variables to be populated
    f.name = curF.getString("name");//populate name
    f.pos.x = curF.getFloat("x");//populate x pos
    f.pos.y = curF.getFloat("y");//populate y pos
    f.size.x = figSize.x;//populate width
    f.size.y = figSize.y;//populate height
    f.imageName = curF.getString("file");//populate file name
    f.img = loadImage(f.imageName);//load image and populate image
    //println(i);//print the array location (debugging)

    input.add(f);//add the new figurine to the arraylist
  }
  return input;
}
//------------------------------------------

ArrayList<Area> readAreasJSON() {
  areas.clear();//clear all existing carpets from screen
  ArrayList<Area> input = new ArrayList<Area>();//store all carpets
  ArrayList<PVector> verts;//store all vertices

    JSONArray areaJSON = loadJSONArray("data/areas.JSON");

  for (int i = 0; i < areaJSON.size (); i++) {//iterate through carpets list
    verts = new ArrayList<PVector>();//init. the vertices arraylist
    JSONObject area = areaJSON.getJSONObject(i);//store the carpet JSON input
    String roomName = area.getString("name");//store name of room

    JSONArray iVert = area.getJSONArray("vertices");//store the JSON vertices of the carpet

    for (int j = 0; j < iVert.size (); j++) {//for all vertices in the current carpet
      JSONObject vertex = iVert.getJSONObject(j);//get the vertex JSONObject from the JSONArray item
      PVector v = new PVector(vertex.getFloat("x"), vertex.getFloat("y"));//create new PVector to store values
      verts.add(v);//add new vertex to arraylist
    }     
    Area a = new Area(verts, roomName);//create new carpet with loaded vals.    
    input.add(a);//add new carpet to input list.
    verts.clear();//load vertices
  }
  return input;//return new list;
}
//------------------------------------------

JSONArray populateFigsJSON() {
  JSONArray output = new JSONArray();

  for (int i = 0; i < figurines.size (); i++) {
    Figurine f = figurines.get(i);

    JSONObject figurine = new JSONObject();

    figurine.setString("name", f.name);
    figurine.setFloat("x", f.pos.x);
    figurine.setFloat("y", f.pos.y);
    figurine.setFloat("w", f.size.x);
    figurine.setFloat("h", f.size.y);
    figurine.setString("file", f.imageName);//

    output.setJSONObject(i, figurine);//add to array
  }

  return output;
}
//------------------------------------------

//JSONArray populateWallsJSON() {
//  JSONArray output = new JSONArray();
//
//  if (walls.size() == 0) {
//  } else {
//    for (int i = 0; i < walls.size (); i++) {
//      Wall w = walls.get(i);
//
//      JSONObject wall = new JSONObject();
//
//      wall.setFloat("x", w.pos.x);
//      wall.setFloat("y", w.pos.y);
//      wall.setFloat("w", w.size.x);
//      wall.setFloat("h", w.size.y);
//
//      output.setJSONObject(i, wall);//add to array
//    }
//  }
//  return output;
//}
//------------------------------------------

JSONArray populateAreasJSON() {
  JSONArray output = new JSONArray();//store all carpets

  if (areas.size() != 0) {//if there are carpets
    for (int i = 0; i < areas.size (); i++) {//iterate through carpets list
      Area a = areas.get(i);//current carpet in use

      JSONObject area = new JSONObject();//store the carpet
      JSONArray vertices = new JSONArray();//store the vertices of the carpet

      for (int j = 0; j < a.vertices.size (); j++) {//for all vertices in the current carpet
        JSONObject v = new JSONObject();
        v.setFloat("x", a.vertices.get(j).x);
        v.setFloat("y", a.vertices.get(j).y);
        vertices.setJSONObject(j, v);
      }  

      area.setJSONArray("vertices", vertices);//add vertices to carpet JSON object
      area.setString("name", a.areaName);//add name of room to carpet JSON object

      output.setJSONObject(i, area);//add carpet JSON object to array
    }
  }
  return output;
}
//------------------------------------------

JSONArray [] genJSONs() {
  JSONArray toSave[] = new JSONArray[4];

  toSave[0] = populateFigsJSON();
  //toSave[1] = populateWallsJSON();
  toSave[2] = populateAreasJSON();

  return toSave;
}

void saveJSONs(JSONArray toSave[]) {
  saveJSONArray(toSave[0], "data/figs.JSON");
  //saveJSONArray(toSave[1], "data/walls.JSON");
  saveJSONArray(toSave[2], "data/areas.JSON");
}
//end of JSON input and output
//==========================================

