class Player extends Entity {
  /*
  int maxHp;
  float hp=1;
  PVector P1,P2,dim,dir;
  
  Animation anim;
  boolean highlightEntity = false;
  
  boolean alive = true;
  */
  
  final int defaultHP = 100;
  final int defaultDef = 0;
  final float healInc = 0.03; // Alters how much hp heal() gives.
  
  Item[] hotbar = new Item[4]; // 0 = main weapon; 1 = shield; 2 = trap; 3 = trap;
  int heldInd = 0;
  int maxHeals=7,heals;
  
  boolean isAttacking;
    
  PVector stats = new PVector(1,1,1); // brutality, tactics, survival
  
  String[] extraAnims = new String[] {
    "swordLeft"
    ,"swordRight"
    ,"shieldLeft"
    ,"shieldRight"
  };
  
  public Player() {
    maxHp = defaultHP; hp = 1.0;
    P1 = new PVector(dW/2,dH/2);
    P2 = PVector.add(P1,dim);
    
    anim = new Animation(false,"player");
    
    anim.addStates(extraAnims);
    
    highlightEntity = true;
    dir = new PVector(0,0);
    heals = 7;
    heldInd = 0;
  }
  
  public Player(int x, int y) {
    maxHp = defaultHP; hp = 1.0;
    P1 = new PVector(x,y);
    P2 = PVector.add(P1,dim);
    
    anim = new Animation(false,"player");
    
    anim.addStates(extraAnims);
    
    highlightEntity = true;
    dir = new PVector(0,0);
    heals = 7;
    heldInd = 0;
  }
  
  void update(){
    checkInputs();
    move();
    applyGravity();
    updateAnimation();
    drawEntity();
  }
  
  void updateAnimation() {
    if(swordSwung) {
      anim.setState("sword" +  (isFacingRight() ? "Right" : "Left"));
    } else if(shieldActivated) {
      anim.setState("shield" +  (isFacingRight() ? "Right" : "Left"));
    } else if(left && !right) {
        anim.setState("runLeft");
    } else if(right && !left) {
        anim.setState("runRight");
    } else if(up && !down) {
        anim.setState("up");
    } else if(down && !up) {
        anim.setState("down");
    } else {
        anim.setState("idle");
    }
  }
  
  boolean isFacingRight() {
    return closestEnemy().P1.x > this.P1.x;
  }
  
  Enemy closestEnemy() {
    Enemy closest = STAGE.ENEMIES.get(0);
    float bestDist = dH*dW, dist;
    for(Enemy e : STAGE.ENEMIES) {
      dist = Util.distance(this.P1,e.P1);
      if(dist<bestDist) {
        closest = e;
        bestDist = dist;
      }
    }
    return closest;
  }
  
  void move() {
    
    dir = new PVector(0,0);
    
    if(up) { dir.y -= horizVel;}
    if(down) { dir.y += horizVel;}
    if(left) { dir.x -= vertVel;}
    if(right) { dir.x += vertVel;}
    
    // Normalize diagonal movement
    if(dir.x != 0 && dir.y != 0) {
        dir.normalize().mult(maxVel);
    }
    
    reposition(dir);
  }
  
  void attack() {
    if(isAttacking) {
      hotbar[heldInd].use(); 
      isAttacking = false;
    }
  }
  
  void prepareAttack() {
    isAttacking = true;
  }
  
  void swapSlot(int n) {
    if(n<4 && n>-1) {
      heldInd = n;
    }
  }
  
  void heal() {
    if(heals>0) {
      hp = Math.max(1,hp+(healInc/maxHp));
      heals--;
    }
  }
  
  void resetHeals() {
    heals = maxHeals;
  }
  
  void setMaxHeals(int n) {
    maxHeals = n;
  }
  
  
  void takeDmg(int dmg) {
    // shieldActivated() is a global var in InputHandler.pde
    hp -= dmg * (shieldActivated ? Util.defense(stats)*3/4 : 1.0) / maxHp;
    if(shieldActivated) hotbar[heldInd].dmg = -1;
    if(hp<=0) die();
  }
}
