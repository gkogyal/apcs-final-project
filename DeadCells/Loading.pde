class Loading extends Popup {
  /*
  String basePath = dataPath("") + "/popups/";
  String bgStr;
  PImage bg;
  PImage textBg = loadImage("/popups/Text.png");
  */
  final PVector dim = new PVector(600,150);
  final PVector P1 = new PVector(2*dW/3 - dim.x/2, 700 + dim.y/2);
  final PVector P2 = PVector.add(P1,dim);
  
  final PVector textCenter = new PVector(P1.x + dim.x/2, P1.y + dim.y/2);
  
  final String startPhrase = "START";
  final int animFPS = 60; // how often change bg
  final int numBg = 3; // amount of bg's
  int bgNum = 0; // index of current bg
  
  final String[] splashes = new String[] {
    "Grass is green."
    ,"Peter Griffin."
    ,"4815162342 lines of code!"
    ,"Made by Alex and Gephel!"
    ,"Finally working!"
    ,"Add splash text here"
    ,"'let's make dead cells' - alex shao"
    ,"running out of ideas"
  };
  String splash;
  
  final String endPhrase = "Congrats on Finishing!";
  
  public Loading() {
    super("Start0.png");
    randSplash();
  }
  
  void display() {
    setBg();
    
    if(popupType=="start") {
      displayStart();
    } else if (popupType=="waiting") {
      displayWaiting();
    } else if (popupType=="finish") {
      displayFinish();
    }
  }
  
  void setBg() {
    POPUP_IND = 0;
    int n = (frameCount/10) % animFPS;
    if(n==0 && frameCount%10==0) {
      // every animFPS frames, alternate to next background
      setNextBg();
      randSplash();
    }
    displayBg();
    displayTextBg(P1,dim);
  }
  
  void setNextBg() {
    this.setBg("Start" + (bgNum++)%numBg + ".png");
  }
  
  void displayStart() {
    textSize(90); fill(0);
    boldText(startPhrase,textCenter);
  }
  
  void displayWaiting() {
    textSize(43); fill(0);
    boldText(splash,textCenter);
  }
  
  void displayFinish() {
    textSize(50); fill(0);
    boldText(endPhrase,textCenter);
  }
  
  void randSplash() {
    splash = splashes[(int)(Math.random()*splashes.length)];
  }
  
  void filler(int x) {
    switch(x) {
      case 0 : randSplash(); break;
      case 1 : setNextBg(); break;
    }
  }
}
