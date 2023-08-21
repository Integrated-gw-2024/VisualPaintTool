void initCells() {

  cs = new ArrayList<Cell>();

  for (float y=0; y<height; y+=ellipseSize-(ellipseSize*0.13401)) {
    for (int x=0; x<width; x+=ellipseSize) {
      c = new Cell();

      c.num = cs.size();


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
