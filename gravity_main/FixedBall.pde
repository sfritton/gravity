class FixedBall extends Ball {
  
  public FixedBall(float mass, float radius, PVector position) {
    super(mass, radius, position, new PVector(0,0));
  }
  
  public void updatePosition(float deltaT) {
    return;
  }
  
  protected void setColor() {
    fill(50, 200, 50);
  }
}