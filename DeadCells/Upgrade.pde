class Upgrade extends Popup {
  /*
  String basePath = dataPath("") + "/popups/";
  String bgStr;
  PImage bg;
  PImage textBg = loadImage("/popups/Text.png");
  */
  
  PVector borderDim = new PVector(dW/21,dH/16);
  PVector dim = new PVector(dW-2*borderDim.x, dH-2*borderDim.y);
  
  public Upgrade() {
    super("Upgrade.png");
  }
  
  void addUpgrade(int scrollType) {
    switch(scrollType) {
      case(0): PLAYER.stats.x++; n[0]++; break;
      case(1): PLAYER.stats.y++; n[1]++; break;
      case(2): PLAYER.stats.z++; n[2]++; 
    }
  }
  
  void display() {
    displayBg();
    //displayTextBg(borderDim, dim);
    drawUpgrades(borderDim, dim);
  }
  
  void drawUpgrades(PVector P1, PVector d) {
    textAlign(CENTER,CENTER);
    textSize(40);
    float padding = 40; // Adjust spacing between rectangles
    float rectWidth = (d.x - 2 * padding) / 3;
    float rectHeight = d.y * 0.8; // Use 80% of height (adjust as needed)
    
    // Calculate Y-position (center vertically)
    float rectY = P1.y + (d.y - rectHeight) / 2;
    
    float mult = (rectWidth + padding);
    
    float textHeight = rectY + rectHeight/2;
    
    // Draw the 3 rectangles (red, blue, green)
    noStroke(); // Remove borders (optional)
    
    // brutality
    fill(255, 50, 50);
    rect(P1.x + 0*mult, rectY, rectWidth, rectHeight);
    fill(255);
    text("Upgrade Brutality", P1.x + 0*mult + rectWidth/2, textHeight);
    
    // tactics
    fill(50, 50, 255);
    rect(P1.x + 1*mult, rectY, rectWidth, rectHeight);
    fill(255);
    text("Upgrade Tactics", P1.x + 1*mult + rectWidth/2, textHeight);

    
    // survival
    fill(50, 200, 150);
    rect(P1.x + 2*mult, rectY, rectWidth, rectHeight);
    fill(255);
    text("Upgrade Survival", P1.x + 2*mult + rectWidth/2, textHeight);
  }
  
  void filler(int x) {x++;}
  
}
