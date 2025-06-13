class Pause extends Popup {
  /*
  String basePath = dataPath("") + "/popups/";
  String bgStr;
  PImage bg;
  PImage textBg = loadImage("/popups/Text.png");
  
  String popupType;
  */
  
  final PVector topLeft = new PVector(9*dW/16,2*dH/16);
  final PVector bottomRight = new PVector(14*dW/16,9*dH/16);
  final PVector dim = new PVector(5*dW/16,7*dH/16);
  final int borderWidth = 20;
  final color emptySpaceColor = color(200);
  final color tileSpaceColor = color(100);
  
  final color emptySlotColor = color(255,0,0);
  final color fullSlotColor = color(0,255,255);
  
  
  public Pause() {
    super("Pause.png");
  }
  
  void display() {
    if(popupType=="map") {
      displayMap();
    } else if(popupType=="inv") {
      displayInv();
    }
  }

  void setBg() {
    POPUP_IND = 1;
    displayBg();
    displayTextBg(topLeft,dim);
    
    fill(255, 255, 0);
    textSize(30);
    text("Press K to Resume   " + (popupType=="inv" ? "Press M to show Map" : "Press V to open Inventory"),7*dW/15,14*dH/16);
    text("Press a number between 1-9 to change Difficulty",7*dW/15,15*dH/16);
    
    fill(255);
    text("Difficulty: " + DIFFICULTY,13*dW/15,29*dH/32);
  }
  
  void displayMap() {
    setBg();
    drawMap(STAGE.map, Util.addPVScalar(topLeft,borderWidth), Util.addPVScalar(dim,-2*borderWidth));
  }
  
  void displayInv() {
    setBg();
    drawInv(topLeft,dim, PLAYER.hotbar);
  }
  
  void drawMap(boolean[][] arr, PVector P1, PVector d) {
    rectMode(CORNER);
    float cellWidth = d.x / arr[0].length;
    float cellHeight = d.y / arr.length;
    
    stroke(0);
    for (int y = 0; y < arr.length; y++) {
        for (int x = 0; x < arr[y].length; x++) {
          color c = arr[y][x] ? emptySpaceColor : tileSpaceColor;
          fill(c);
          rect(P1.x + x * cellWidth, P1.y + y * cellHeight, cellWidth, cellHeight);
      }
    }
    
    
    fill(0,255,0);
    //rect(P1.x + (int)(PLAYER.P1.x/tileSize) * cellWidth, P1.y + (int)(PLAYER.P1.y/tileSize) * cellHeight, cellWidth, cellHeight);
    
    markSqMap(P1, PLAYER.P1, cellWidth, cellHeight, color(0,255,0));
    
    for(Entity e : STAGE.ENEMIES) {
      markSqMap(P1, e.P1, cellWidth, cellHeight, color(255,0,0));
    }
    
    for(UpgradeAltar a : STAGE.ALTARS) {
      if(!a.used) {
        markSqMap(P1, a.position, cellWidth, cellHeight, color(255,0,255));
      }
    }
  }

  void markSqMap(PVector P1, PVector P2, float cellWidth, float cellHeight, color c) {
    fill(c);
    rect(P1.x + (int)(P2.x/tileSize) * cellWidth, P1.y + (int)(P2.y/tileSize) * cellHeight, cellWidth, cellHeight);
  }
  
  void drawInv(PVector P1, PVector d, Item[] arr) {
    // calc  width and height of bounding area
    float areaWidth = d.x;
    float areaHeight = d.y;
    
    // Calculate square size
    float padding = 4*borderWidth;
    float squareSize = min(areaWidth, areaHeight) / 2 - padding;
    
    // Calculate center positions for the 4 squares
    float centerX1 = P1.x + areaWidth * 0.25;
    float centerX2 = P1.x + areaWidth * 0.75;
    float centerY1 = P1.y + areaHeight * 0.25;
    float centerY2 = P1.y + areaHeight * 0.75;
    
    // Draw the 4 squares
    rectMode(CENTER); // Draw squares from center for ease
    
    for(int i = 0; i<4; i++) {
      
      float x = (i%2==1) ? centerX2 : centerX1;
      float y = (i>1) ? centerY2 : centerY1;
      
      fill((arr[i] != null) ? fullSlotColor : emptySlotColor);
      rect(x, y, squareSize, squareSize);
      if(arr[i] != null) {
        image(arr[i].getSprite(), x-squareSize/2 + 5, y-squareSize/2 + 5, squareSize - 10, squareSize - 10);
      }
    }
    
    rectMode(CORNER); // Revert to corner mode
  }
  
  void filler(int x) {x++;}
}
