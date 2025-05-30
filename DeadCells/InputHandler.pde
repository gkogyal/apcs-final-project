class InputHandler {
  
void keyPressed() {
  
  if(keyCode == 'W' || keyCode == ' ' || keyCode == 'S') {
    // modify direction to go up or down
    // modify character sprite to: prepareJump sprite (if on ground) or falling anim 
  }
    
  if(keyCode == 'A' || keyCode == 'D') {
    // modify direction to go left or right
    // modify character sprite to: left or right run sprite
  }
    
  if(keyCode=='F') {
    //heal();
  }

  if(keyCode=='V') {
    //showInventory();
  }
    
  if(keyCode=='M') {
    //showMap();
  }
    
  if(keyCode==ESC) {
    System.out.println("HELLO");
  }
}

void mousePressed() {
  if(mouseButton==LEFT) {
    //P.useHeld();
  }
}

void mouseReleased() {
  
  
}
}
