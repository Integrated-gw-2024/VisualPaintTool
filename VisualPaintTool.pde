import java.awt.datatransfer.*;
import java.awt.Toolkit;

Boolean isViewCopiedText = false;
//float ellipseSize = 8;
float ellipseSize = 50;

Cell c;

ArrayList<Cell> cs;

int xEllipseLength = 0;
int yEllipseLength = 0;

String svgTag[] = new String[2];
String DOCTYPE = "<?xml version=\"1.0\" encoding=\"UTF-8\"?>";
String outputXML;

ArrayList<String> rectElements;


String MODE = "PEN";

void setup() {

  println(outputXML);

  println(DOCTYPE);
  println(svgTag);

  size(1100, 700);

  background(255);




  initCells();
}


void draw() {
  background(255);
  stroke(0);
  strokeWeight(0.01);

  for (int i=0; i<=cs.size()-1; i++) {
    c = cs.get(i);
    c.render();

    //fill(255,0,0,100);
    //rect(c.x,c.y,c.scale,c.scale);


    /*if (mouseX>cell.x && mouseX<cell.x+cell.scale) {
     if (mouseY>cell.y && mouseY<cell.y+cell.scale) {*/
  }

  noStroke();

  float space = 33;
  float szW = 180;
  float szH = 70;

  float textZabutonX = width-szW-space;
  float textZabutonY = space;
  fill(255);
  rect(textZabutonX, textZabutonY, szW, szH);



  float textSz = 15;
  float textSpaceX = 27;
  float textSpaceY = (textZabutonY)+textSz+16;
  noStroke();
  fill(0);
  textSize(textSz);


  text("mode:  " + MODE, textZabutonX+textSpaceX, textSpaceY);
  text("scale:  " + ellipseSize, textZabutonX+textSpaceX, textSpaceY+textSz+3);


  if (isViewCopiedText==true) {
    szH = 37;
    szW = 122;
    fill(255);
    rect(textZabutonX, height-szH-(10+10), szW, szH);



    noStroke();
    fill(0);
    textSize(textSz);


    text("[Copied!!]", textZabutonX+textSpaceX, (height-szH)+(13-10));
  }
}

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
  default:
    setClipboardCells();
  }
}

void mouseDragged() {
  toggleCellEntity();
}

void mousePressed() {
  isViewCopiedText = false;
  toggleCellEntity();
}

void mouseReleased() {
  for (Cell c : cs) {
    c.toggleStatus = false;
  }
}

void setClipboardCells() {
  svgTag[0] = "<svg id=\"kokoninamae\" xmlns=\"http://www.w3.org/2000/svg\" viewBox=\"0 0 2792.61 1041.11\">";
  svgTag[1] = "</svg>";

  rectElements = new ArrayList<String>();

  float scale = ellipseSize-(ellipseSize/2);
  String rectTag = "";


  for (Cell c : cs) {
    if (c.col!=255) {
      rectElements.add("<circle class=\"cls-1\" cx=\"" + c.x + "\" cy=\"" + c.y + "\" r=\"" + scale + "\" />");
    }
  }



  for (String str : rectElements) {
    rectTag += str;
  }

  outputXML = DOCTYPE + svgTag[0] + rectTag + svgTag[1];

  Clipboard cb = Toolkit.getDefaultToolkit().getSystemClipboard();
  StringSelection sel = new StringSelection(outputXML);
  cb.setContents(sel, null);

  isViewCopiedText = true;
}

void toggleCellEntity() {
  int csIndex = 0;
  for (Cell cell : cs) {
    if (mouseX>cell.x && mouseX<cell.x+cell.scale) {
      if (mouseY>cell.y && mouseY<cell.y+cell.scale) {
        println("  [x] " + cell.x + "  [y] " + cell.y + "  [col] " + cell.col + "  [index] " + csIndex);

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


void initCells() {

  cs = new ArrayList<Cell>();

  for (float y=0; y<height; y+=ellipseSize-(ellipseSize*0.13401)) {
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

  Cell c0 = cs.get(0);
  int num = 0;

  for (Cell c : cs) {
    float distance = dist(c0.x, c0.y, c.x, c.y);

    if (distance <= ellipseSize && num>1) {
      println("!!!   " + num);
      println(distance + "  " + ellipseSize);
    }
    num++;
  }
}
