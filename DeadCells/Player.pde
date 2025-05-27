public class Player extends Entity{
  int health,stamina;
  PVector loc,dir,dim=new PVector(1,2);
  
  public Player(int x, int y, int health) {
    super(x, y, health);
  }
  
  void update(){
    move();
  };
  
  void move() {
    
    PVector nLoc = PVector.add(loc,dir);
    
    //TODO add entity collisions
    if((nLoc.x<0) || (nLoc.x >= w)) nLoc.x = Math.max(0,Math.min(w-1,nLoc.x));
    
    if((nLoc.y<0) || (nLoc.y >= h)) nLoc.y = Math.max(0,Math.min(h-1,nLoc.y));
    
    for(int i = int(nLoc.y); i<int(nLoc.y+dim.y); i++) {
      for(int j = int(nLoc.x); j<int(nLoc.x+dim.x); j++) {
        if(i<0 || j <0 || j>=w || i>=h) {
          nLoc = loc;
        }
        else if (!map[i][j]) {
          nLoc = loc;
        }
      }
    }
    
    loc = nLoc;
    dir = new PVector(0,0);
  }
  
  void modDir(PVector d) {dir = d;}
  void modDirX(int x) {dir.x = x;}
  void modDirY(int y) {dir.y = y;}
  
  void modLoc(PVector l) {loc = l;}
  void modLocX(int x) {loc.x = x;}
  void modLocY(int y) {loc.y = y;}
  
  void display() {
    fill(125);
    rect(loc.x*ss, loc.y*ss, dim.x*ss, dim.y*ss, 48, 48, 48, 48);
    // the last 4 integers give rounding for each corner
  }
}
