class Button{//store buttons to display on screen
  PVector pos;//store button position
  PVector size;//store button size
  String text;//store button text
  PImage bg;//store image for background
  color lineCol = #000000, bgCol = #FF0000, textCol = #FFFFFF;//store line and background fill colour
  
  Button(){}

  Button(int ix, int iy, float iw, float ih, String iText, String iFile, color iLine, color iFill) {
    pos = new PVector(ix, iy);//set position to incoming values.
    size = new PVector(iw, ih);//set size to incoming values.
    lineCol = iLine;//set line colour to incoming col.
    bgCol = iFill;//set line colour to incoming col.
    if (iFile != "" && iFile != null){bg = loadImage(iFile);} else {bg = null;}
    if (iText != "" && iText != null){text = iText;}
  }

  Button(int ix, int iy, float iw, float ih, String iText, color iLine, color iFill) {
    pos = new PVector(ix, iy);//set position to incoming values.
    size = new PVector(iw, ih);//set size to incoming values.
    lineCol = iLine;//set line colour to incoming col.
    bgCol = iFill;//set line colour to incoming col.
    if (iText != "" && iText != null){text = iText;}
   }
  
  Button(int ix, int iy, float iw, float ih, String iText){
    //println("x: " + ix + " y: " + iy);
    pos = new PVector(ix, iy);//set position to incoming values.
    size = new PVector(iw, ih);//set size to incoming values.
    if (iText != "" && iText != null){text = iText;}  
  }

  void display(){
    fill(bgCol);
    stroke(lineCol);
    strokeWeight(2);
    rect(pos.x, pos.y, size.x, size.y);//otherwise draw my background colour
    if (bg != null){image(bg, pos.x, pos.y, size.x/2, size.y/2);}//if I have a background image, use that on top
    fill(textCol);
    textSize(18);textAlign(CENTER, CENTER);
    text(text, pos.x, pos.y, size.x, size.y);    
    fill(#FFFFFF);
  }

  boolean mouseIn() {
    //println("checking if in");
    if(mouseX > pos.x - size.x /*if within x bounds*/
    && mouseX < pos.x + size.x 
    && mouseY > pos.y - size.y /*if within y bounds*/
    && mouseY < pos.y + size.y) 
    {/*println("Mouse IS IN");*/ return true; }//mouse in me
    else{/*println("Mouse NOT in");*/ return false;}//mouse not in me
  } 
  
}//end class Button
