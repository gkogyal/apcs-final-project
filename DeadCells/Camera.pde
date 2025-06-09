public class Camera {
  public PVector loc = new PVector(0, 0);
  private final int dW = displayWidth, dL = displayHeight;
  public int tileSize = dL/6;
  private int leftMost = (int) loc.y / tileSize;
  private int topMost = (int) loc.x / tileSize;

  public Camera() {
  }

  public void snapToPlayer() {
  }
  public void render( Stage stage ) {
    leftMost = 1 + (int) loc.y / tileSize;
    topMost = 1 +  (int) loc.x / tileSize;
    for (int r = leftMost; r <= leftMost + (dW/tileSize) + 1; r++)
      for (int c = topMost; c <= topMost + (dL/tileSize) + 1; c++)
        if ( r > 0 && c > 0 && r < stage.map.length && c < stage.map[0].length && stage.map[r][c])
          square(loc.x + c * tileSize, loc.y + r * tileSize, tileSize);
  }
}
