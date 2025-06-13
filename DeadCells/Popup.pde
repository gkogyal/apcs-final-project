abstract class Popup {
  String basePath = dataPath("") + "/popups/";
  String bgStr;
  PImage bg;
  PImage textBg = loadImage(dataPath("") + "/popups/Text.png");
  
  String popupType;
  
  public Popup(String bgString) {
    this.bgStr = basePath + bgString;
    this.bg = loadImage(bgStr);
  }
  
  void displayBg() {
    image(bg,0,0,dW,dL);
  }
  
  void displayTextBg(PVector coords, PVector dimensions) {
    image(textBg,coords.x,coords.y,dimensions.x, dimensions.y);
  }
  
  void setBg(String bgString) {
    this.bgStr = basePath + bgString;
    bg = loadImage(bgStr);
  }
  
  void setType(String type) {
    popupType = type;
  }
  
  String getType() {
    return popupType;
  }
  
  void boldText(String phrase, PVector P1) {
    textAlign(CENTER,CENTER);
    for(int i = -1; i<2; i++) {
      for(int j = -1; j<2; j++) {
        text(phrase,P1.x+i, P1.y+j);
      }
    }
  }
  
  abstract void display();
  
  abstract void filler(int x);
  
}
