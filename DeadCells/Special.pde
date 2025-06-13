class Special extends Item {
  
  /*
  int lvl,dmg,atkspd; // atkspd = cooldown in milliseconds
  int classType, animType;
  String itemName;
  
  int lastUse = 0;
  
  Hitbox hb;
  */
  
  public Special(String f) {
    super(f);
    this.id = "trap";
  }
  
  void use() {
    int dir = (int(PLAYER.dir.x>0)*2)-1; // if right -> 1, if left -> -1
    PVector P1 = new PVector(PLAYER.P1.x + dir*tileSize, PLAYER.P1.y + tileSize).div(tileSize);
    hb = new Hitbox(this,P1);
  }
  
}
