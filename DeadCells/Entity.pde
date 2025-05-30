abstract class Entity {
  int hp,def;
  PVector loc,dir = null;
  String sprite;
  
  public Entity(int x, int y, int hp, int def, String sprite) {
    this.loc = new PVector(x,y);
    this.hp = hp;
    this.def = def;
    this.sprite = sprite;
  }
  
  void drawEntity() {
    
  };
  
  abstract void attack();
}
