abstract class Item {

  int lvl,dmg,atkspd; // atkspd = cooldown in milliseconds
  int classType, animType;
  String itemName,id;
  
  int lastUse = 0;
  
  Hitbox hb;
  
  public Item(String f) {
    decodeItem(f);
  }
  
  void decodeItem(String itemName) {
    try {
      this.itemName = itemName;
      
      String fileName = dataPath("") + "/items/" + this.itemName + "/data.txt";
      Scanner s = new Scanner(new File(fileName));
      
      lvl = s.nextInt(); dmg = s.nextInt(); atkspd = s.nextInt();
      s.nextLine();
      
      classType = s.nextInt();
      animType = s.nextInt();
      
      s.close();
    } catch (Exception e) {
      e.printStackTrace();
    }
  }
  /*
  Item File Example:
  3 2 4 (lvl, dmg,atkspd)
  2 1 (classType, animType)
  */
  
  boolean canUse() {
    return (frameCount-lastUse >= atkspd);
  }
  
  PImage getSprite() {
    return loadImage("items/" + itemName + "/sprite.png");
  }
  
  abstract void use();
}
