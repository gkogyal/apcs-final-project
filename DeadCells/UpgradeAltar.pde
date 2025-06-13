class UpgradeAltar {
  PVector position;
  PImage sprite;
  float interactRadius = 60; // pixels
  boolean used = false;
  float pulse = 0;
  final float pulseSpeed = 0.05f;
  
  public UpgradeAltar(int x, int y) {
    this.position = new PVector(x * tileSize, y * tileSize);
    try {
      this.sprite = loadImage(dataPath("") + "/entities/upgrade_altar.png");
    } catch(Exception e) {
      // Fallback if image not found
      println("Upgrade altar image not found, using placeholder");
      this.sprite = createImage(40, 40, ARGB);
      this.sprite.loadPixels();
      for (int i = 0; i < this.sprite.pixels.length; i++) {
        this.sprite.pixels[i] = color(150, 50, 200, 200);
      }
      this.sprite.updatePixels();
    }
  }
  
  void update() {
    if (!used) {
      pulse += pulseSpeed;
      if (distanceToPlayer() < interactRadius * 2) {
        // Show "Press E to interact" prompt when nearby
        drawInteractPrompt();
      }
    }
  }
  
  void drawAltar() {
    PVector screenPos = PVector.sub(position, CAMERA.loc);
    pushMatrix();
    translate(position.x, position.y);
    
    if (!used) {
      // Pulsing glow effect
      float glowSize = map(sin(pulse), -1, 1, 0, 10);
      fill(150, 50, 200, 50);
      noStroke();
      ellipse(tileSize/2, tileSize/2, tileSize + glowSize, tileSize + glowSize);
      
      // draw altar
      image(sprite, 0, 0, tileSize, tileSize);
    } else {
      // Used state
      fill(100, 100, 100, 150);
      rect(0, 0, tileSize, tileSize);
    }
    
    popMatrix();
  }
  
  void drawInteractPrompt() {
    PVector screenPos = PVector.sub(position, CAMERA.loc);
    fill(255, 200);
    textSize(20);
    textAlign(CENTER, CENTER);
    text("Press E to Upgrade", screenPos.x + tileSize/2, screenPos.y - 20);
  }
  
  float distanceToPlayer() {
    PVector altarCenter = PVector.add(position, new PVector(tileSize/2, tileSize/2));
    PVector playerCenter = PVector.add(PLAYER.P1, new PVector(PLAYER.dim.x/2, PLAYER.dim.y/2));
    return Util.distance(altarCenter, playerCenter);
  }
  
  void interact() {
    if (!used && distanceToPlayer() < interactRadius) {
      used = true;
      POPUP_IND = 2; // Show upgrade menu
    }
  }
}
