class Sword extends Item {
  
  public Sword(File f) {
    super(f);
  }
  
  @Override
  use(Entity e) {
      e = new Entity(0,0,0,0,"ts attack func needs to be finished");
  }
  
}
