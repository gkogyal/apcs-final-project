abstract class Item {

  int classType,damage,atkspd,level,animType;
  ArrayList<PVector> modifier;
  String sprite;
  
  public Item(File f) {
    decodeWeapon(f);
  }
  
  abstract void animateItem();
  
  void decodeWeapon(File f) {
  
  };
  
  abstract void use(Entity e);
}
