

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
    String s = dataPath("") + "/rooms/";
    int rand;
    if ( rooms.size() < threshold ) rand = (int) (Math.random() * 4);
    else rand = (int) (Math.random() * 1) + 2;
    switch(rand){
     case 1: s += "t"; break;
     case 2: s += "r"; break;
     case 3: case 4: s += "h"; break;
    }
    
    
    return s;
    
  }
  
}
