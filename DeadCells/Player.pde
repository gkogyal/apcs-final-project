class Player extends Entity {
  /*
  int hp,def;
  PVector P1,P2,dim,dir;
  String sprite;
  */
  
  final int defaultHP = 100;
  final int defaultDef = 0;
  final PVector dim = new PVector(50,80);
  
  int maxhp;
  Item[] hotbar = new Item[4];
  int heldInd = 0;
  int heals;
  
  int healInc = 10; // TODO: Alter how much hp healInc gives
  
  public Player(int x, int y) {
    hp = defaultHP;
    maxhp = defaultHP;
    P1 = new PVector(x,y);
    P2 = PVector.add(P1,dim);
    
    
    hp = defaultHP;
    maxhp = defaultHP;
    
    hp = 100;
    
    
    dir = new PVector(0,0);
    maxhp = hp;
    heals = 7;
    heldInd = 0;
  }
  
  void update(){
    move();
    drawEntity();
  }
  
  void move() {
  
  }

  @Override
  void drawEntity() {
  
  }
  
  void attack() {
    held.use();
  }
  
  void groundSmash() {
  
  }
  
  /*
  What does this do??  
  void swapInvPos(int slot) {}
  */
  
  void heal() {
    if(heals>0) {
      hp = Math.max(maxhp,hp+healInc);
      heals--;
    } else {
      /*
      TODO:
      Add way to notify player they have no heals.
      */
    }
  }
  
  
  void takeDmg(int dmg) {
    hp -= dmg;
    if(hp<=0) die();
  }
  
  void die() {
    /*
    TODO:
    Player level restarts
    */
  }
}
