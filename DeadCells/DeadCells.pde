int ss = 50,h,w,ch,cw;
boolean[][] map;
Player Me;
PVector coord = new PVector(0,0);
boolean manualSpaceType = true;
ArrayList<int[]> spaces = new ArrayList<int[]>();

void setup() {
  size(1600,1000);
  h = height/ss;
  w = width/ss;
  map = new boolean[h][w];
  
  Me = new Player(5,5,300,10);
  Me.dir = new PVector(0,0);
}

void draw() {
  background(0);
  
  noStroke();
  for(int i = 0; i<h; i++) {
    for(int j = 0; j<w; j++) {
      fill(255);
      if(map[i][j]) square(j*ss, i*ss, ss);
    }
  }
  
  for(int[] s : spaces) {
    drawSpace(s,s[4]==1);
  }
  
  fill(255,255,0);
  text("Dir: " + Me.dir.x + ", " + Me.dir.y,30,30);
  text("Coord: " + coord.x + ", " + coord.y,30,60);
  text("Space Type: " + (int(manualSpaceType)), 30, 90);
  
  Me.update();  
  Me.display();
}

void drawSpace(int[] space, boolean spaceType) {
  for(int i = Math.min(space[1],space[3]); i<=Math.max(space[1],space[3]); i++) {
    for(int j = Math.min(space[0],space[2]); j<=Math.max(space[0],space[2]); j++) {
      map[i][j] = spaceType;
    }
  }
}

void keyPressed() {
  switch(keyCode) {
    case('W') : Me.dir.y = -1; break;
    case('S') : Me.dir.y = 1; break;
  }
  switch(keyCode) {
    case('A') : Me.dir.x = -1; break;
    case('D') : Me.dir.x = 1; break;
  }
  if(keyCode=='T') {
    manualSpaceType = !manualSpaceType;
  }
}

void mousePressed() {
  coord = new PVector(mouseX/ss, mouseY/ss);
}

void mouseReleased() {
  int[] s = new int[5];
  
  s[0] = int(coord.x); s[1] = int(coord.y);
  s[2] = mouseX/ss; s[3] = mouseY/ss;
  s[4] = int(manualSpaceType);

  spaces.add(s);
}
