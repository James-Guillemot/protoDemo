class Button{//store characters to display on screen
  PVector pos;
  PVector size;
  String text;
  PImage bg;
  color lineCol, bgCol;
  
  Button(){}

  Button(int ix, int iy, float iw, float ih, String iText, String iFile) {
    pos = new PVector(ix, iy);
    size = new PVector(iw, ih);
    if (iFile != "" && iFile != null){bg = loadImage(iFile);} else {bg = null;}
    text = iText;
  }

  void display(){
    fill(bgCol);
    stroke(lineCol);
    rect(pos.x, pos.y, size.x, size.y);//otherwise draw my background colour
    if (bg != null){image(bg, pos.x, pos.y, size.x, size.y);}//if I have a background image, use that on top
    if (text != "" && text != null){text(text, pos.x-size.x/2 + 5, pos.y, size.x, size.y);}    
  }

  boolean mouseIn() {
    if(mouseX > pos.x - size.x/2 /*if within x bounds*/
    && mouseX < pos.x + size.x/2 
    && mouseY > pos.y - size.y/2 /*if within y bounds*/
    && mouseY < pos.y + size.y/2) 
    {return true;}//mouse in me
    else{return false;}//mouse not in me
  } 
  
}//end class Button
