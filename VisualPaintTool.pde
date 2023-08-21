import java.awt.datatransfer.*;
import java.awt.Toolkit;
import java.util.ArrayDeque;

Boolean isViewCopiedText = false;
Boolean hasPressedCtrl = false;
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



ArrayDeque<CellsHistory> undoHistory = new ArrayDeque<>();
ArrayDeque<CellsHistory> redoHistory = new ArrayDeque<>();
CellsHistory ch = new CellsHistory();


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


