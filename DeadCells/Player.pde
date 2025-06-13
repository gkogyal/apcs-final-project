class Player extends Entity {
  /*
  int maxHp;
  float hp=1;
  PVector P1,P2,dim,dir;
  
  Animation anim;
  boolean highlightEntity = false;
  
  boolean alive = true;
  
  int lastAtk;
  */
  
  final int defaultHP = 100;
  final int defaultDef = 0;
  final float healInc = 0.03; // Alters how much hp heal() gives.
  
  Item[] hotbar = new Item[4]; // 0 = main weapon; 1 = shield; 2 = trap; 3 = trap;
  int heldInd = 0;
  int maxHeals=7,heals;
  
  float effectiveHp;
  
  boolean isAttacking = false,carved=false;
    
  PVector stats = new PVector(1,1,1); // brutality, tactics, survival
  
  String[] extraAnims = new String[] {
    "_sword"
    ,"_shield"
  };
  
  public Player() {
    maxHp = defaultHP; hp = 1.0; effectiveHp = maxHp;
    P1 = new PVector(int(random(dW/2)),int(random(dH/2)));
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
    if(STAGE.map!=null && !carved) {
      carveSpawn(P1); carveSpawn(P2);
      carved = true;
    }
    checkInputs();
    move();
    attack();
    applyGravity();
    updateAnimation();
    drawEntity();
  }
  
  void updateAnimation() {
    if(swordSwung && frameCount - lastAtk < 10) {
      anim.setState("_sword");
    } else if(shieldActivated) {
      anim.setState("_shield");
    } else if(left != right) {
        anim.setState("_run");
    }  else if(up && !down) {
        anim.setState("up");
    } else if(down && !up) {
        anim.setState("down");
    } else {
        anim.setState("idle");
    }
  }
  
  boolean isFacingRight() {
    return (PLAYER.dir.x == 0) ? (closestEnemy().P1.x > this.P1.x) : PLAYER.dir.x>0;
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
    
    if(swordSwung && frameCount - lastAtk < 10) { // Prevent movement during attack
        dir = new PVector(0,0);
        return;
    }
    
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
    hotbar[heldInd].use(); 
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
    effectiveHp = maxHp * Util.hpMult(stats);
    hp -= dmg * (shieldActivated ? Util.defense(stats)*3/4 : 1.0) / effectiveHp;
    if(shieldActivated) hotbar[heldInd].dmg = -1;
    if(hp<=0) die();
  }
}
