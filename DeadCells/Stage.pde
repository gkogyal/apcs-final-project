public class Stage {
  // TEMPLATE STAGE CODE
  // ONLY SO NO PSEUDO ERRORS RETURNED
  // DO NOT USE
  boolean[][] map = new boolean[100][100];
  int tileSize = 120;
  ArrayList<Enemy> ENEMIES = new ArrayList<Enemy>();
  
  public Stage() {
  }
  
  void generateMap() {
    for(int i = 0; i<map.length; i++) {
      for(int j = 0; j<map[0].length; j++) {
        map[i][j] = random(1)>0.6942;
      }
    }
  }
}
