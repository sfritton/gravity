static class ScreenUtils {
  private static float pxpm; // pixels per meter
  private static int screenHeight;
  
  static void init(float p, int h) {
    pxpm = p;
    screenHeight = h;
  }
  
  // The screen is abstracted to allow the use of convenient units.
  static PVector transformVector(float x, float y) {
    return new PVector(x * pxpm + screenHeight/2, -y * pxpm + screenHeight/2);
  }
  
  static PVector transformVector(PVector p) {
    return new PVector(p.x * pxpm + screenHeight/2, -p.y * pxpm + screenHeight/2);
  }
  
  static float transformScalar(float n) {
    return n * pxpm;
  }
}