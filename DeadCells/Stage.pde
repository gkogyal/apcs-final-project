public class Stage{
  private boolean[][] map;
  private int tileSize = 120;
  public HashMap collides;
  public int threshold, totalConnects;
  public ArrayList<Room> rooms = new ArrayList<Room>();
  
  public Stage(int t){
    map = new boolean[100][100];
    String StartRoom = dataPath("") + "/rooms/startStub.txt";
    addRoom(StartRoom, new PVector(25,25));
    threshold = t;
  }
    
   
  
  public void addRoom(String s, PVector coord){
    Room r = new Room(new File(s));
    rooms.add(r);
    
  }
  
  
  public String pullRandomRoom(){
    String s = dataPath("");
    int rand = 0;
    if ( rooms.size() < threshold ) rand = (int) (Math.random() * 3);
    else rand = (int) (Math.random() * 1);
    
    
    
    return s;
    
  }
  
}
