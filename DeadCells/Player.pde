public class Player extends Entity{
  /*
  int hp,def;
  PVector loc,dir;
  String sprite;
  */
  PVector vel;
  ArrayList<Item> inv = new ArrayList<Item>();
  int heals;
  Item held;
  
  public Player(int x, int y, int hp, int def) {
    super(x, y, hp,def);
    vel = new PVector(0,0);
    heals = 7;
  }
  
  void update(){
    move();
  }
  
  void move() {
  
  }
  
  
  
  @Override
  void drawEntity() {
  
  }
  
  void useHeld() {
  
  }
  
  void groundSmash() {
  
  }
  
  void swapInvPos(String slot) {
  
  }
  
  void heal() {
  
  }
}
