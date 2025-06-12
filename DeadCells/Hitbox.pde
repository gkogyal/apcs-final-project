class Hitbox {
  PVector origin; // main point of hitbox
  
  final float swordLength = 25.0, initTheta = -50.0, dTheta = 120;
  final float radius = 5; // only used for bow
  final PVector dimTrap = new PVector(tileSize,tileSize); // only used for trap
  PVector[] points = new PVector[2]; // used for trap and sword (points[0] and both)
  
  Item hbItem;
  String hitboxType;
  int atkDmg;
  
  boolean active;
  float duration = -1; // if -1 > permanent hitbox
  float startTime;
 
  float dir = 0; // if 0 -> idle
  
  boolean highlightHitbox = false; // used to outline hitboxes -- defaulted to false

  // 1 point -> trap
  public Hitbox(Item item, PVector P1) {
    this.hbItem = item;
    this.hitboxType = item.itemName;
    this.atkDmg = item.dmg;
    this.origin = P1;
    
    points[0] = PVector.add(P1,dimTrap);
    activate();
  }
  
  // 1 point, 1 direction -> arrow tip
  public Hitbox(Item item, PVector P1, float dir) {
    this.hbItem = item;
    this.hitboxType = item.itemName;
    this.atkDmg = item.dmg;
    this.origin = P1;
    
    this.dir = dir;
    activateTimed();
  }

  // 1 point, direction boolean, and duration -> sword slash
  public Hitbox(Item item, PVector P1, boolean isRight, float duration) {
    this.hbItem = item;
    this.hitboxType = item.itemName;
    this.atkDmg = item.dmg;
    this.origin = P1;
    
    this.duration = duration;
    
    /*
    A sword hitbox during a slash is composed of:
     > the origin point (P1)
     > the length of the sword (swordLength)
     > the initial angle of the sword (initTheta)
     > the rotation of the sword around the origin point (dTheta)
     > the direction, whether right or left (isRight)
    */
    
    // the dot product of <-1,1> AND [the vector of P1P2 or P1P3 when going right], would create [the vector of P1P2 or P1P3 when going left]
    float direction = isRight ? 1 : -1;
    
    // forms the vectors
    PVector P2 = (new PVector(1.0,0)).setMag(swordLength).rotate((initTheta+360)%360).add(P1);
    PVector P3 = (new PVector(1.0,0)).setMag(swordLength).rotate((initTheta+dTheta+360)%360).add(P1);
    
    // reflects over y-axis iff (if and only if) facing left
    P2.x *= direction;
    P3.x *= direction;
    
    this.points = new PVector[]{P2,P3};
    
    activateTimed();
  }
  
  // abstract timed rectangular hitbox
  public Hitbox(Item item, PVector P1, PVector P2, float duration) {
    this.hbItem = item;
    this.hitboxType = item.itemName;;
    this.atkDmg = item.dmg;
    this.origin = P1;
    this.duration = duration;
    points[0] = P2;
  }
  
  void update() {
    if(highlightHitbox) highlight();
    if(millis()-startTime>duration) deactivate();
    checkAllCollisions();
    switch(hitboxType) {
      case("trap"):
        PVector dim = PVector.sub(points[0],origin);
        if(active) image(hbItem.getSprite(), origin.x, origin.y, dim.x, dim.y);
        break;
      default:
        break;
    }
  }
  
  void toggleHighlight() {highlightHitbox = !highlightHitbox;}
  
  void toggleHighlight(boolean b) {highlightHitbox = b;}
  
  void highlight() {
    noFill(); stroke(255,255,0);
    
    switch(hitboxType) {
      case("trap"): rect(origin.x,origin.y,dimTrap.x,dimTrap.y); break;
      case("sword"): triangle(origin.x,origin.y,points[0].x,points[0].y,points[1].x,points[1].y); break;
      default: rect(origin.x,origin.y,abs(origin.x-points[0].x),abs(origin.y-points[0].y)); break;
    }
  }
  
  void activate() {
    active = true; HITBOXES.add(this);
  }
  
  void activateTimed() {
    activate();
    startTime = millis();
  }
  
  void deactivate() {
    active = false; // marks as deactivated
  }
  
  boolean checkCollision(Entity e) {
    PVector E1 = e.P1;
    PVector E2 = e.P2;
    
    switch(hitboxType) {
      case("trap"):
        return Util.intersectRectRect(origin,points[0],E1,E2);
      case("sword"):
        return Util.intersectTriRect(origin,points[0],points[1],E1,E2);
      default:
        return Util.intersectRectRect(origin,points[0],E1,E2);
    }
  }
  
  //  Loop through all enemies: if checkCollision() -> takeDmg()
  void checkAllCollisions() {
    for(Enemy enemy : STAGE.ENEMIES) {
      if(checkCollision(enemy)) {
        enemy.takeDmg(atkDmg);
      }
    }
    deactivate();
  }
}
