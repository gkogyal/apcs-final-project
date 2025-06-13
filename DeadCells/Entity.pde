abstract class Entity {
  int maxHp;
  float hp; // stored as percent of maxHp
  PVector P1,P2,dim,dir = new PVector(0,0); // P1,P2 = top left, bottom right points of hurtbox
  
  Animation anim;
  
  boolean highlightEntity = false; // used to outline entities -- defaulted to false
  
  boolean alive = true;
  
  void drawEntity() {
    try {
        PImage sprite = anim.getFrame();
        if(sprite != null) {
            sprite.resize(int(dim.x), int(dim.y));
            image(sprite, P1.x, P1.y);
        }
    } catch(Exception e) {
        // Fallback debug rectangle
        fill(255,0,0);
        rect(P1.x, P1.y, dim.x, dim.y);
    }
    
    if(highlightEntity) highlight();
}
  
  void toggleHighlight() {highlightEntity = !highlightEntity;}
  
  void toggleHighlight(boolean b) {highlightEntity = b;}
  
  void highlight() {
    fill(150); stroke(255,0,0);
  }
  
  boolean canExistAt(PVector P3) {
    int tileX = (int)(P3.x/tileSize);
    int tileY = (int)(P3.y/tileSize);
    int tileX2 = (int)((P3.x+dim.x)/tileSize);
    int tileY2 = (int)((P3.y+dim.y)/tileSize);
    
    // checks tiles the entity would be on
    for(int x = tileX; x<=tileX2; x++) {
        for(int y = tileY; y<=tileY2; y++) {
            if(x<0 || y<0 || x>=STAGE.map[0].length || y>=STAGE.map.length) {
                return false;
            }
            if(!STAGE.map[y][x]) {
                return false;
            }
        }
    }
    return true;
  }
  
  void reposition(PVector movement) {
    
    PVector newPos = PVector.add(P1, movement);
    boolean dx=false,dy=false;
    
    //if(Util.distance(P1,newPos)>=3) {

      // check x movement
      PVector tempPos = new PVector(newPos.x, P1.y);
      if(canExistAt(tempPos)) {
          P1.x = tempPos.x;
          P2.x = P1.x + dim.x;
          dx = true;
      }
      
      // check y movement
      tempPos = new PVector(P1.x, newPos.y);
      if(canExistAt(tempPos)) {
          P1.y = tempPos.y;
          P2.y = P1.y + dim.y;
          dy = true;
      }
      /*
      if(dx&&dy) {
        
        //In the case of going up and left 1 unit:
        //Valid iff the folowing 3 actions are valid: going up 1 unit, going left 1 unit and going up and left 1 unit are all valid
        
        if(!canExistAt(newPos)) {
          P1 = newPos;
        }
      }*/
    //}
}
  
  void applyGravity() {
    dir.y+=2;
    reposition(new PVector(0, dir.y));
  }
  
  void die() {
    alive = false;
  }
  
  abstract void attack();
  
  abstract void update();
  
  abstract void takeDmg(int dmg);
}
