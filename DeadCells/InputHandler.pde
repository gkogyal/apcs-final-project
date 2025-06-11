class InputHandler {

  public InputHandler() {
  }

  void keys(Camera cam) {
    if (keyPressed) {
      if ( key == 'W' || key == 'w') {
        
        cam.loc.y += 10;
        
      }
      if ( key == 'S' || key == 's') {
        cam.loc.y -= 10;
      }

      if (key == 'A' || key == 'a') {
        cam.loc.x += 10;
      }
      if (key == 'D' || key == 'd') {
        cam.loc.x -= 10;
      }
      if (key=='-' && cam.f > 1) {
        cam.f += 0.1;
      }

      if (key=='=') {
        cam.f -= 0.1;
      }

      if (key=='F') {
        //heal();
      }

      if (key=='V') {
        //showInventory();
      }

      if (key=='M') {
        //showMap();
      }

      if (keyCode==ESC) {
        System.out.println("HELLO");
      }
    }
  }

  void mousePressed() {
    if (mouseButton==LEFT) {
      //P.useHeld();
    }
  }

  void mouseReleased() {
  }
}
