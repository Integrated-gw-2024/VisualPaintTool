class Cell {

  int col = 255;
  
  float scale = 40;
  
  float x = 0;
  float y = 0;
  
  
  void render() {
    fill(col);
    ellipseMode(CORNER);
    ellipse(x, y, scale, scale);
  }
}
