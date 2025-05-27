int ss = 25,h,w;
boolean[][] map;
Player Me;
PVector coord = new PVector(0,0);
boolean manualSpaceType = true; boolean editor;
ArrayList<int[]> spaces = new ArrayList<int[]>();
//Stage stage;
boolean paused;

void setup() {
  size(1600,1000);
  h = height/ss;
  w = width/ss;
  map = new boolean[h][w];
  
  createStage(20);
  PVector start = playerStart();
  Me = new Player(0,0,300);
  if(start!=null) Me.modLoc(start);
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

// checks intersection of 2 rooms
boolean intersects(int[] A, int[] B) {
  return !( B[2] < A[0] || B[0] > A[2] || B[3] < A[1] || B[1] > A[3] );
}

// horizontal hall
void hHall(int y, int x1, int x2) {
  for (int x = min(x1, x2); x <= max(x1, x2); x++) {
    map[y][x] = true;
    map[y+1][x] = true;
  }
}
// vertical hall
void vHall(int x, int y1, int y2) {
  for (int y = min(y1, y2); y <= max(y1, y2); y++) {
    map[y][x] = true;
    map[y][x+1] = true;
  }
}
//connects centers with L hallway
void connectPoints(int x1, int y1, int x2, int y2) {
  if (random(1) < 0.5) {
    //right,up
    hHall(y1, x1, x2);
    vHall(x2, y1, y2);
  } else {
    //up,right
    vHall(x1, y1, y2);
    hHall(y2, x1, x2);
  }
}

void createStage(int n) {  
  // placing rooms
  ArrayList<int[]> rooms = new ArrayList<int[]>();
  int attempts = 0;
  while (rooms.size() < n && attempts < n * 5) {
    attempts++;
    int rw = int(random(4, 10)); //width
    int rh = int(random(3, 5)); //height
    int x1 = int(random(0, w - rw)); //top left coords
    int y1 = int(random(0, h - rh));
    int x2 = x1 + rw;
    int y2 = y1 + rh;
    int[] room = { x1, y1, x2, y2, 1 }; //room data
    
    boolean ok = true;
    for (int[] other : rooms) {
      if (intersects(room, other)) {
        ok = false;
        break;
      }
    }
    if (!ok) continue;
    
    // add room
    rooms.add(room);
    spaces.add(room);
    drawSpace(room, true);
  }
  
  //this just connects rooms to the previously generated using hallways
  for (int i = 1; i < rooms.size(); i++) {
    int[] A = rooms.get(i - 1);
    int[] B = rooms.get(i);
    int ax = (A[0] + A[2]) / 2, ay = (A[1] + A[3]) / 2;
    int bx = (B[0] + B[2]) / 2, by = (B[1] + B[3]) / 2;
    if(random(1)>0.01) connectPoints(ax, ay, bx, by);
  }
}

PVector playerStart() {
  //finds leftmost
  for (int x = 0; x < w; x++) {
    for (int y = h-3; y >=0; y--) {
      if (map[y][x] && map[y+1][x] && !map[y+2][x]) {       // both cells are empty
        return new PVector(x, y);
      }
    }
  }
  return null;  // no suitable spot found
}

void keyPressed() {
  
  if(keyCode == 'W' || keyCode == 'S') {
    Me.modDirY((keyCode == 'W') ? -1 : 1);
  }
  
  if(keyCode == 'A' || keyCode == 'D') {
    Me.modDirX((keyCode == 'A') ? -1 : 1);
  }
  
  if(keyCode=='T') {
    manualSpaceType = !manualSpaceType;
  }
  
  if(keyCode=='E') {
    editor = !editor;
  }
}

void mousePressed() {
  coord = new PVector(mouseX/ss, mouseY/ss);
}

void mouseReleased() {
  if(editor) {
    int[] s = new int[5];
    
    s[0] = int(coord.x); s[1] = int(coord.y);
    s[2] = mouseX/ss; s[3] = mouseY/ss;
    s[4] = int(manualSpaceType);
  
    spaces.add(s);
  } else {
    Me.attack();
  }
  
}
