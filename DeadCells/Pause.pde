class Pause extends Popup {
  /*
  String bgSprite;
  PImage bg;
  String textBgSprite;
  PImage textBg;
  */
  
  String bgSprite = "/popup/pauseBG.png";
  PImage bg = loadImage("/popup/pauseBG.png"); // image of background

  public void pause() {
    PAUSED = true;
    image(bg,0,0,width,height);
  }
  
  void showMap() {
    pause();
    
  }
  
  void showInv() {
    pause();
    
  }
  
}
