final float vertVel = 4; // measured in pixels per frame
final float horizVel = 3;
final float upVel = 1;
final float maxVel = 5;

boolean up,down,left,right;

boolean healClicked,invClicked,mapClicked,escapeClicked,nextBgClicked;
int difficultyClicked;

boolean special1;

boolean shieldActivated;

PVector mousePos;
String mouseButtonClicked; // mouse button clicked

void checkInputs() {
  
  up = down = left = right = false;
  healClicked = invClicked = mapClicked = escapeClicked = nextBgClicked = false;
  
  if(keyPressed) {
    up = key == 'W' || key == 'w' || key == ' ';
    down = key == 'S' || key == 's';
    left = key == 'A' || key == 'a';
    right = key == 'D' || key == 'd';
    
    healClicked = key=='F' || key == 'f';
    invClicked = key=='V' || key == 'v';
    mapClicked = key=='M' || key == 'm';
    escapeClicked = key=='K' || key == 'k';
    nextBgClicked = key=='L' || key=='l';
    difficultyClicked = (Character.isDigit(keyCode)) ? int(keyCode)-48 : -1; // -1 if difficulty not clicked
  }
  
  shieldActivated = (PLAYER.hotbar[PLAYER.heldInd] instanceof Shield) && PLAYER.hotbar[PLAYER.heldInd].dmg==0;
  mousePos = new PVector(mouseX, mouseY);
  
  mouseButtonClicked = (mouseButton==RIGHT) ? "RIGHT" : "LEFT";
}
  
void keyPressed() {
  
  checkInputs();
  
  if(escapeClicked) {
    POPUP_IND = -1;
  }
    
  if(invClicked || mapClicked) {
    POPUP_IND = 1;
    POPUPS[POPUP_IND].setType(invClicked ? "inv" : "map");
  }
  
  switch(POPUP_IND) {
    case -1:
      if(left!=right) {
        if(right) {
          PLAYER.anim.setState("runRight");
          PLAYER.dir.x = 1;
        } else if(left) {
          PLAYER.anim.setState("runLeft");
          PLAYER.dir.x = -1;
        }
      } else {
        PLAYER.dir.x = 0;
      }
      
      if (up!=down) {
        if(up) {
          PLAYER.anim.setState("up");
          PLAYER.dir.y = 1;
        } else if(down) {
          PLAYER.anim.setState("down");
          PLAYER.dir.y = -1;
        }
      } else {
        PLAYER.dir.y = 0;
      }
      
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
  checkInputs();
  
  switch(POPUP_IND) {
    case -1:
      if(mouseButton==LEFT) {
        PLAYER.swapSlot(0);
        PLAYER.prepareAttack();
      } else if(mouseButton==RIGHT) {
        PLAYER.swapSlot(1);
        PLAYER.prepareAttack();
      }
      break;
    case 0:
      // check if start button pressed
      PVector R1 = new PVector((2*dW/3) - 300, 775);
      PVector R2 = PVector.add(R1,new PVector(600,150));
      boolean buttonClicked = Util.pointInRect(mousePos, R1, R2);
      
      if (POPUPS[POPUP_IND].getType()=="waiting" && mouseButtonClicked=="RIGHT" && buttonClicked) {
        POPUPS[POPUP_IND].filler(0);
      }
      
      if (POPUPS[POPUP_IND].getType()=="waiting" && mouseButtonClicked=="LEFT" && !buttonClicked) {
        POPUPS[POPUP_IND].filler(1);
      }
      
      if(POPUPS[POPUP_IND].getType()=="start" && mouseButtonClicked=="LEFT" && buttonClicked) {
          // REAL CODE: 
          POPUP_IND = -1;
          // PSEUDO CODE:
          //POPUPS[POPUP_IND].setType("waiting");
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
            PLAYER.stats.x++;
          }
          else if(i==1) {
            PLAYER.stats.y++;
          }
          else {
            PLAYER.stats.z++;
          }
        }
      }
      POPUP_IND = -1;
      break;
  }
}

void keyReleased() {
  checkInputs();
}

void mouseReleased() {
  checkInputs();
  switch(POPUP_IND) {
    case -1:
      //shield hold
      if(PLAYER.hotbar[PLAYER.heldInd] instanceof Shield) {
        PLAYER.hotbar[PLAYER.heldInd].dmg = -1;
      }
  }
}
