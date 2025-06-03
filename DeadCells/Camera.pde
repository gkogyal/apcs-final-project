public class Camera {
  public PVector loc = new PVector(0,0);
  private final int dW = displayWidth, dL = displayHeight;
  private int leftMost = loc.x / Stage.tileSize;
  private int topMost = loc.y / Stage.tileSize;
  
  public void snapToPlayer() {
    
    
    
    
  }
  public void render(){
    for(int r = leftMost; r <= leftMost + (dW/120); r++)
      for(int c = topMost; c <= topMost + (dL / 120); c++)
        square(loc.x, loc.y, 120);
    
    
    
  }
  
  
  
  
  
}
