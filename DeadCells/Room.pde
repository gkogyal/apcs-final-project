import java.io.File;
import java.util.Scanner;

public class Room{
  int connections;
  ArrayList<Room> connects;
  PVector size;
  ArrayList<Entity> entities;
  
  public Room(File F){
    try{
      Scanner s = new Scanner(F);
      size.x = s.nextInt();
      size.y = s.nextInt();
      connections = s.nextInt();
      s.close();
    }catch(Exception e){
    
    }
    
    
    
    
    
  }
 
  
  
  
}
