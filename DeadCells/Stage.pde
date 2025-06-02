

public class Stage {
  private boolean[][] map;
  private int tileSize = 120;
  public HashMap collides;
  public int threshold, totalConnects;
  public ArrayList<Room> rooms = new ArrayList<Room>();

  private int tHalls;
  private int Halls;
  private int Rooms;
  private int dRooms;


  public Stage(int t) {
    switch(t) { // setting up the number of rooms per type in each stage level
      case 1:
        tHalls = 0;
        Halls  = 0;
        Rooms  = 0;
        dRooms = 0;
        break;
      case 2:
        tHalls = 0;
        Halls  = 0;
        Rooms  = 0;
        dRooms = 0;
        break;
      case 3:
        tHalls = 0;
        Halls  = 0;
        Rooms  = 0;
        dRooms = 0;
        break;
    }
    map = new boolean[20][20];
    Room startRoom = new Room( new File(dataPath("") + t + "/rooms/startStub.txt") );
    addRoom(startRoom, new PVector(0, 0));
    threshold = t;
  }



  public void addRoom(Room r, PVector coord) {

    //resizing map if the map is out of bounds
    if (coord.x < 0) {
      resizeMap('l');
      coord.x += 20;
    }
    if (coord.x > map.length) {
      resizeMap('r');
    }
    if (coord.y < 0) {
      resizeMap('u');
      coord.y += 20;
    }
    if (coord.y > map[0].length) {
      resizeMap('d');
    }

    // writing room data to map
    for (int row = 0; row < r.map.length; row++)
      for (int col = 0; col < r.map[row].length; col++)
        map[(int)coord.y + row][(int)coord.x + col] = !map[(int)coord.y + row][(int)coord.x + col];

    // adding more rooms at the connection points
    for (int i = 0; i < r.connections.size(); i++) {
      Room t = new Room(new File(pullRandomRoom1()));
      int correctConnect = 0;
      boolean foundValidDir = false;
      boolean foundValidDim = false;

      // checking if selected room is valid
      while (true) {
        // checking if the selected room has a connection that is opposite the current connection
        for (int x = 0; x < t.connections.size(); x++)
          if (t.connections.get(x).z == (r.connections.get(i).z + 2) % 4 ){
            foundValidDir = true;
            correctConnect = x; 
          }
        // checking if the room fits onto the map (only if it has correct direction)
        if (foundValidDir){
          foundValidDim = true;
          for (int row = 0; row < t.size.y; row++)
            for (int col = 0; col < t.size.x; col++){
              int rVal = (int)(coord.y + r.connections.get(i).y + row - t.connections.get(correctConnect).y);
              int cVal = (int)(coord.x + r.connections.get(i).x + col - t.connections.get(correctConnect).x);
              // if the place on the map anywhere in the new room's dimension is taken, dimension is invalid
              if ( rVal > 0 && cVal > 0 && rVal < map.length && cVal < map.length && map[rVal][cVal] ) foundValidDim = false;
            }
      }
        if (foundValidDim) break; // successfully found fitting room
        t = new Room(new File(pullRandomRoom1())); // room not valid, so selecting another room at random
      }

      // adding the room, augumenting to get the correct placement
      addRoom(t, new PVector(coord.x + r.connections.get(i).x - t.connections.get(correctConnect).x, coord.y + r.connections.get(i).y - t.connections.get(correctConnect).y));
    }
  }

  //resizing map in one of four directions
  public void resizeMap(char direction) {
    boolean temp[][];
    int w = 0, x = 0, y = 0, z = 0;
    switch(direction) {
      case 'u': w = 20; y = 20; break;
      case 'd': w = 20; break;
      case 'l': x = 20; z = 20; break;
      case 'r': x = 20; break;
    }
    temp = new boolean[map.length + w][map.length + x];
    for (int r = 0; r < map .length; r++)
      for (int c = 0; c < map[r].length; c++)
        temp[r+y][c+z] = map[r][c];
        
    map = temp;
  }


  public String pullRandomRoom1() {
    String s = dataPath("") + "/rooms/";
    int rand;
    if ( rooms.size() < threshold ) rand = (int) (Math.random() * 3);
    else rand = (int) (Math.random() * 1) + 2;
    switch(rand) {
    case 1:
      s += "t" + (int) (Math.random() * tHalls);
      break; // select a type of t hall
    case 2:
      s += "r" + (int) (Math.random() * Rooms);
      break;  // select a type of room with 2 or more exits
    case 3:
      s += "h" + (int) (Math.random() * Halls);
      break;  // select a type of hallway
    case 4:
      s += "d" + (int) (Math.random() * dRooms);
      break; // select a type of dead end room
    }
    return s;
  }
}
