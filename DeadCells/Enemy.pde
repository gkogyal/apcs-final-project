String[] enemyNames = new String[] {
  "zombie" // 100 hp, 
  ,"shieldBearer"
  ,"creeper"
};

class Enemy extends Entity {
  /*
  int maxHp;
  float hp=1;
  PVector P1,P2,dim,dir = new PVector(0,0);
  
  Animation anim;
  boolean highlightEntity = false;
  
  boolean alive = true;
  */
  
  final float repositionRange = 8;
  final int maxRepositionAttempts = 18;
  
  int dmg,atkspd;
  int enemyType; // 0=brutality, 1=tactics, 2=survival
  int attackDist,chaseDist;
  
  int lastAtk = 0;

  public Enemy(int x, int y, String enemyName) {
    anim = new Animation(true,enemyName);
    this.P1 = new PVector(x,y); // P1 stores top left coord of entity hurtbox
    decodeEnemy(enemyName); // fills entity information
    this.P2 = PVector.add(P1,dim); // updates P2 to store bottom right coord of entity hurtbox
  }
  
  /*
  Enemy File Example:
  100 (maxHp)
  30 10 (dmg, atkspd)
  20 150 (attackDist,chaseDist)
  */
  void decodeEnemy(String enemyName) {
    try {
      Scanner s = new Scanner(new File(dataPath("") + "/entities/enemies/" + enemyName + "/data.txt"));

      maxHp = s.nextInt();
      
      s.nextLine();
      dmg = s.nextInt(); atkspd = s.nextInt(); 
      
      s.nextLine();
      attackDist = s.nextInt();  chaseDist = s.nextInt(); 
      
      s.close();
    } catch(Exception e) {
      e.printStackTrace();
    }
  }
  
  void update() {
    action();
    drawEntity();
  }
  
  /*
  x = distance from player:
    x<=attackDist -> attack() and chasePlayer()
    x<=chaseDist -> chasePlayer()
    else -> idleMove()
  */ 
  void action() {
    float d = Util.distance(P1,PLAYER.P1);
    
    if(d<=attackDist) {
      attack();
      chasePlayer();
    } else if(d<=chaseDist) {
      chasePlayer();
    } else {
      idleMove();
    }
  }
  
  void attack() {
    if(frameCount-lastAtk >= atkspd) {
      anim.setState("attack");
      int trueDmg = (dmg*DIFFICULTY)/4;
      PLAYER.takeDmg(trueDmg);
      lastAtk = frameCount;
    }
  }
  
  void chasePlayer() {
    moveTo(PLAYER.P1);
  }
  
  void idleMove() {
    int maxAttempts = 15;
    PVector P3 = new PVector(1,0);
    for(int attempt = 0; attempt<maxAttempts; attempt++) {
      P3 = PVector.random2D().setMag(random(repositionRange));
      P3.x = Math.max(0,Math.min(ROWS,floor(P3.x)));
      P3.y = Math.max(0,Math.min(ROWS,floor(P3.y)));
      reposition(P3);
    }
  }
  
  void moveTo(PVector P3) {
    PVector path = PVector.sub(P3, P1).normalize().mult(2);
    reposition(path);
  }
  
  void takeDmg(int dmg) {
    hp -= dmg/maxHp;
    if(hp<=0) die();
  }
}
