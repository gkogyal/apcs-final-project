class Enemy extends Entity {
  /*
  int hp,def;
  PVector P1,P2,dim,dir;
  String sprite;
  */
  int dmg,atkspd;
  int enemyType;
  int attackDist,chaseDist;
  
  final float repositionRange = 8;
  final int maxRepositionAttempts = 18;

  public Enemy(int x, int y, String fileStr) {
    sprite = fileStr;
    this.P1 = new PVector(x,y); // P1 stores top left coord of entity hurtbox
    decodeEnemy(fileStr); // fills entity information
    this.P2 = PVector.add(P1,dim); // updates P2 to store bottom right coord of entity hurtbox
  }
  
  /*
  Enemy File Example:
  3 2 (P2.x, P2.y)
  100 20 (hp, def)
  30 10 (dmg, atkspd)
  3 (enemyType)
  20 150 (attackDist,chaseDist)
  */
  void decodeEnemy(String fileStr) {
    try {
      Scanner s = new Scanner(new File(fileStr));
      sprite = fileStr;
      dim = new PVector(s.nextInt(),s.nextInt());
      s.nextLine();
      hp = s.nextInt();
      def = s.nextInt();
      s.nextLine();
      dmg = s.nextInt();
      atkspd = s.nextInt();
      s.nextLine();
      enemyType = s.nextInt();
      s.close();
    } catch(Exception e) {
      e.printStackTrace();
    }
  }
  
  void update() {
    action();
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
    
  }
  
  void chasePlayer() {
    
  }
  
  void idleMove() {
    int maxAttempts = 15;
    PVector P3 = new PVector(1,0);
    for(int attempt = 0; attempt<maxAttempts; attempt++) {
      P3 = PVector.random2D().setMag(random(repositionRange));
      P3.x = Math.max(0,Math.min(ROWS,floor(P3.x)));
      P3.y = Math.max(0,Math.min(ROWS,floor(P3.y)));
      if(this.canExistAt(P3)) {
        reposition(P3);
      }
    }
  }
  
  void reposition(PVector P3) {
    /*
    TODO:
    Enemy checks if P3 is valid -> if true, then move there
    
    How to move there?
    */
  }
  
  void takeDmg(int dmg) {
    hp -= dmg;
    if(hp<=0) die();
  }
  
  void die() {
    /*
    TODO:
      > Delete itself from arraylist of enemies
    */
  }
}
