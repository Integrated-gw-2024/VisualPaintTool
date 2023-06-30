class Cell {  
  int col = 255;
  
  float scale = ellipseSize;
   
  float x = 0;
  float y = 0;
  
  Boolean toggleStatus = false;
  
  
  void render() {
    fill(col);
    ellipseMode(CORNER);
    ellipse(x, y, scale, scale);
  }
}
