import java.io.File;
import java.util.Scanner;

Player PLAYER;
Stage STAGE; int stageNumber;
Camera CAMERA;
Popup[] POPUPS;
int POPUP_IND; // if -1, then nothing to show

int DIFFICULTY = 1;
int tileSize = 120;
int ROWS = 100;
int COLS = 100;
ArrayList<Hitbox> HITBOXES;
PImage background;

int deathTime = -1;

boolean debug = true;

int dW;
int dH;

int[] n = new int[4]; // solely for testing to mark code

int maxMemory = 2048;

void setup() {
  fullScreen();
  //size(displayWidth,displayHeight,P2D);
  println(Util.getFileLen(dataPath("") + "/stages/"));
  ctrlZ();
  println(dW);
  println(dH);
}

void draw(){
  
  if (PLAYER != null && PLAYER.hp <= 0) {
    if (deathTime == -1) {
      deathTime = frameCount;
    }
    showDeathScreen();
  }
  
  else {

    checkInputs();
    if(POPUP_IND==-1) {
      // running the game
      PLAYER.update();
      CAMERA.render();
      for(Enemy e : STAGE.ENEMIES) {
        e.update();
      }
      for (UpgradeAltar altar : STAGE.ALTARS) {
        altar.update();
      }

      drawHUD();
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
    String display = frameCount + ", " + frameRate;
    textAlign(LEFT,BOTTOM);
    text(xy + "||" + nStr + "||" + pxy + "||" + pdxy + "||" + display, 50, 50);
  }
}

void ctrlZ() {
  
  dW = displayWidth;
  dH = displayHeight;
  
  tileSize = displayHeight/6;

  background = loadImage(dataPath("") + "/background0.png");

  stageNumber = 2;
  nextStage();
  
  CAMERA = new Camera();
  PLAYER = new Player(800,1404);
  
  STAGE.spawnEnemies(3 + 2*stageNumber);
  STAGE.spawnAltars(1);
  
  for(Enemy e : STAGE.ENEMIES) {
    println(e.P1);
  }

  HITBOXES = new ArrayList<Hitbox>();
  
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
  stageNumber++;
  if(PLAYER!=null) PLAYER.resetHeals();
  STAGE = new Stage(stageNumber);
}

void drawHUD() {
    fill(255);
    textSize(60);
    text("HP: " + (int)(PLAYER.hp * 100) + "%", dW - 300, 200);
    text("Stage: " + stageNumber, dW - 300, 140);
}

void showDeathScreen() {
  float fade = map(frameCount - deathTime, 0, 180, 0, 255);
  fill(255, 0, 0, fade);
  rect(0, 0, dW, dH);
  textAlign(CENTER, CENTER);
  fill(255);
  textSize(90);
  text("TRY AGAIN", dW/2, dH/2);
  textSize(30);
  text("TRY AGAIN\nPress R to restart", dW/2, dH/2 - 100);
  // Show for 3 seconds (3*fps)
  if (frameCount - deathTime > 3*frameRate) {
      ctrlZ(); // Reset game
      deathTime = -1; // Reset timer
  }
}
