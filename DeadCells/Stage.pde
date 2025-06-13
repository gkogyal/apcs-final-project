

public class Stage {
  private boolean[][] map;
  private int[][] Pmap;
  private Enemy[][] Emap;
  public HashMap collides;
  public int threshold, totalConnects;
  public ArrayList<Room> rooms = new ArrayList<Room>();
  public PVector startCoords = new PVector(20,20);
  
  private int tHalls;
  private int Halls;
  private int Rooms;
  private int dRooms;


  public Stage(int t, int nm) {
    tHalls = new File( dataPath("") + "/rooms/" + nm + "/t").listFiles().length;
    Halls  = new File( dataPath("") + "/rooms/" + nm + "/h").listFiles().length;
    Rooms  = new File( dataPath("") + "/rooms/" + nm + "/r").listFiles().length;
    dRooms = new File( dataPath("") + "/rooms/" + nm + "/d").listFiles().length;
    map = new boolean[40][40];
    Pmap = new int[40][40];
    Room startRoom = new Room( new File( dataPath("") + "/rooms/" + nm + "/startStub.txt") );
    //Room startRoom = new Room( new File( dataPath("") + "/rooms/" + t + "/t/2.txt") );
    threshold = t; // arbitrary stage size controls
    addRoom(nm, startRoom, startCoords);
  }



  public void addRoom(int stage, Room r, PVector coord) {
    println("Origin left - 1: " + coord);
    printRmap(r);
    println("size" + rooms.size());
    rooms.add(r);
    //resizing map if the map is out of bounds
    coord = resizeMap(coord, r.size);

    // writing room data to map
    for (int row = 0; row < r.size.x; row++)
      for (int col = 0; col < r.size.y; col++)
        if ( coord.x > 0 && coord.y > 0 && r.map[col][row] ) this.map[(int)coord.x + col][(int)coord.y + row] = true;
    
    // adding more rooms at the connection points
    int attempts = 0;
    for (int i = 0; i < r.connections.size(); i++) {
      println("whichtodo: " + r.connections.get(i));
      if (rooms.size() > 500) break;   //TEMP SIZE HARD LIMIT COUNTER
      attempts ++;
      Room t = new Room(new File(pullRandomRoom1(stage)));
      resizeMap(coord, t.size);
      PVector CorrC = new PVector(0, 0, 0);
      boolean foundValidDir = false;
      boolean foundValidDim = false;

      // checking if selected room is valid
      while (true) {
        // checking if the selected room has a connection that is opposite the current connection
        for (int x = 0; x < t.connections.size(); x++)
          if (t.connections.get(x).z == (r.connections.get(i).z + 2) % 4 ) {
            foundValidDir = true;
            CorrC = t.connections.get(x);
            println("Here is the correct connection: " + CorrC);
            t.connections.remove(x);
          }
          /* scrapped proportions checker
          
        // checking if the room fits onto the map (only if it has correct direction)
        if (foundValidDir) {
          println("cool" );
          foundValidDim = true;
          
          
          int rVal = 0;
          int cVal = 0;
          int direction = (int) CorrC.z;
          if (rooms.size() <= 1)
            switch(direction){
              case 0: rVal =(int) (coord.y + r.connections.get(i).y - CorrC.y + 1); cVal = (int) (coord.x + r.connections.get(i).x - CorrC.x); break; // up 
              case 1: rVal =(int) (coord.y + r.connections.get(i).y - CorrC.y); cVal = (int) (coord.x + r.connections.get(i).x - CorrC.x - 1); break; // right
              case 2: rVal =(int) (coord.y + r.connections.get(i).y - CorrC.y - 1); cVal = (int) (coord.x + r.connections.get(i).x - CorrC.x); break; // down
              case 3: rVal =(int) (coord.y + r.connections.get(i).y - CorrC.y); cVal = (int) (coord.x + r.connections.get(i).x - CorrC.x + 1); break; // left
            }
           else{
            switch(direction){
              case 0: rVal =(int) (coord.x + r.connections.get(i).y - CorrC.y + 1); cVal = (int) (coord.y + r.connections.get(i).x - CorrC.x); break; // up 
              case 1: rVal =(int) (coord.x + r.connections.get(i).y - CorrC.y); cVal = (int) (coord.y + r.connections.get(i).x - CorrC.x - 1); break; // right
              case 2: rVal =(int) (coord.x + r.connections.get(i).y - CorrC.y - 1); cVal = (int) (coord.y + r.connections.get(i).x - CorrC.x); break; // down
              case 3: rVal =(int) (coord.x + r.connections.get(i).y - CorrC.y); cVal = (int) (coord.y + r.connections.get(i).x - CorrC.x + 1); break; // left
            }
           }
      
          
          for (int row = 0; row < t.size.y; row++)
            for (int col = 0; col < t.size.x; col++) {
              // if the place on the map anywhere in the new room's dimension is taken, dimension is invalid
              if ( rVal >= 0 || cVal >= 0 || rVal < map.length || cVal < map[0].length || map[rVal + row][cVal + col] ) foundValidDim = false;
              foundValidDim = true;
            }
        }
        
        */
        if (foundValidDir || attempts > 25) break; // successfully found fitting room
        attempts++;
        println("Failure" + attempts);
        foundValidDir = false;
        t = new Room(new File(pullRandomRoom1(stage))); // room not valid, so selecting another room at random
      }

      // adding the room, augumenting to get the correct placement
      if(attempts < 250){
      int direction = (int) CorrC.z;
      if (rooms.size() <= 1)
        switch(direction){
          case 0: addRoom(stage, t, new PVector(coord.y + r.connections.get(i).y - CorrC.y + 1, coord.x + r.connections.get(i).x - CorrC.x)); break; // up 
          case 1: addRoom(stage, t, new PVector(coord.y + r.connections.get(i).y - CorrC.y, coord.x + r.connections.get(i).x - CorrC.x - 1)); break; // right
          case 2: addRoom(stage, t, new PVector(coord.y + r.connections.get(i).y - CorrC.y - 1, coord.x + r.connections.get(i).x - CorrC.x)); break; // down
          case 3: addRoom(stage, t, new PVector(coord.y + r.connections.get(i).y - CorrC.y, coord.x + r.connections.get(i).x - CorrC.x + 1)); break; // left
        }
       else{
        switch(direction){
          case 0: addRoom(stage, t, new PVector(coord.x + r.connections.get(i).y - CorrC.y + 1, coord.y + r.connections.get(i).x - CorrC.x)); break; // up 
          case 1: addRoom(stage, t, new PVector(coord.x + r.connections.get(i).y - CorrC.y, coord.y + r.connections.get(i).x - CorrC.x - 1)); break; // right
          case 2: addRoom(stage, t, new PVector(coord.x + r.connections.get(i).y - CorrC.y - 1, coord.y + r.connections.get(i).x - CorrC.x)); break; // down
          case 3: addRoom(stage, t, new PVector(coord.x + r.connections.get(i).y - CorrC.y, coord.y + r.connections.get(i).x - CorrC.x + 1)); break; // left
        }
       }
      }
      r.connections.remove(i);
    }
  }

