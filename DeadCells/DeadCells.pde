void setup() {
  size(400, 200);
 
  // Get screen resolution
  int screenWidth = displayWidth;
  int screenHeight = displayHeight;
  println("Screen resolution: " + screenWidth + "x" + screenHeight);
 
  // Get DPI (dots per inch)
  float dpi = java.awt.Toolkit.getDefaultToolkit().getScreenResolution();
  println("Screen DPI: " + dpi);
 
  // Calculate screen size in inches
  float screenWidthInches = screenWidth / dpi;
  float screenHeightInches = screenHeight / dpi;
  float diagonalInches = sqrt(sq(screenWidthInches) + sq(screenHeightInches));
 
  println("\nEstimated screen size (inches):");
  println("Width: " + nf(screenWidthInches, 1, 1) + "\"");
  println("Height: " + nf(screenHeightInches, 1, 1) + "\"");
  println("Diagonal: " + nf(diagonalInches, 1, 1) + "\"");
}

void draw() {
  background(220);
  text("Check console for screen size info.", 20, 50);
}
