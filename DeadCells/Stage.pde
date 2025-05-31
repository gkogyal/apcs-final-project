

public class Stage{
  private boolean[][] map;
  private int tileSize = 120;
  public HashMap collides;
  public int threshold, totalConnects;
  public ArrayList<Room> rooms = new ArrayList<Room>();
  
  private final int tHalls = 0;
  private final int Halls = 0;
  private final int Rooms = 0;
  private final int dRooms = 0;
  
  
  public Stage(int t){
    map = new boolean[100][100];
    String StartRoom = dataPath("") + t + "/rooms/startStub.txt";
    addRoom(StartRoom, new PVector(25,25));
    threshold = t;
  }
    
   
  
  public void addRoom(String s, PVector coord){
    Room r = new Room(new File(s));
    rooms.add(r);
    
  }
  
  
  public String pullRandomRoom(){
    String s = dataPath("") + "/rooms/";
    int rand;
    if ( rooms.size() < threshold ) rand = (int) (Math.random() * 3);
    else rand = (int) (Math.random() * 1) + 2;
    switch(rand){
     case 1: s += "t" + (int) (Math.random() * tHalls); break; // select a type of t hall
     case 2: s += "r" + (int) (Math.random() * Rooms); break;  // select a type of room with 2 or more exits
     case 3: s += "h" + (int) (Math.random() * Halls); break;  // select a type of hallway
     case 4: s += "d" + (int) (Math.random() * dRooms); break; // select a type of dead end room
    }
    
    
    return s;
    
  }
  
}
