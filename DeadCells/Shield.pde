class Shield extends Item {
  /*
  int lvl,dmg,atkspd;
  int classType, animType;
  String itemName;
  
  int lastHit = 0;
  
  Hitbox hb;
  */
    
  public Shield(String fileString) {
    super(fileString);
    super.animType = 1;
  }
  
  void use() {
    if(canUse()) {
      dmg=0;
    }
  }
}
