import java.awt.datatransfer.*;
import java.awt.dnd.*;
import java.awt.Toolkit;
import java.io.File;
import java.io.IOException;
import java.awt.Component;
import java.util.List;
import java.util.ArrayDeque;

Boolean isViewCopiedText = false;
Boolean hasPressedCtrl = false;
//float ellipseSize = 8;
float ellipseSize = 50;
DropTarget dropTarget;

Cell c;

ArrayList<Cell> cs;

int xEllipseLength = 0;
int yEllipseLength = 0;

String svgTag[] = new String[2];
String DOCTYPE = "<?xml version=\"1.0\" encoding=\"UTF-8\"?>";
String outputXML;

ArrayList<String> rectElements;


String MODE = "PEN";

//Boolean moveImageMode = false;
//Boolean scaleImageMode = false;
Boolean isDragEnter = false;
Boolean isDrop = false;

String imgPath;
float dropMillis;

ArrayDeque<CellsHistory> undoHistory = new ArrayDeque<>();
ArrayDeque<CellsHistory> redoHistory = new ArrayDeque<>();
CellsHistory ch = new CellsHistory();

float aspectRatio;
float targetWidth;
float targetHeight;

Boolean moveImageMode = false;
Boolean scaleImageMode = false;

ImageController imgcon = new ImageController();


Boolean isWinOS = System.getProperty("os.name").startsWith("Win");
int ctrlCode;


void setup() {
  
  if (isWinOS==true) {
    println("win");
    ctrlCode = 17;
  } else {
    println("mac");
    ctrlCode = 157;
  }
  
  textFont(createFont("IBMPlexSansJP-Regular.ttf", 48));

  imgX = width/2;
  imgY = height/2;

  println(outputXML);

  println(DOCTYPE);
  println(svgTag);

  size(1100, 700);

  background(255);

  DragAndDrop();


  initCells();
}


void draw() {
  background(255);
  stroke(0);
  strokeWeight(0.01);

  imgcon.displayImage();

  for (int i=0; i<=cs.size()-1; i++) {
    c = cs.get(i);
    c.render();
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

  if (MODE=="IMAGE") {
    szH = 50;
    szW = 220;
    fill(255);
    rect(textZabutonX-szW-24, textZabutonY, szW, szH);

    noStroke();
    fill(0);
    textSize(textSz);

    text("image mode:  " + imgcon.mode, textZabutonX-szW, textSpaceY);

    if (imgPath != null) {
      szH = 37;
      szW = 37;
      fill(255);

      textZabutonX -= szW-24;

      textZabutonX += 180-szW;
      textZabutonY = height-szH-(10+10);
      rect(textZabutonX, textZabutonY, szW, szH);

      noStroke();
      fill(0);
      textSize(textSz);
      text("[x]", textZabutonX+10, (height-szH)+(13-10));

      if (mousePressed) {
        if (mouseX>textZabutonX && mouseX<(textZabutonX)+szW) {
          if (mouseY>textZabutonY && mouseY<textZabutonY+szH) {
            imgcon.imgClear();
          }
        }
      }
    }
  }




  if (isViewCopiedText==true) {
    szH = 37;
    szW = 122;
    fill(255);

    textZabutonX = width-szW-space - (122/2) + 3;

    rect(textZabutonX, height-szH-(10+10), szW, szH);

    noStroke();
    fill(0);
    textSize(textSz);

    text("[Copied!!]", textZabutonX+textSpaceX, (height-szH)+(13-10));
  }

  imgcon.loadImg();



  stroke(0);
  if (MODE=="IMAGE" && imgcon.mode=="SCALE" && !isMouseReleased) {
    strokeWeight(1);
    line(firstClickX, firstClickY, mouseX, mouseY);

    stroke(255);
    strokeWeight(1);
    fill(0);
    ellipseMode(CENTER);
    ellipse(mouseX, mouseY, 20, 20);
    ellipseMode(CORNER);
    noFill();
  }
  noStroke();


  imgcon.displayDragEnterScene();
}
