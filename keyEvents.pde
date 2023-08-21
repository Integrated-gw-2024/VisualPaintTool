void keyPressed() {
  println(keyCode);


  switch(keyCode) {
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
  case 157:
    hasPressedCtrl = true;
    break;
  case 90:
    if (hasPressedCtrl == true) {
      //undoHistory.removeLast();

      println(undoHistory.size());

      for (Integer i : undoHistory.peekLast().history) {
        Cell c = cs.get(i);

        if (c.col==255) {
          c.col = 0;
        }

        if (c.col==0) {
          c.col = 255;
        }

        cs.set(c.num, c);
      }

      undoHistory.removeLast();

      //Cell c = undoHistory.peekLast();



      //println("num  " + cs.get(c.num).num);
    }
    break;
  default:
    setClipboardCells();
  }
}

void keyReleased() {
  if (keyCode==157) {
    hasPressedCtrl = false;
  }
}
