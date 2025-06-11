class InputHandler {

  public InputHandler() {
  }

  void keys(Camera cam) {
    if (keyPressed) {
      if (key == 'w' || key == 'W') {
        cam.loc.y += 10;
        // modify direction to go up or down
        // modify character sprite to: prepareJump sprite (if on ground) or falling anim
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
