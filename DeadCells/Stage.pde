

public class stage{
  private boolean[][] map;
  public HashMap collides;
  public ArrayList<Room> rooms = new ArrayList<Room>();
  
  public stage(int w, int h){
    map = new boolean[w][h];
    File f = new File(dataPath("") + "/rooms/startStub.txt");
    rooms.add(new Room(f));
      
  }
    
  
  
  
  
  public void pullRandomRoom(){
    String s = System.getProperty("user.dir");
    
    
  }
  
  
}
