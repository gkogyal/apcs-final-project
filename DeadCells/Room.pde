    import java.io.File;
import java.util.Scanner;
import java.util.Arrays;
public class Room{
  public int numConnections;
  public boolean[][] map;
  public PVector size;  
  public ArrayList<Entity> entities;
  public ArrayList<PVector> connections = new ArrayList<PVector>();
  
  public Room(File F){
    println(F);
    decodeRoom(F);
  }
 
  
  public void decodeRoom(File F){
    try{
      Scanner s = new Scanner(F);
      this.size = new PVector(s.nextInt(), s.nextInt());
      numConnections = s.nextInt();
      map = new boolean[(int)size.y][(int)size.x];
      int x = 0;
      s.nextLine();
      String[] p = s.nextLine().split(" ");
      while (!p[0].equals("e")){
         for (int i = 0; i < p.length; i++)
           if ( p[i].equals("0") )
             map[x][i] = true;
         x++;
         p = s.nextLine().split(" ");
      }
      x = 0;
      while (s.hasNextLine()){
        p = s.nextLine().split(" ");
        connections.add(new PVector(Integer.parseInt(p[0]), Integer.parseInt(p[1]), 0));
        char test = p[2].charAt(0);
        switch (test){ 
          case 'u': connections.get(connections.size()-1).z = 0; break;
          case 'r': connections.get(connections.size()-1).z = 1; break;
          case 'd': connections.get(connections.size()-1).z = 2; break;
          case 'l': connections.get(connections.size()-1).z = 3; break;
        }
        x++;
      }
      s.close();
    }catch(Exception e){
      println("Something appears to have gone wrong");
      e.printStackTrace();
    } 
  }
}
