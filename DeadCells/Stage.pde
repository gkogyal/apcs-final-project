public class Stage {
  // TEMPLATE STAGE CODE
  // ONLY SO NO PSEUDO ERRORS RETURNED
  // DO NOT USE
  boolean[][] map;
  int ROWS,COLS;
  ArrayList<Enemy> ENEMIES = new ArrayList<Enemy>();
  String basePath;
  String num;
  String fileName;
    
  public Stage(int stageNumber) {
    println(stageNumber);
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
    //readMap();
  }
}
