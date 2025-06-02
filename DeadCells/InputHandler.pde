class InputHandler {
  
void keyPressed(Camera cam){
  
  if(keyCode == 'W' || keyCode == ' ') {
    cam.loc.y --;
    // modify direction to go up or down
    // modify character sprite to: prepareJump sprite (if on ground) or falling anim 
  }
  
  if ( keyCode == 'S'){
    cam.loc.y ++;
  }
    
  if(keyCode == 'A' || keyCode == 'D') {
    
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
