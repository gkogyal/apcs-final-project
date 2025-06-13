public class Camera {
  
  final color invalidSpace = color(0);  
  PVector loc = new PVector(0,0); // top left of camera

  public Camera() {
  }

  public void snapToPlayer() {
    tileSize = dH/20;
    loc.x = constrain(PLAYER.P1.x - dW/2, 0, STAGE.map[0].length * tileSize - dW);
    loc.y = constrain(PLAYER.P1.y - dH/2, 0, STAGE.map.length * tileSize - dH);
  }
  
  public void render() {
    snapToPlayer();
    noStroke();
    image(background,0,0,dW,dH);
    fill(invalidSpace);
    for(int y = (int)(loc.y/tileSize); y<(int)((loc.y+dH+tileSize)/tileSize); y++) {
      for(int x = (int)(loc.x/tileSize); x<(int)((loc.x+dW+tileSize)/tileSize); x++) {
        if(x<0 || y<0 || y>=STAGE.map.length || x>=STAGE.map[0].length) continue;
        
        if(!STAGE.map[y][x]) square(x*tileSize-loc.x, y*tileSize-loc.y, tileSize); // Subtract camera offset
      }
    }
    
    pushMatrix();
    translate(-loc.x, -loc.y);
    PLAYER.drawEntity();
    popMatrix();
  }
}
