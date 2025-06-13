class Sword extends Item {
  /*
  int lvl,dmg,atkspd; // atkspd = cooldown in milliseconds
  int classType, animType;
  String itemName;
  
  int lastUse = 0;
  
  Hitbox hb;
  */
  
  public Sword(String f) {
    super(f);
  }
  
  void use() {
    if (canUse()) {
      boolean isRight = PLAYER.dir.x>0;
      hb = new Hitbox(this,PLAYER.P1,isRight,0.2);
      lastUse = frameCount;
    }
  }
  
}
