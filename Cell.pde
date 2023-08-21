class Cell {
  int col = 255;
  int num;

  float scale = ellipseSize;

  float x = 0;
  float y = 0;

  Boolean toggleStatus = false;


  void render() {
    fill(col);
    ellipseMode(CORNER);
    ellipse(x, y, scale, scale);
  }

  void invertColor() {
    if (col==255) {
      col=0;
    } else if (col==0) {
      col=255;
    }
  }
}
