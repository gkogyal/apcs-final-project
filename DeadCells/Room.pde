import java.io.File;
import java.util.Scanner;

public class Room{
  public int numConnections;
  public boolean[][] map;
  public PVector size;  
  public ArrayList<Entity> entities;
  public ArrayList<PVector> connections;
  
  public Room(File F){
    decodeRoom(F);
    
    
    
  }
 
  
  public void decodeRoom(File F){
    try{
      Scanner s = new Scanner(F);
      size.x = s.nextInt();
      size.y = s.nextInt();
      numConnections = s.nextInt();
      map = new boolean[(int)size.x][(int)size.y];
      int x = 0;
      String[] p = s.nextLine().split(" ");
      while (!p[0].equals("e")){
         for (int i = 0; i < p.length; i++)
           if ( p[i].equals("1") ) 
             map[x][i] = true;
         x++;
      }
      x = 0;
      while (s.hasNextLine()){
        p = s.nextLine().split(" ");
        connections.add(new PVector(Integer.parseInt(p[0]), Integer.parseInt(p[1]), 0));
        char test = p[2].charAt(0);
        switch (test){ 
          case 'u': connections.get(connections.size()).z = 0; break;
          case 'r': connections.get(connections.size()).z = 1; break;
          case 'd': connections.get(connections.size()).z = 2; break;
          case 'l': connections.get(connections.size()).z = 3; break;
        }
        x++;
      }
      s.close();
    }catch(Exception e){
    
    } 
  }
}
