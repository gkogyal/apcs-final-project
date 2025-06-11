public class Camera {
  public PVector loc = new PVector(5000, 5000);
  private final int dW = displayWidth, dL = displayHeight;
  public int tileSize = dL/6;
  private int topmost = (int) (loc.y - 5000) / tileSize;
  private int leftmost = (int) (loc.x - 5000) / tileSize;

  public Camera() {
  }

  public void snapToPlayer() {
  }
  
  
  public void render( Stage stage ) {
    topmost = 1 + (int) (loc.y) / tileSize ;
    leftmost = 1 + (int) (loc.x) / tileSize;
    
    
    for (int r = topmost - (5000/tileSize); r <= topmost + (dL/tileSize) - (5000/tileSize) + 1; r++)
      for (int c = leftmost - (5000/tileSize); c <= leftmost + (dW/tileSize) - (5000/tileSize) + 1; c++)
        if ( r >= 0 && c >= 0 && r < stage.map.length && c < stage.map[0].length && stage.map[r][c]){
          fill(#FFFFFF);
          square(loc.x + c * tileSize, loc.y + r * tileSize, tileSize);
          fill(#FF44FF);
          text("" + loc + leftmost,loc.x - 5000 + c * tileSize, loc.y - 5000 + r * tileSize);
        }
  }
  
}
