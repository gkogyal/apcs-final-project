class InputHandler {
  
  void keyPressed() {
    
    if(keyCode == 'W' || keyCode == ' ' || keyCode == 'S') {
      // modify direction to go up or down
      // modify character sprite to: prepareJump sprite (if on ground) or falling anim 
    }
      
    if(keyCode == 'D' || keyCode == 'A') {
      // modify direction to go left or right
      // modify character sprite to: left or right run sprite
    }
      
    if(keyCode=='F') {
      PLAYER.heal();
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
      PLAYER.attack();
    }
    
    /*
    TODO: Implement so you can drag the items around in inventory to different slots
    */
  }
  
  void mouseReleased() {
    
    
  }
}
