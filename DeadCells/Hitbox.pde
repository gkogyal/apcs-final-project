class Hitbox {
  PVector center;
  int magnitude;
  int angle;
  int initAngle;
  
  boolean highlightHitbox = false;
  
  public Hitbox(int center, int magnitude, int angle, int initAngle) {
    this.center = center;
    this.magnitude = magnitude;
    this.angle = angle;
    this.initAngle = initAngle;
  }
  
  void toggleHighlight() {highlightHitbox = !highlightHitbox;}
  
  void toggleHighlight(boolean b) {highlightHitbox = b;}
}
