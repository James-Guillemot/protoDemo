import geomerative.*;
import boofcv.processing.*;
import java.awt.*;
import java.awt.geom.*;
import java.awt.geom.Rectangle2D;


ArrayList<Figurine> figurines;//stores figurines in a list of Figurine type
//ArrayList<Wall> walls;//stores walls in a list of Wall type
ArrayList<Carpet> carpets;//stores carpets in a list of Carpet type
ArrayList<Button> buttons;//stores buttons in a list of Button type


Figurine currentFigurine;//stores an address to the figurine currently in use
Button currentButton;//stores an address to the figurine currently in use

PVector diff = new PVector(), figSize = new PVector(60, 110);//set global figurine size - remove or comment if individually sizing//store the size of all figurines - remove for individually sized figs

boolean figMoving = false;//is a figurine moving?

color bgColour, areaCol, lineCol;//colour of background for window
PImage bgImg;//background image
String bgFile = "bg.png";//store file name for background image - bg.png
//end of global variables and imports
//==========================================

//default setup and draw methods
//==========================================
void setup() {//set up the application
  RG.init(this);
  size(1400, 900);//set window size
  
  figurines = new ArrayList<Figurine>();//initialize figurines list
  //walls = new ArrayList<Wall>();//initialize walls list
  carpets = new ArrayList<Carpet>();//initialize walls list
  buttons = new ArrayList<Button>();//initialize walls list

  setupFigurines();//to reset the default figurines - currently not used as figs can be loaded!
  //setupWalls();//initial wall area
  //setupCarpets();//initial carpet areas
  setupGUI();//******
  
  currentFigurine = new Figurine();
  
  bgColour = color(random(255), random(255), random(255));//set a random colour to be the background
  areaCol = #FFFFFF;
  lineCol = #000000;
  //bgImg = loadImage(bgFile);//use this to set a background image

  rectMode(RADIUS);//position of a rectangle is measured from center rather than 0,0 of the rectangle
  imageMode(CENTER);//mirror this with the image mode
}
//------------------------------------------
void draw() {
  background(bgColour);
  fill (areaCol);
  stroke(lineCol);
  strokeWeight(2);
  rect(0, 0, 200, height);//draw area on left

    //image(bgImg, 0, 0);//used for background image

  /*for (Wall curWall : walls) {//for each figurine in the list
    curWall.display();//draw the current figurine (one by one)
  }*/
  for (Carpet curCarp : carpets) {//for each figurine in the list
    curCarp.display();//draw the current figurine (one by one)
  }
  for (Button curBut : buttons) {//for each figurine in the list
    curBut.display();//draw the current figurine (one by one)
  }
  for (Figurine curFig : figurines) {//for each figurine in the list
    curFig.checkRoom();  
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

  fred = new Figurine("Fred", 140, 60, figSize.x, figSize.y, "fred.png");
  figurines.add(fred);

  jassi = new Figurine("Jassi", 50, 180, figSize.x, figSize.y, "jassi.png");
  figurines.add(jassi);

  tilly = new Figurine("Tilly", 140, 180, figSize.x, figSize.y, "tilly.png");
  figurines.add(tilly);

  bill = new Figurine("Bill", 50, 300, figSize.x, figSize.y, "bill.png");
  figurines.add(bill);
}
//------------------------------------------

void setupCarpets() {//creates initial carpets
  Carpet c1, c2, c3;//stores figurines as objects
  ArrayList<PVector> a1 = new ArrayList<PVector>();
  ArrayList<PVector> a2 = new ArrayList<PVector>();
  //ArrayList<PVector> a3 = new ArrayList<PVector>();

  a1.add(new PVector(260, 50));
  a1.add(new PVector(760, 50));
  a1.add(new PVector(760, 280));
  a1.add(new PVector(460, 280));
  a1.add(new PVector(460, 480));
  a1.add(new PVector(260, 480));
  a1.add(new PVector(260, 50));

  //*********************************
  a2.add(new PVector(820, 50));
  a2.add(new PVector(1360, 50));
  a2.add(new PVector(1360, 285));
  a2.add(new PVector(1160, 285));
  a2.add(new PVector(1060, 400));
  a2.add(new PVector(1060, 485));
  a2.add(new PVector(820, 485));
  a2.add(new PVector(820, 50));
  //*********************************

  c1 = new Carpet(a1, "room 1");
  c2 = new Carpet(a2, "room 2");
  //c3 = new Carpet(a3, "room 3");

  carpets.add(c1);
  carpets.add(c2);
  //carpets.add(c3);
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
  //println(figMoving);
}
//------------------------------------------

void keyPressed() {
  switch(key) {
  default: 
    println("INVALID OPTION SELECTED! Press 'H' for key bindings"); 
    break;
  case 'q': 
    println("SAVED AND EXITED!"); 
    saveExit(); 
    break;
  case 'Q': 
    println("SAVED AND EXITED!"); 
    saveExit(); 
    break;
  case 'r': 
    println("LOADING ROOMS!"); 
    //walls = readWallsJSON(); 
    carpets = readCarpsJSON(); 
    break;
  case 'R': 
    println("LOADING ROOMS!"); 
    //walls = readWallsJSON(); 
    carpets = readCarpsJSON(); 
    break;
  case 'f': 
    println("LOADING FIGURINES!"); 
    figurines = readFigsJSON(); 
    break;
  case 'F': 
    println("LOADING FIGURINES!"); 
    figurines = readFigsJSON(); 
    break;
  case 'h': 
    println("Help: press 'R' to load rooms!");
    println("Press 'F' to load figurines!"); 
    println("Press 'Q' to quit and save figurines & rooms!"); 
    break;
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
    f.size.x = curF.getFloat("w");//populate width
    f.size.y = curF.getFloat("h");//populate height
    f.imageName = curF.getString("file");//populate file name
    f.img = loadImage(f.imageName);//load image and populate image
    //println(i);//print the array location (debugging)

    input.add(f);//add the new figurine to the arraylist
  }
  return input;
}
//------------------------------------------

//ArrayList<Wall> readWallsJSON() {
//  walls.clear();//clear walls list
//  ArrayList<Wall> input = new ArrayList<Wall>();
//  JSONArray wallJSON = loadJSONArray("data/walls.JSON");
//  Wall w;
//
//  for (int i = 0; i < wallJSON.size (); i++) {
//
//    JSONObject curW = wallJSON.getJSONObject(i);
//
//    w = new Wall();
//    w.pos.x = curW.getFloat("x");
//    w.pos.y = curW.getFloat("y");
//    w.size.x = curW.getFloat("w");
//    w.size.y = curW.getFloat("h"); 
//
//    input.add(w);
//  }
//  return input;
//}
//------------------------------------------

ArrayList<Carpet> readCarpsJSON() {
  carpets.clear();//clear all existing carpets from screen
  ArrayList<Carpet> input = new ArrayList<Carpet>();//store all carpets
  ArrayList<PVector> verts;//store all vertices

    JSONArray carpsJSON = loadJSONArray("data/carps.JSON");

  for (int i = 0; i < carpsJSON.size (); i++) {//iterate through carpets list
    verts = new ArrayList<PVector>();//init. the vertices arraylist
    JSONObject carpet = carpsJSON.getJSONObject(i);//store the carpet JSON input
    String roomName = carpet.getString("name");//store name of room

    JSONArray iVert = carpet.getJSONArray("vertices");//store the JSON vertices of the carpet

    for (int j = 0; j < iVert.size (); j++) {//for all vertices in the current carpet
      JSONObject vertex = iVert.getJSONObject(j);//get the vertex JSONObject from the JSONArray item
      PVector v = new PVector(vertex.getFloat("x"), vertex.getFloat("y"));//create new PVector to store values
      verts.add(v);//add new vertex to arraylist
    }     
    Carpet c = new Carpet(verts, roomName);//create new carpet with loaded vals.    
    input.add(c);//add new carpet to input list.
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

JSONArray populateCarpsJSON() {
  JSONArray output = new JSONArray();//store all carpets

  if (carpets.size() != 0) {//if there are carpets
    for (int i = 0; i < carpets.size (); i++) {//iterate through carpets list
      Carpet c = carpets.get(i);//current carpet in use

      JSONObject carpet = new JSONObject();//store the carpet
      JSONArray vertices = new JSONArray();//store the vertices of the carpet

      for (int j = 0; j < c.vertices.size (); j++) {//for all vertices in the current carpet
        JSONObject v = new JSONObject();
        v.setFloat("x", c.vertices.get(j).x);
        v.setFloat("y", c.vertices.get(j).y);
        vertices.setJSONObject(j, v);
      }  

      carpet.setJSONArray("vertices", vertices);//add vertices to carpet JSON object
      carpet.setString("name", c.roomName);//add name of room to carpet JSON object

      output.setJSONObject(i, carpet);//add carpet JSON object to array
    }
  }
  return output;
}
//------------------------------------------

JSONArray [] genJSONs() {
  JSONArray toSave[] = new JSONArray[4];

  toSave[0] = populateFigsJSON();
  //toSave[1] = populateWallsJSON();
  toSave[2] = populateCarpsJSON();

  return toSave;
}

void saveJSONs(JSONArray toSave[]) {
  saveJSONArray(toSave[0], "data/figs.JSON");
  //saveJSONArray(toSave[1], "data/walls.JSON");
  saveJSONArray(toSave[2], "data/carps.JSON");
}
//end of JSON input and output
//==========================================

