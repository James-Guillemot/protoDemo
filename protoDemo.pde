ArrayList<Figurine> figurines;//stores figurines in a list of Figurine type
ArrayList<Wall> walls;//stores walls in a list of Wall type

Figurine currentFigurine;//stores an address to the figurine currently in use

PVector figSize = new PVector(60, 110);//set global figurine size - remove or comment if individually sizing//store the size of all figurines - remove for individually sized figs
PVector diff;

boolean figMoving = false;

color bgColour;//colour of background for window
PImage bgImg;//background image
String bgFile = "bg.png";//store file name for background image - bg.png

void setup(){//set up the application
  setupFigurines();
  
  size(1440, 900);//set window size
   currentFigurine = new Figurine();
  bgColour = color(random(255), random(255), random(255));//set a random colour to be the background
  //bgImg = loadImage(bgFile);//use this to set a background image
  
  rectMode(RADIUS);//position of a rectangle is measured from center rather than 0,0 of the rectangle
  imageMode(CENTER);//mirror this with the image mode
}

void draw() {
  background(bgColour);
  rect(0,0,200,height);
  
  //image(bgImg, 0, 0);//used for background image
  
  for (Figurine curFig : figurines){//for each figurine in the list
    curFig.display();//draw the current figurine (one by one)
  }
}

void setupFigurines(){
  Figurine tom, fred, jassi, tilly, bill//stores figurines as objects
  
  figurines = new ArrayList<Figurine>();//initialize figurines list
  
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

void saveExit(){
  saveJSONs(genJSONs());//save generated JSON files
  exit();//stop runtime
}

void mousePressed() {
  for (Figurine curFig : figurines){//for each figurine in the list
    if (curFig.mouseIn()){
      figMoving=true; 
      currentFigurine = curFig;
      diff.x = mouseX - currentFigurine.pos.x;
      diff.y = mouseY - currentFigurine.pos.y;
    }
  }
}
void mouseDragged() {
  if (figMoving){
    currentFigurine.pos.x = mouseX-diff.x; 
    currentFigurine.pos.y = mouseY-diff.y; 
  }
}
void mouseReleased() {
  figMoving=false;
 //println(figMoving);

}
ArrayList<Wall> readBgJSON(){
  ArrayList<Wall> input = new ArrayList<Wall>();
  JSONArray figsJSON = new JSONArray();
  
  for (int i = 0; i < figurines.size(); i++) {
    Figurine f = figurines.get(i);
    
    JSONObject figurine = new JSONObject();

    figurine.setString("name", f.name);
    figurine.setFloat("x", f.pos.x);
    figurine.setFloat("y", f.pos.y);
    figurine.setFloat("w", f.size.x);
    figurine.setFloat("h", f.size.y);
    figurine.setString("file", f.imageName);//

    figsJSON.setJSONObject(i, figurine);//add to array
    
  }
  return input;
}

ArrayList<Figurine> readFigJSON(){
  ArrayList<Figurine> input = new ArrayList<Figurine>();
  JSONArray figsJSON = new JSONArray();
  
  for (int i = 0; i < figurines.size(); i++) {
    Figurine f = figurines.get(i);
    
    JSONObject figurine = new JSONObject();

    figurine.setString("name", f.name);
    figurine.setFloat("x", f.pos.x);
    figurine.setFloat("y", f.pos.y);
    figurine.setFloat("w", f.size.x);
    figurine.setFloat("h", f.size.y);
    figurine.setString("file", f.imageName);//

    figsJSON.setJSONObject(i, figurine);//add to array
    
  }
  return input;
}

JSONArray populateFigsJSON(){
  JSONArray figsJSON = new JSONArray();
  
  for (int i = 0; i < figurines.size(); i++) {
    Figurine f = figurines.get(i);
    
    JSONObject figurine = new JSONObject();

    figurine.setString("name", f.name);
    figurine.setFloat("x", f.pos.x);
    figurine.setFloat("y", f.pos.y);
    figurine.setFloat("w", f.size.x);
    figurine.setFloat("h", f.size.y);
    figurine.setString("file", f.imageName);//

    figsJSON.setJSONObject(i, figurine);//add to array
  }
  
  return figsJSON;
}

JSONArray populateWallsJSON(){
  JSONArray wallsJSON = new JSONArray();
  
  for (int i = 0; i < figurines.size(); i++) {
    Wall w = walls.get(i);
    
    JSONObject wall = new JSONObject();

    figurine.setFloat("x", f.pos.x);
    figurine.setFloat("y", f.pos.y);
    figurine.setFloat("w", f.size.x);
    figurine.setFloat("h", f.size.y);

    figsJSON.setJSONObject(i, wall);//add to array
  }
  
  return wallsJSON;
}

JSONArray [] genJSONs(){
  JSONArray toSave[] = new JSONArray[2];
  
  toSave[0] = populateFigsJSON();
  toSave[1] = populateWallsJSON();

  return toSave;
}

void saveJSONs(JSONArray toSave[]){
  saveJSONArray(toSave[0], "data/figurines.JSON");
  saveJSONArray(toSave[1], "data/walls.JSON");  
}

void keyPressed(){
  switch(key){
    default: println("INVALID OPTION SELECTED! Press 'H' for key bindings"); break;
    case 'q': println("SAVED AND EXITED!"); saveExit(); break;
    case 'b': println("LOADING BACKGROUND!"); readBgJSON(); break;
    case 'f': println("SAVED AND EXITED!"); figurines = readFigJSON(); break;
  } 
  
}



