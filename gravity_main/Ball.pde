class Ball {
  protected float mass;
  protected float radius;
  protected PVector position;
  protected PVector velocity;
  protected PVector netForces;
  
  public Ball(float mass,
              float radius, 
              PVector position, 
              PVector velocity) {
    this.mass = mass;
    this.radius = radius;
    this.position = position;
    this.velocity = velocity;
    this.netForces = new PVector(0, 0);
  }
  
  public void updatePosition(float deltaT) {
    PVector acceleration = PVector.div(this.netForces, this.mass);
    this.velocity.add(PVector.mult(acceleration, deltaT));
    this.position.add(PVector.mult(this.velocity, deltaT));
    
    // move out of other balls
      for (int i=0; i < balls.size(); i++) {
        Ball b = balls.get(i);
        if (b == this) {
          continue;
        }
        
        PVector norm = PVector.sub(this.position, b.position);
        if (norm.mag() < this.radius + b.radius) {
          this.position = PVector.add(b.position, PVector.mult(norm.normalize(), (this.radius + b.radius)));
          this.velocity.add(PVector.mult(norm.normalize(), this.velocity.dot(norm) * -2 * BOUNCE));
        }
      }
  }
  
  public void clearForces() {
    this.netForces = new PVector(0, 0);
  }
  
  public void addForce(PVector force) {
    this.netForces.add(force);
  }
  
  public void render() {
    noStroke();
    setColor();
    PVector pos = ScreenUtils.transformVector(this.position);
    ellipse(pos.x, 
            pos.y, 
            ScreenUtils.transformScalar(this.radius*2), 
            ScreenUtils.transformScalar(this.radius*2));
  }
  
  protected void setColor() {
    float maxMass = 500;
    float cappedMass = this.mass > maxMass ? maxMass : this.mass;
    float col = (1 - cappedMass / maxMass) * 255;
    fill(100, col, 255);
  }
}