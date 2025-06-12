public class Camera {
  private final int dW = displayWidth, dL = displayHeight;
  public double f = 20;
  public int tileSize = (int) (dL/f);
  public PVector loc = new PVector(0,0);
  private int leftMost = (int) (-loc.y) / tileSize;
  private int topMost = (int) (-loc.x) / tileSize;

  public Camera() {
  }

  public void snapToPlayer() {
  }
  
  
  public void render( Stage stage ) {
    tileSize = (int) (dL/f);
    leftMost =  (int) (-loc.y) / tileSize;
    topMost =   (int) (-loc.x) / tileSize;
    int n = 0;
    for (int r = leftMost; r <= leftMost + (dL/tileSize) + 1; r++)
      for (int c = topMost; c <= topMost + (dW/tileSize) + 1; c++)
        if ( r > 0 && c > 0 && r < stage.map.length && c < stage.map[0].length && stage.map[r][c]){
          fill(#FFFFFF);
          square(loc.x + c * tileSize, loc.y + r * tileSize, tileSize);
          fill(#FF11FF);
          textSize(dL/70);
          text( r + "-" + c, n+=dL/30, 20);
          text("" + loc, loc.x + c * tileSize, loc.y + r * tileSize);
        }
  }
  
}
