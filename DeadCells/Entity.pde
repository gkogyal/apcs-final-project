abstract class Entity {
  int hp,def;
  PVector P1,P2,dim,dir = new PVector(0,0); // P1,P2 = top left, bottom right points of hurtbox
  String sprite;
  
  boolean highlightEntity = false; // used to outline entities -- defaulted to false
  
  void drawEntity() {
    String entitySprite = "/entities/" + this.sprite + ".png"; // get file path for enemy sprite
    PImage img = loadImage(entitySprite); // instantiate PImage to output on window
    img.resize(int(abs(P1.x-P2.x)),int(abs(P1.y-P2.y))); // resize image to size of entity
    image(img,P1.x,P1.y); // display image with top left corner at P1
    if(highlightEntity) {
      noFill(); stroke(255,0,0);
      rect(P1.x,P1.y,dim.x,dim.y); // red hitbox around entity
    }
  };
  
  void toggleHighlight() {highlightEntity = !highlightEntity;}
  
  void toggleHighlight(boolean b) {highlightEntity = b;}
  
  boolean canExistAt(PVector P3) {
    PVector dP1 = PVector.div(P1,float(tileSize)).add(P3);
    PVector dP2 = PVector.div(P2,float(tileSize)).add(P3);
    
    for(int x = int(dP1.x); x<int(dP2.x); x++) {
      for(int y = int(dP1.y); y<int(dP2.y); y++) {
        if(!map[x][y]) return false; // assumes that a 1 means valid tile
      }
    }
    
    return true; // if no invalid tiles, then must be true
  }
  
  abstract void attack();
  
  abstract void update();
  
  abstract void takeDmg(int dmg);
  
  abstract void die();
}
