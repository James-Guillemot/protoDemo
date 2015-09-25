ArrayList<Figurine> figurines;//stores figurines in a list of Figurine type
JSONArray figsJSON;
Figurine tom, fred, jassi, tilly, bill, currentFigurine;//stores figurines as objects

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
  populateJSON();
  saveJSONArray(figsJSON, "data/figurines.JSON");
  exit();
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
  
//println(figMoving);
 ///if(overBox) { 
  //  locked = true; 
 //   fill(255, 255, 255);
  //} else {
 //   locked = false;
 // }
 // diff.x = mouseX-bx; 
  ///////diff.y = mouseY-by; 
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
void readJSON(){
  
}

void populateJSON(){
  figsJSON = new JSONArray();
  
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
}

void keyPressed(){
  if (key == 'q'){
     println("SAVED AND EXITED!");
     saveExit(); 
  } 
  
}



