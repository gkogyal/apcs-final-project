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

int dW;
int dH;

int[] n = new int[3];

void setup() {
  fullScreen();
  ctrlZ();
  println(dW);
  println(dH);
}

void draw(){
  
  if(POPUP_IND==-1) {
    // running the game
    CAMERA.render(STAGE);
  } else if (POPUP_IND==0) {
    POPUPS[POPUP_IND].display();
    // show starting screen or loading screen
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
  text(xy + " " + nStr, 30, 20);
}

void ctrlZ() {
  
  dW = displayWidth;
  dH = displayHeight;
  
  STAGE = new Stage();
  stageNumber = 0;
  
  CAMERA = new Camera();
  
  PLAYER = new Player(0,0);
  
  hitboxes = new ArrayList<Hitbox>();
  
  POPUPS = new Popup[] {
    (new Loading()), (new Pause()), (new Upgrade())
  };
  
  POPUP_IND = 0;
  POPUPS[POPUP_IND].setType("start");
  
  PLAYER.hotbar[0] = new Sword("iceSword");
  PLAYER.hotbar[1] = new Shield("woodenShield");
  PLAYER.hotbar[2] = new Special("bearTrap");
  PLAYER.hotbar[3] = new Special("bombTrap");
  
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
}
