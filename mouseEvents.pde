void mouseDragged() {
  toggleCellEntity();
}

void mousePressed() {
  isViewCopiedText = false;
  toggleCellEntity();
  //undoHistory.add(differentCellNums);
  //differentCellNums.clear();
}

void mouseReleased() {
  for (Cell c : cs) {
    c.toggleStatus = false;
  }

  undoHistory.add(ch);
  ch = new CellsHistory();
  
  
  println("mouseReleased");
}
