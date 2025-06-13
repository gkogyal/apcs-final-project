class Sword extends Item {
  /*
  int lvl,dmg,atkspd; // atkspd = cooldown in milliseconds
  int classType, animType;
  String itemName,id;
  
  int lastUse = 0;
  
  Hitbox hb;
  */
  
  public Sword(String f) {
    super(f);
    this.id = "sword";
  }
  
  void use() {
    if (canUse()) {
      hb = new Hitbox(this,PLAYER.P1,PLAYER.isFacingRight(),0.2);
      lastUse = frameCount;
    }
  }
  
}
