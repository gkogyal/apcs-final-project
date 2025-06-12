class Player extends Entity {
  /*
  int maxHp;
  float hp;
  PVector P1,P2,dim,dir;
  
  Animation anim;
  boolean highlightEntity = false;
  
  boolean alive = true;
  */
  
  final int defaultHP = 100;
  final int defaultDef = 0;
  final PVector dim = new PVector(50,80);
  final float healInc = 0.03; // Alters how much hp heal() gives.
  
  Item[] hotbar = new Item[4]; // 0 = main weapon; 1 = shield; 2 = trap; 3 = trap;
  int heldInd = 0;
  int maxHeals=7,heals;
  
  boolean isAttacking;
    
  PVector stats = new PVector(1,1,1); // brutality, tactics, survival
  
  public Player(int x, int y) {
    maxHp = defaultHP; hp = 1.0;
    P1 = new PVector(x,y);
    P2 = PVector.add(P1,dim);
    
    anim = new Animation(false,"player");
    
    dir = new PVector(0,0);
    hp = 1;
    heals = 7;
    heldInd = 0;
  }
  
  void update(){
    move();
    drawEntity();
  }
  
  void move() {
    reposition(dir);
  }
  
  void attack() {
    if(isAttacking) {
      hotbar[heldInd].use(); 
      isAttacking = false;
    }
  }
  
  void prepareAttack() {
    isAttacking = true;
  }
  
  void swapSlot(int n) {
    if(n<4 && n>-1) {
      heldInd = n;
    }
  }
  
  void heal() {
    if(heals>0) {
      hp = Math.max(1,hp+healInc);
      heals--;
    }
  }
  
  void resetHeals() {
    heals = maxHeals;
  }
  
  void setMaxHeals(int n) {
    maxHeals = n;
  }
  
  
  void takeDmg(int dmg) {
    // shieldActivated() is a global var in InputHandler.pde
    hp -= dmg * (shieldActivated ? Util.defense(stats)*3/4 : 1.0) / maxHp;
    if(shieldActivated) hotbar[heldInd].dmg = -1;
    if(hp<=0) die();
  }
}
