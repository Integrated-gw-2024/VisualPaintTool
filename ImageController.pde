PImage img;
float imgX;
float imgY;

class ImageController {
  String mode = "";
  
  void imgClear(){
    img = null;
    imgPath = null;
  }


  void loadImg() {
    if (isDrop && (500<millis()-dropMillis)) {

      img = loadImage( imgPath );

      if (img.height>img.width) {
        targetHeight = height;
        aspectRatio = (float) img.width / img.height;

        targetWidth = aspectRatio * targetHeight;
      } else {
        targetWidth = width;
        aspectRatio = (float) img.height / img.width;

        targetHeight = aspectRatio * targetWidth;
      }

      isDragEnter = false;
      isDrop = false;
    }
  }

  void setMode(String str) {
    mode = str;
  }

  void displayImage() {
    if (img!=null) {
      float aspectRatio = (float) img.width / img.height;
      //float aspectRatio = (float) 600 / 800;
      float targetWidth = aspectRatio * targetHeight;
      //rect(imgX, 0, targetWidth, targetHeight);
      imageMode(CENTER);
      tint( 255.0, 140 );
      image(img, imgX, imgY, targetWidth, targetHeight);
    }
  }

  void displayDragEnterScene() {
    if (isDragEnter) {
      cursor(WAIT);
      fill(0, 0, 0, 200);
      rect(0, 0, width, height);
      fill(255);
      int textSZ = 50;
      textSize(textSZ);
      float offsetY = 10;
      text("image:", 30, 20+offsetY, width-100, height-50);

      textLeading(textSZ+10);
      if (imgPath != null) {
        text(""+imgPath, 30, textSZ+80+offsetY, width/1.1, height-50);
      }
    } else {
      cursor(ARROW);
    }
  }
}
