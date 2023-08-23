DropTarget dt;
Component component;

void DragAndDrop() {
  component = (Component)this.surface.getNative();

  dt = new DropTarget(component, new DropTargetListener() {
    public void dragEnter(DropTargetDragEvent dtde) {
      isDragEnter = true;
    }
    public void dragOver(DropTargetDragEvent dtde) {
      isDragEnter = true;
    }
    public void dropActionChanged(DropTargetDragEvent dtde) {
    }
    public void dragExit(DropTargetEvent dte) {
      isDragEnter = false;
    }
    public void drop(DropTargetDropEvent dtde) {
      try {
        dtde.acceptDrop(DnDConstants.ACTION_COPY_OR_MOVE);
        Transferable trans = dtde.getTransferable();

        if (trans.isDataFlavorSupported(DataFlavor.javaFileListFlavor)) {
          dtde.acceptDrop(DnDConstants.ACTION_COPY);
          List<File> fileList = (List<File>)trans.getTransferData(DataFlavor.javaFileListFlavor);

          for (File file : fileList) {
            imgPath = file.getAbsolutePath();
            println(imgPath);
          }
          dropMillis = millis();
          MODE = "IMAGE";
        } else {
          dtde.rejectDrop();
        }
      }
      catch(Exception e) {
        dtde.rejectDrop();
      }
      isDrop = true;
    }
  }
  );
}
