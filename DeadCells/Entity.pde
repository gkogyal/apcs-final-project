abstract class Entity {
  int health;
  PVector loc,dir = null;
  
  public Entity(int x, int y, int health) {
    loc = new PVector(x,y);
    this.health = health;
    
  }
  
  //abstract public void attack();
}

/*
TW horrible code
*/
