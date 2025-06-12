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
    for (int r = leftMost; r <= leftMost + (dL/tileSize) + 1; r++)
      for (int c = topMost; c <= topMost + (dW/tileSize) + 1; c++)
        if ( r > 0 && c > 0 && r < stage.map.length && c < stage.map[0].length && stage.map[r][c]){
          noStroke();
          fill(#395E58);
          square(loc.x + c * tileSize, loc.y + r * tileSize, tileSize);
          if (r - 1 > 0 && !stage.map[r-1][c]){
            fill(#F15E58);
            rect(loc.x + c * tileSize, loc.y + r * tileSize, tileSize + tileSize/20, tileSize/20);
          }
          if (r + 1 < stage.map.length && !stage.map[r+1][c]){
            fill(#F15E58);
            rect(loc.x + c * tileSize,loc.y + (r +1)* tileSize, tileSize + tileSize/20, tileSize/20);
          }
          if (c - 1 > 0 && !stage.map[r][c-1]){
            fill(#F15E58);
            rect(loc.x + c * tileSize, loc.y + r * tileSize, tileSize/20, tileSize + tileSize/20);
          }
          if (c + 1 < stage.map[0].length && !stage.map[r][c+1]){
            fill(#F15E58);
            rect(loc.x + (c + 1) * tileSize,loc.y + r * tileSize, tileSize/20, tileSize + tileSize/20);
          }
          
          
        }
  }
  
}
