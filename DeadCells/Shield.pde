class Shield extends Item {
  /*
  int lvl,dmg,atkspd;
  int classType, animType;
  String itemName;
  
  int lastHit = 0;
  
  Hitbox hb;
  */
  
  boolean shieldUp = false;
  
  public Shield(String fileString) {
    super(fileString);
    super.animType = 1;
  }
  
  void use() {
    activate();
  }
  
  void activate() {
    shieldUp = true;
    lastUse = frameCount;
  }
  
  void lowerShield() {
    shieldUp = false;
  }
}
