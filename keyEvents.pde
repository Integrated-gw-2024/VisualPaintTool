Boolean hasPressedShift = false;

void keyPressed() {
  /*if (keyCode==38) {
   targetHeight += 10;
   } else if (keyCode==40) {
   targetHeight -= 10;
   }*/
  

  if (keyCode==ctrlCode) {
    hasPressedCtrl = true;
  }


  switch(keyCode) {
  case 51:
    MODE = "IMAGE";
    break;
  case 81:
    if (MODE=="IMAGE" && imgPath != null) {
      imgcon.setMode("SCALE");
    }
    break;
  case 87:
    if (MODE=="IMAGE" && imgPath != null) {
      imgcon.setMode("MOVE");
    }
    break;
  case 49:
    //1
    MODE = "PEN";
    break;
  case 50:
    MODE = "ERASER";
    break;
  case 38:
    ellipseSize += 1;
    initCells();
    break;
  case 40:
    if (ellipseSize>4) {
      ellipseSize -= 1;
      initCells();
    }
    break;
  case 16:
    hasPressedShift = true;
    break;
  case 90:
    if (hasPressedShift && hasPressedCtrl) {
      if (redoHistory.size()!=0) {
        for (Integer i : redoHistory.peekLast().history) {
          Cell c = cs.get(i);
          c.invertColor();
          cs.set(c.num, c);
        }
        undoHistory.add(redoHistory.peekLast());
        redoHistory.removeLast();
      }
    } else if (hasPressedCtrl && undoHistory.size()!=0) {
      for (Integer i : undoHistory.peekLast().history) {
        Cell c = cs.get(i);
        c.invertColor();
        cs.set(c.num, c);
      }
      redoHistory.add(undoHistory.peekLast());
      undoHistory.removeLast();
    }
    break;
  default:
    setClipboardCells();
  }
}

void keyReleased() {
  if (keyCode==ctrlCode) {
    hasPressedCtrl = false;
  }

  if (keyCode==16) {
    hasPressedShift = false;
  }
}