  //resizing map in one of four directions
  public PVector resizeMap(PVector coord, PVector size) {
    char direction = 'n';
    if (coord.x - size.x < 0) {
      println("u");
      direction = 'u';
      coord.x += 20;
    }
    if (coord.x + size.x >= map.length) {
      println("d");
      direction = 'd';
    }
    if (coord.y - size.y < 0) {
      println("l");
      direction = 'l';
      coord.y += 20;
    }
    if (coord.y + size.x >= map[0].length) {
      println("r");
      direction = 'r';
    }
    int w = 0, x = 0, y = 0, z = 0;
    switch(direction) {
    case 'u':
      w = 20;
      y = 20;
      break;
    case 'd':
      w = 20;
      break;
    case 'l':
      x = 20;
      z = 20;
      break;
    case 'r':
      x = 20;
      break;
    }
    startCoords = new PVector(startCoords.x + y, startCoords.y + z);
    boolean[][] temp = new boolean[map.length + w][map[0].length + x];
    int[][] Ptemp = new int[map.length + w][map[0].length + x];
    for (int r = 0; r < map.length; r++)
      for (int c = 0; c < map[0].length; c++){
        temp[r+y][c+z] = map[r][c];
        Ptemp[r+y][c+z] = Pmap[r][c];
      }
        
    Pmap = Ptemp;
    map = temp;
    return coord;
  }
  
void printRmap(Room r) {
  for (int i = 0; i < r.map.length; i++) {
    for (int j = 0; j < r.map[0].length; j++)
      print((r.map[i][j])? "[]" : "  " );
    println();
  }
  println(r.connections);
}



  public String pullRandomRoom1(int stage) {
    String s = dataPath("") + "/rooms/" + stage + "/";
    int rand;
    rand = (rooms.size() >= threshold)? ((int) (Math.random() * 3) + 2) : ((int) (Math.random() * 3));
    switch(rand) {
    case 0:
      s += "t/" + (int) (Math.random() * tHalls);
      break; // select a type of t hall
    case 1: case 2:
      s += "r/" + (int) (Math.random() * Rooms);
      break;  // select a type of room with 2 or more exits
    case 3:
      s += "h/" + (int) (Math.random() * Halls);
      break;  // select a type of hallway
    default:
      s += "d/" + (int) (Math.random() * dRooms);
      break; // select a type of dead end room
    }
    return s + ".txt";
  }
}
