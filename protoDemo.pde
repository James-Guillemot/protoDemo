ArrayList<Figurine> figurines;//stores figurines in a list of Figurine type
ArrayList<Wall> walls;//stores walls in a list of Wall type
ArrayList<Button> buttons;//stores walls in a list of Wall type

Figurine currentFigurine;//stores an address to the figurine currently in use
Button currentButton;//stores an address to the figurine currently in use

PVector diff = new PVector(), figSize = new PVector(60, 110);//set global figurine size - remove or comment if individually sizing//store the size of all figurines - remove for individually sized figs

boolean figMoving = false;//is a figurine moving?

color bgColour;//colour of background for window
PImage bgImg;//background image
String bgFile = "bg.png";//store file name for background image - bg.png
//end of global variables and imports
//==========================================

//default setup and draw methods
//==========================================
void setup(){//set up the application
  figurines = new ArrayList<Figurine>();//initialize figurines list
  walls = new ArrayList<Wall>();//initialize walls list
  buttons = new ArrayList<Button>();//initialize walls list

 // setupFigurines();
  //setupWalls();//******
  setupGUI();//******
  
  size(1440, 900);//set window size
   currentFigurine = new Figurine();
  bgColour = color(random(255), random(255), random(255));//set a random colour to be the background
  //bgImg = loadImage(bgFile);//use this to set a background image
  
  rectMode(RADIUS);//position of a rectangle is measured from center rather than 0,0 of the rectangle
  imageMode(CENTER);//mirror this with the image mode
}
//------------------------------------------
void draw() {
  background(bgColour);
  rect(0,0,200,height);
  
  //image(bgImg, 0, 0);//used for background image
  
  /*for (Wall curWall : walls){//for each figurine in the list
    curWall.display();//draw the current figurine (one by one)
  }*/
  for (Button curBut : buttons){//for each figurine in the list
    curBut.display();//draw the current figurine (one by one)
  }
  for (Figurine curFig : figurines){//for each figurine in the list
    curFig.display();//draw the current figurine (one by one)
  }
}
//==========================================

//program setup 
//==========================================
void setupFigurines(){//creates figurines --will not be used when figurines are stored in JSON for initialisation too
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

void setupGUI(){//generates a GUI    --store buttons in JSON too
  //Button addFig = new Button(100, 900-50, 50, 15, "Add");
  //buttons.add(addFig);
}
//end of program setup
//==========================================

//menu and actions
//==========================================
void saveExit(){
  saveJSONs(genJSONs());//save generated JSON files
  exit();//stop runtime
}
//==========================================

//action handlers
//==========================================
void mousePressed() {
  for (Figurine curFig : figurines){//for each figurine in the list
    if (curFig.mouseIn()){
      figMoving=true; 
      currentFigurine = curFig;
      diff.x = mouseX - currentFigurine.pos.x;
      diff.y = mouseY - currentFigurine.pos.y;
    }
  }
  for (Button curBut : buttons){//for each figurine in the list
    if (curBut.mouseIn()){
      //curBut
    }
  }
}
//------------------------------------------
void mouseDragged() {
  if (figMoving){
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

void keyPressed(){
  switch(key){
    default: println("INVALID OPTION SELECTED! Press 'H' for key bindings"); break;
    case 'q': println("SAVED AND EXITED!"); saveExit(); break;
    case 'w': println("LOADING WALLS!"); readWallsJSON(); break;
    case 'f': println("LOADING FIGURINES!"); figurines = readFigsJSON(); break;
  } 
}
//end of action handlers
//==========================================

//JSON input and output
//==========================================
ArrayList<Wall> readWallsJSON(){
  ArrayList<Wall> input = new ArrayList<Wall>();
  JSONArray wallJSON = loadJSONArray("data/wall.JSON");
  Wall w = new Wall();

  for (int i = 0; i < wallJSON.size(); i++) {

    JSONObject curW = wallJSON.getJSONObject(i);

    w.pos.x = curW.getFloat("x");
    w.pos.y = curW.getFloat("y");
    w.size.x = curW.getFloat("w");
    w.size.y = curW.getFloat("h"); 
    
    input.add(w);
  }
  return input;
}
//------------------------------------------

ArrayList<Figurine> readFigsJSON(){
  ArrayList<Figurine> input = new ArrayList<Figurine>();
  JSONArray figsJSON = loadJSONArray("data/figs.JSON");
  Figurine f;

  for (int i = 0; i < figsJSON.size(); i++) {
  
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

JSONArray populateFigsJSON(){
  JSONArray output = new JSONArray();
  
  for (int i = 0; i < figurines.size(); i++) {
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

JSONArray populateWallsJSON(){
  JSONArray output = new JSONArray();
  
  if (walls.size() == 0){}else{
  for (int i = 0; i < figurines.size(); i++) {
    Wall w = walls.get(i);
    
    JSONObject wall = new JSONObject();

    wall.setFloat("x", w.pos.x);
    wall.setFloat("y", w.pos.y);
    wall.setFloat("w", w.size.x);
    wall.setFloat("h", w.size.y);

    output.setJSONObject(i, wall);//add to array
  }
  }
  return output;
}
//------------------------------------------

JSONArray [] genJSONs(){
  JSONArray toSave[] = new JSONArray[2];
  
  toSave[0] = populateFigsJSON();
  toSave[1] = populateWallsJSON();

  return toSave;
}

void saveJSONs(JSONArray toSave[]){
  saveJSONArray(toSave[0], "data/figs.JSON");
 // saveJSONArray(toSave[1], "data/walls.JSON");//not ready to be used  
}
//end of JSON input and output
//==========================================




