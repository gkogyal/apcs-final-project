public class Stage {
  // TEMPLATE STAGE CODE
  // ONLY SO NO PSEUDO ERRORS RETURNED
  // DO NOT USE
  boolean[][] map = new boolean[350][200];
  int tileSize = 120;
  ArrayList<Enemy> ENEMIES = new ArrayList<Enemy>();
  
  public Stage() {
    generateMap();
  }
  
  void generateMap() {
    for(int i = 0; i<map.length; i++) {
      for(int j = 0; j<map[0].length; j++) {
        if(!(i==0 || j==0 || i==map.length-1 || j==map[0].length-1 || i%j==int(random(2))+int(random(int(random(3)))))) map[i][j] = true;          
        // map[i][j] = int(random(2))==0;
      }
    }
  }
}
