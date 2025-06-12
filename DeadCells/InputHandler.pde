final float vertVel = 4; // measured in pixels per frame
final float horizVel = 3;
final float maxVel = 5;

boolean up,down,left,right;

PVector direction;

boolean healClicked,invClicked,mapClicked,escapeClicked,nextBgClicked;
int difficultyClicked;

boolean special1;

PVector mousePos;
String mouseButtonClicked; // mouse button clicked

void check() {
  up = keyCode == 'W' || keyCode == 'w' || keyCode == ' ';
  down = keyCode == 'S' || keyCode == 's';
  left = keyCode == 'A' || keyCode == 'a';
  right = keyCode == 'D' || keyCode == 'd';
  
  direction = new PVector(int(up)-int(down),int(right)-int(left)); // 0 if both are same, 1 if up/right, -1 if down/left
  
  healClicked = keyCode=='F' || keyCode == 'f';
  invClicked = keyCode=='V' || keyCode == 'v';
  mapClicked = keyCode=='M' || keyCode == 'm';
  escapeClicked = keyCode==ESC || keyCode == ESC;
  nextBgClicked = keyCode=='L' || keyCode=='l';
  difficultyClicked = (Character.isDigit(keyCode)) ? int(keyCode)-48 : -1; // -1 if difficulty not clicked
  
  mousePos = new PVector(mouseX, mouseY);
  mouseButtonClicked = (mouseButton==RIGHT) ? "RIGHT" : "LEFT";
}
  
void keyPressed() {
  
  check();
  
  if(escapeClicked) {
    ctrlZ();
  }
  
  PLAYER.dir = PVector.mult(direction,vertVel);
  
  if(invClicked || mapClicked) {
    POPUP_IND = 1;
    POPUPS[POPUP_IND].setType(invClicked ? "inv" : "map");
  }
  
  switch(POPUP_IND) {
    case -1:
      PLAYER.dir = PVector.mult(direction,vertVel);
      if(healClicked) {
        PLAYER.heal();
      }
      break;
    case 1:
      POPUPS[POPUP_IND].display();
      if(difficultyClicked>0) DIFFICULTY = difficultyClicked; 

      break;
  }
}
  
void mouseClicked() {
  check();
  
  switch(POPUP_IND) {
    case -1:
      if(mouseButton==LEFT) {
        PLAYER.swapSlot(0);
        PLAYER.attack();
      } else if(mouseButton==RIGHT) {
        PLAYER.swapSlot(1);
        PLAYER.attack();
      }
      break;
    case 0:
      // check if start button pressed
      PVector R1 = new PVector((2*dW/3) - 300, 775);
      PVector R2 = PVector.add(R1,new PVector(600,150));
      boolean buttonClicked = Util.pointInRect(mousePos, R1, R2);
      if(POPUPS[POPUP_IND].getType()=="start" && stageNumber==0 && mouseButtonClicked=="LEFT" && buttonClicked) {
          // REAL CODE: nextStage();
          // PSEUDO
          POPUPS[POPUP_IND].setType("waiting");
      }
      
      if (POPUPS[POPUP_IND].getType()=="waiting" && mouseButtonClicked=="RIGHT" && buttonClicked) {
        POPUPS[POPUP_IND].filler(0);
      }
      
      if (POPUPS[POPUP_IND].getType()=="waiting" && mouseButtonClicked=="LEFT" && !buttonClicked) {
        POPUPS[POPUP_IND].filler(1);
      }
      
      break;
    case 2:
      // checks which upgrade clicked
      // check Upgrade's drawUpgrades() function for reasoning behind magic numbers
      float y = 3*dH/20;
      float mult = (19*dW/21 - 80)/3 + 40; 
      PVector RD = new PVector(mult-40,7*dH/10); // rect dimensions
      
      for(int i = 0; i<3; i++) {
        PVector topLeft = new PVector(dW/21 + i*mult, y);
        if(Util.pointInRect(mousePos, topLeft, PVector.add(topLeft,RD))) {
          if(i==0) {
            PLAYER.stats.x++; n[0]++;
          }
          else if(i==1) {
            PLAYER.stats.y++; n[1]++;
          }
          else {
            PLAYER.stats.z++; n[2]++;
          }
        }
      }
      break;
  }
}
