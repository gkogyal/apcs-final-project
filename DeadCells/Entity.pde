abstract class Entity {
  int maxHp;
  float hp; // stored as percent of maxHp
  PVector P1,P2,dim,dir = new PVector(0,0); // P1,P2 = top left, bottom right points of hurtbox
  
  Animation anim;
  
  boolean highlightEntity = false; // used to outline entities -- defaulted to false
  
  boolean alive = true;
  
  void drawEntity() {
    PImage sprite = anim.getFrame();
    sprite.resize(int(dim.x),int(dim.y));
    image(sprite,P1.x,P1.y);
    if(highlightEntity) {
      highlight();
    }
  }
  
  void toggleHighlight() {highlightEntity = !highlightEntity;}
  
  void toggleHighlight(boolean b) {highlightEntity = b;}
  
  void highlight() {
    noFill(); stroke(255,0,0);
    rect(P1.x,P1.y,dim.x,dim.y); // red hitbox around entity
  }
  
  boolean canExistAt(PVector P3) {
    PVector dP1 = PVector.div(P1,float(tileSize)).add(P3);
    PVector dP2 = PVector.div(P2,float(tileSize)).add(P3);
    
    // checks tiles which are considerably larger than pixels and entities
    // hence will actually only access map est. 1-10 times;
    for(int x = int(dP1.x); x<int(dP2.x); x++) {
      for(int y = int(dP1.y); y<int(dP2.y); y++) {
        if(!STAGE.map[x][y]) return false; // assumes that a 1 means valid tile
      }
    }
    
    return true; // if no invalid tiles, then must be true
  }
  
  void reposition(PVector P3) {
    if(this.canExistAt(P3)) {
      this.P1 = P3; // updates top left coord
      this.P2 = PVector.add(P1,dim); // updates bottom right coord
    }
  }
  
  void applyGravity() {
    dir.y+=0.5;
    reposition(new PVector(0, dir.y));
  }
  
  void die() {
    alive = false;
  }
  
  abstract void attack();
  
  abstract void update();
  
  abstract void takeDmg(int dmg);
}
