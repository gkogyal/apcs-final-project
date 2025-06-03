class Sword extends Item {
  /*
  int lvl,dmg,atkspd;
  int classType, animType;
  String sprite;
  
  float lastHit = 0;
  
  Hitbox hb;
  */
  
  public Sword(String f) {
    super(f);
  }
  
  void use() {
    boolean isRight = (abs(dir.x)/dir.x) ? 1 : -1;
    hb = new Hitbox(this,PLAYER.P1,isRight,0.2);
  }
  
  public void animateItem(){
    
  }
  
  
  
}
