public class Stage {
  boolean[][] map;
  int ROWS,COLS;
  ArrayList<Enemy> ENEMIES = new ArrayList<Enemy>();
  ArrayList<UpgradeAltar> ALTARS = new ArrayList<UpgradeAltar>();
  String basePath;
  String num;
  String fileName;
    
  public Stage(int stageNumber) {
    println(1);
    try {
      basePath = dataPath("") + "/stages/" + stageNumber + "/";
      fileName =  basePath + int(random(Util.getFileLen(basePath))) + ".txt";
      Scanner s = new Scanner(new File(fileName));
      ROWS = s.nextInt(); COLS = s.nextInt();
      s.nextLine();
      
      map = new boolean[ROWS][COLS];
      for(int i = 0; i<ROWS; i++) {
        String[] row = s.nextLine().split(" ");
        for(int j = 0; j<COLS; j++) {
          map[i][j] = row[j].equals("1");
        }
      }
      s.close();
    } catch (Exception e) {
      e.printStackTrace();
    }
  }
  
  void spawnEnemies(int count) {
    for(int i = 0; i < count; i++) {
        PVector spawnPos = findValidSpawn();
        if(spawnPos != null) {
            STAGE.ENEMIES.add( new Enemy((int)spawnPos.x, (int)spawnPos.y, "zombie") );
        }
    }
  }

  PVector findValidSpawn() {
    int attempts = 0;
    while(attempts < 5) { // Prevent infinite
        
        // Random grid position
        int x = (int)random(0, STAGE.map[0].length/2);
        int y = (int)random(0, STAGE.map.length/2);
        
        // Convert to pixel coordinates
        int px = x * tileSize;
        int py = y * tileSize;
        
        if(STAGE.map[y][x] && Util.distance(new PVector(px,py), PLAYER.P1) > 300) {
            return new PVector(px, py);
        }
        attempts++;
    }
    return null;
  }

  void spawnAltars(int count) {
    for (int i = 0; i < count; i++) {
      PVector spawnPos = findValidSpawn();
      if (spawnPos != null) {
        ALTARS.add(new UpgradeAltar((int)(spawnPos.x/tileSize), (int)(spawnPos.y/tileSize)));
      }
    }
  }
  
  
}
