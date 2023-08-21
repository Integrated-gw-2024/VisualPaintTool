
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
