abstract class Item {

  int lvl,dmg,atkspd; // atkspd = cooldown in milliseconds
  int classType, animType;
  String sprite;
  
  float lastHit = 0;
  
  Hitbox hb;
  
  public Item(String f) {
    decodeItem(f);
  }
  
  void decodeItem(String itemName) {
    try {
      String fileName = "/data/weapons/" + itemName + "/data.txt";
      Scanner s = new Scanner(new File(fileName));
      lvl = s.nextInt();
      dmg = s.nextInt();
      atkspd = s.nextInt();
      s.nextLine();
      animType = s.nextInt();
      animType = s.nextInt();
      s.close();
    } catch (Exception e) {
      e.printStackTrace();
    }
  }
  /*
  Item File Example:
  3 2 3 (lvl, dmg,atkspd)
  2 1 (classType, animType)
  20 150 (attackDist,chaseDist)
  */
  
  boolean canAttack() {
    return (System.currentTimeMillis()-lastHit >= atkspd);
  }
}
