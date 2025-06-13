Camera c;
Stage s;
InputHandler inp;

private final int dW = displayWidth, dL = displayHeight;
void setup() {
  fullScreen();
  s = new Stage(70, 1);
  c = new Camera(s);
  inp = new InputHandler();
  //printSmap();
}


void draw() {
  try {
    background(#000000);
    c.render(s);
    inp.keys(c);
  }
  catch(Exception e) {

    e.printStackTrace();
  }
}
void printSmap() {
  for (int i = 0; i < s.map.length; i++) {
    for (int j = 0; j < s.map[0].length; j++)
      print((s.map[i][j])? "[]" : "  " );
    println();
  }
}
