import java.io.File;
import java.util.Scanner;

ArrayList<Hitbox> hitboxes = new ArrayList<Hitbox>();
Player PLAYER;
boolean PAUSED;

int tileSize = 120;
int ROWS = 100;
int COLS = 100;
boolean[][] map = new boolean[ROWS][COLS];
ArrayList<Enemy> enemies = new ArrayList<Enemy>();

void setup() {
  fullScreen();
  pause();
}

void draw(){
  
}
