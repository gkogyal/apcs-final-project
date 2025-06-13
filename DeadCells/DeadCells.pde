import java.io.File;
import java.util.Scanner;

ArrayList<Hitbox> hitboxes;
Player PLAYER;
Stage STAGE; int stageNumber;
Camera CAMERA;
Popup[] POPUPS;
int POPUP_IND; // if -1, then nothing to show

int DIFFICULTY = 1;
int tileSize = 120;
int ROWS = 100;
int COLS = 100;
ArrayList<Hitbox> HITBOXES = new ArrayList<Hitbox>();
PImage background;

int dW;
int dH;

int[] n = new int[4]; // solely for testing to mark code

void setup() {
  fullScreen();
  println(Util.getFileLen(dataPath("") + "/stages/"));
  ctrlZ();
  println(dW);
  println(dH);
}

void draw(){
  checkInputs();
  if(POPUP_IND==-1) {
    // running the game
    PLAYER.update();
    CAMERA.render();
    /*
    TODO:
    update all enemies
    go to next stage if all enemies are dead
    */
  } else if (POPUP_IND==0) {
    POPUPS[POPUP_IND].display();
    // show starting/finishing screen or loading screen
  } else if (POPUP_IND==1) {
    // show map or inventory
    POPUPS[POPUP_IND].display();
  } else if(POPUP_IND==2){
    POPUPS[POPUP_IND].display();
    // show upgrade
  }
  
  fill(0);
  rect(0,0,75,25);
  fill(255);
  textSize(12);
  String xy = mouseX + ", " + mouseY;
  String nStr = n[0] + ", " + n[1] + ", " + n[2];
  String pxy = PLAYER.P1.x + ", " + PLAYER.P1.y;
  String pdxy = PLAYER.dir.x + ", " + PLAYER.dir.y;
  textAlign(LEFT,BOTTOM);
  text(xy + "||" + nStr + "||" + pxy + "||" + pdxy, 50, 50);
}

void ctrlZ() {
  
  dW = displayWidth;
  dH = displayHeight;
  
  tileSize = displayHeight/6;
  
  background = loadImage(dataPath("") + "/background.png");
  
  stageNumber = 3;
  nextStage();
  
  CAMERA = new Camera();
  
  PLAYER = new Player();
  
  hitboxes = new ArrayList<Hitbox>();
  
  POPUPS = new Popup[] {
    (new Loading()), (new Pause()), (new Upgrade())
  };
  
  PLAYER.hotbar = new Item[]{
    (new Sword("iceSword")), (new Shield("woodenShield")), (new Special("bearTrap")), (new Special("bombTrap"))
  };
  
  POPUP_IND = 0;
  POPUPS[POPUP_IND].setType("start");
  
  /*
    TODO:
   > Return to zero, undo everything
   > Used when player dies and very beginning of game
  */
}

void nextStage() {
  /*
    TODO:
   > Initializes next stage
   > Keeps player data from stage n to stage n+1
   > Moves player
   > 
  */
  STAGE = new Stage(++stageNumber);
}
