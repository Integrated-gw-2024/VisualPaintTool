void toggleCellEntity() {
  int csIndex = 0;
  for (Cell cell : cs) {
    if (mouseX>cell.x && mouseX<cell.x+cell.scale) {
      if (mouseY>cell.y && mouseY<cell.y+cell.scale) {
        println("  [x] " + cell.x + "  [y] " + cell.y + "  [col] " + cell.col + "  [index] " + cell.num);

        if (!cell.toggleStatus) {
          if (!(cell.col==255 && MODE == "ERASER")) {
            println("aaa");
            ch.history.add(cell.num);
          }
          
          if ((cell.col==0 && MODE == "PEN")) {
            println("aaa");
            ch.history.add(cell.num);
          }
        }

        if (cell.col==255 && MODE == "PEN") {
          cell.col = 0;
        } else if (cell.col==0 && MODE == "ERASER") {
          cell.col = 255;
        }

        cell.toggleStatus = true;
        cs.set(csIndex, cell);

        cs.get(csIndex).render();
        println(cs.get(csIndex).col);
      }
    }
    csIndex++;
  }
}