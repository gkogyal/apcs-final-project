abstract class Entity {
  int health;
  PVector loc,dir = null;
  
  public Entity(int x, int y, int health) {
    loc = new PVector(x,y);
    this.health = health;
    
  }
  
  abstract public void attack();
}

/*
TW horrible code
*/

class Player{
  int health,stamina;
  PVector loc,dir,dim=new PVector(1,2);
  
  public Player(int x, int y, int health, int stamina) {
    loc = new PVector(x,y);
    this.health = health;
    this.stamina = stamina;
  }
  
  void update() {
    
    PVector nLoc = loc.add(dir);
    
    //TODO add entity collisions
    if(nLoc.x<0 || nLoc.x >= w) nLoc.x = Math.max(0,Math.min(w,nLoc.x));
    
    if(nLoc.y<0 || nLoc.y >= w) nLoc.y = Math.max(0,Math.min(h,nLoc.y));
    
    
    loc = nLoc;
    dir = new PVector(0,0);
  }
  
  void modDirX(int dx) {
    dir.x = dx;
  }
  
  void modDirY(int dy) {
    dir.y = dy;
  }
  
  void display() {
    fill(125);
    rect(loc.x*ss, loc.y*ss, dim.x*ss, dim.y*ss, 48, 48, 48, 48);
    // the last 4 integers give rounding for each corner
  }
}
