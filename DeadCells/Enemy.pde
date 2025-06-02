class Enemy extends Entity {
  /*
  int hp,def;
  PVector loc,dir;
  String sprite;
  */
  int enemyType,dmg,atkspd;
  
  public Enemy(int x, int y, int hp, int def, int type, int dmg, int atkspd) {
    super(x,y,hp,def, "placeholder");
    
    this.enemyType = type;
    this.dmg = dmg;
    this.atkspd = atkspd;
  }
  
  @Override
  void attack() {
    
  }
  
  void doMovement() {
  
  }
  
  void reposition() {
  
  }
  void idleMove() {
  
  }
}
