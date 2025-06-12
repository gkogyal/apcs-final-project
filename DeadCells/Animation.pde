class Animation {
  
  String basePath = "/entities/";
  
  ArrayList<String> states = new ArrayList<String>(){{
    // universal sprite states:
    add("idle");
    add("run");
    add("up");
    add("down");
    add("damaged");
  }};
  
  int stateInd;
  String state;
  String path;
  
  public Animation(boolean isEnemy, String ent) {
    basePath += ((isEnemy) ? "enemies/" : "") + ent + "/sprites/";
    // this is the path to the directory which holds all of the sprite of the entity
    setState(0);
  }
  
  void addState(String str) {
    states.add(str);
  }
  
  void addStates(String[] arr) {
    for(String str : arr) {
      addState(str);
    }
  }
  
  void setState(String str) {
    int ind = Util.locateArrL(str,states);
    if(ind>=0) {
      stateInd = ind;
      state = str;
      path = basePath + state;
    }
  }
  
  void setState(int n) {
    if(n<states.size() && n>=0) {
      stateInd = n;
      state = states.get(n);
      path = basePath + state;
    }
  }
  
  int getCycleLen() {
    try {
      return (new File(path)).listFiles().length; // .listFiles() returns File[] of all files in a directory
    } catch(Exception e) {
      e.printStackTrace();
      println("path was invalid");
      return -1;
    }
  }
  
  ArrayList<PImage> getCycle() {
    
    ArrayList<PImage> imageCycle = new ArrayList<PImage>();
    
    for(int i = 0; i<getCycleLen(); i++) {
      imageCycle.add(loadImage(path + "/" + i + ".png")); // each frame is labeled 0.png, 1.png, 2.png...
    }
    
    return imageCycle;
  }
  
  PImage getFrame() {
    return loadImage(path + "/" + frameCount%getCycleLen() + ".png");
  }
}
