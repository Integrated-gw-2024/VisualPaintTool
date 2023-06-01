float ellipseSize = 30;

Cell c;

ArrayList<Cell> cs;

int xEllipseLength = 0;
int yEllipseLength = 0;

void setup() {

  size(600, 600);

  background(255);


  cs = new ArrayList<Cell>();



  for (int y=0; y<height; y+=ellipseSize) {
    for (int x=0; x<width; x+=ellipseSize) {
      c = new Cell();


      println(yEllipseLength + " " + yEllipseLength%2);
      if(yEllipseLength % 2 != 0){
        c.x = x;
      }else{
        c.x = x-(ellipseSize/2);
      }
      
      c.y = y;

      c.scale = ellipseSize;

      c.col = 255;

      println(xEllipseLength);

      cs.add(c);
      xEllipseLength++;
    }
    yEllipseLength++;
  }
}


void draw() {
  background(255);
  for (int i=0; i<=cs.size()-1; i++) {
    cs.get(i).render();
  }
}

void mouseDragged() {

  int csIndex = 0;
  for (Cell cell : cs) {
    if (mouseX>cell.x && mouseX<cell.x+cell.scale) {
      if (mouseY>cell.y && mouseY<cell.y+cell.scale) {
        println("  [x] " + cell.x + "  [y] " + cell.y + "  [col] " + cell.col + "  [index] " + csIndex);
        
        if(cell.col==255){
          cell.col = 0;
        }else{
          cell.col = 255;
        }
        cs.set(csIndex,cell);
        cs.get(csIndex).render();
        println(cs.get(csIndex).col);
      }
    }
    csIndex++;
  }
}
