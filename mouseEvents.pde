float firstClickX, firstClickY;
Boolean isMouseReleased;

void mouseDragged() {
  
  if(MODE!="IMAGE"){
    toggleCellEntity();
  }
  
  if (MODE=="IMAGE" && imgcon.mode == "MOVE") {
    imgX = mouseX;
    imgY = mouseY;
  }
  if (MODE=="IMAGE" && imgcon.mode == "SCALE") {
    float d = firstClickX - mouseX;
    float val = d/40;


    println(val);
    targetHeight += val;
  }
}

void mousePressed() {
  isMouseReleased = false;
  
  isViewCopiedText = false;
  redoHistory.clear();
  
  if(MODE!="IMAGE"){
    toggleCellEntity();
  }
  
  
  
  if (imgcon.mode == "moveImageMode") {
    cursor(HAND);
    imgX = mouseX;
    imgY = mouseY;
  }
  
  if (imgcon.mode == "scaleImageMode") {
    noCursor();
  }

  firstClickX = mouseX;
  firstClickY = mouseY;
}

void mouseReleased() {
  for (Cell c : cs) {
    c.toggleStatus = false;
  }

  undoHistory.add(ch);
  ch = new CellsHistory();
  
  
  println("mouseReleased");
  
  
  isMouseReleased = true;
  cursor(ARROW);
}
