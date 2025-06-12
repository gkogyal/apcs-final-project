

Camera c;
Stage s;
InputHandler inp;

void setup() {
  fullScreen();
  c = new Camera();
  s = new Stage(1);
  inp = new InputHandler();
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
