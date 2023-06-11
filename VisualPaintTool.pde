import java.awt.datatransfer.*;
import java.awt.Toolkit;

float ellipseSize = 30;

Cell c;

ArrayList<Cell> cs;

int xEllipseLength = 0;
int yEllipseLength = 0;

String svgTag[] = new String[2];
String DOCTYPE = "<?xml version=\"1.0\" encoding=\"UTF-8\"?>";
String outputXML;

ArrayList<String> rectElements;


void setup() {


  println(outputXML);

  println(DOCTYPE);
  println(svgTag);

  size(600, 600);

  background(255);


  cs = new ArrayList<Cell>();



  for (int y=0; y<height; y+=ellipseSize-4) {
    for (int x=0; x<width; x+=ellipseSize) {
      c = new Cell();


      //println(yEllipseLength + " " + yEllipseLength%2);
      if (yEllipseLength % 2 != 0) {
        c.x = x;
      } else {
        c.x = x-(ellipseSize/2);
      }

      c.y = y;

      c.scale = ellipseSize;

      c.col = 255;

      //println(xEllipseLength);

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

void keyPressed(){
  setClipboardCells();
}

void mouseDragged() {

  int csIndex = 0;
  for (Cell cell : cs) {
    if (mouseX>cell.x && mouseX<cell.x+cell.scale) {
      if (mouseY>cell.y && mouseY<cell.y+cell.scale) {
        println("  [x] " + cell.x + "  [y] " + cell.y + "  [col] " + cell.col + "  [index] " + csIndex);

        if (cell.col==255) {
          cell.col = 0;
        } else {
          cell.col = 255;
        }
        cs.set(csIndex, cell);
        cs.get(csIndex).render();
        println(cs.get(csIndex).col);
      }
    }
    csIndex++;
  }
}

void setClipboardCells() {
  svgTag[0] = "<svg id=\"kokoninamae\" xmlns=\"http://www.w3.org/2000/svg\" viewBox=\"0 0 2792.61 1041.11\">";
  svgTag[1] = "</svg>";

  rectElements = new ArrayList<String>();
  
  float scale = 20-5;
  String rectTag = "";


  for(Cell c : cs){
    if(c.col!=255){
      rectElements.add("<circle class=\"cls-1\" cx=\"" + c.x + "\" cy=\"" + c.y + "\" r=\"" + scale + "\" />");
    }
  }
  

  
  for(String str : rectElements){
    rectTag += str;
  }  
  
  outputXML = DOCTYPE + svgTag[0] + rectTag + svgTag[1];

  Clipboard cb = Toolkit.getDefaultToolkit().getSystemClipboard();
  StringSelection sel = new StringSelection(outputXML);
  cb.setContents(sel, null);
  
  println("図形をコピーしました！");
}
