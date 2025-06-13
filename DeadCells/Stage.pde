public class Stage {
  boolean[][] map;
  int ROWS,COLS;
  ArrayList<Enemy> ENEMIES = new ArrayList<Enemy>();
  ArrayList<UpgradeAltar> ALTARS = new ArrayList<UpgradeAltar>();
  String basePath;
  String num;
  String fileName;
    
  public Stage(int stageNumber) {
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
          String enemyName = (int(random(3)) == 0) ? "zombie" : (((int(random(2)))==1) ? "drowned" : "shieldBearer" );
          STAGE.ENEMIES.add( new Enemy((int)spawnPos.x, (int)spawnPos.y, enemyName) );
        }
    }
  }

  PVector findValidSpawn() {
    int attempts = 0;
    while(attempts < 100) {
        int x = (int)random(0, STAGE.map[0].length);
        int y = (int)random(0, STAGE.map.length);
        
        // if tile is valid && has empty space around it
        if(STAGE.map[y][x]) {
            boolean valid = true;
            // check 3x3 area around spawn
            for(int i = -1; i <= 1; i++) {
                for(int j = -1; j <= 1; j++) {
                    int checkX = x + i;
                    int checkY = y + j;
                    if(checkX < 0 || checkY < 0 || 
                       checkX >= STAGE.map[0].length || 
                       checkY >= STAGE.map.length || 
                       !STAGE.map[checkY][checkX]) {
                        valid = false;
                        break;
                    }
                }
                if(!valid) break;
            }
            
            if(valid) {
                return new PVector(x * tileSize, y * tileSize);
            }
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
