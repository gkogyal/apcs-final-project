class Bow extends Item {
  /*
  int lvl,dmg,atkspd;
  int classType, animType;
  String sprite;
  
  float lastHit = 0;
  
  Hitbox hb;
  */
  
  public Bow(String fileStr) {
    super(fileStr);
    super.animType = 2;
  }

  public void animateItem() {
  }

  public void use() {
    /*
        TODO:
     > Determine where to shoot (mouse or autoaim).
     > If autoaim: which enemy is prioritized? and where on enemy should be aimed at?
     > Create a hitbox on the arrow tip
     >
     */
     
     
     
     
  }
}
