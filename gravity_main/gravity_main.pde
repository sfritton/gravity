public static final float GRAVITY = .2;
public static final boolean TAILS = true;
public static final float BOUNCE = .99;

ArrayList<Ball> balls = new ArrayList<Ball>();

int prevMS, currMS;

void setup() {
  size(1600, 1600);
  ScreenUtils.init(height/35, height);
  background(0);
  solarSystem();
  //hollowPlanet(10, 30);
  
  //balls.add(new Ball(5, .3, new PVector(0, 0.1), new PVector(0, 0)));
  
  currMS = millis();
}

void draw() {
  updateStep();
  renderStep();
}

void updateStep() {
  calculateForces();
  float deltaT = calculateTime();
  updatePositions(deltaT);
}

void renderStep() {
  if (TAILS) {    
    fill(0, 4);
    rect(0, 0, width, height);
  } else {
    background(0);
  }
  
  for (int i=0; i < balls.size(); i++) {
    Ball b = balls.get(i);
    b.render();
  }
}

float calculateTime() {
  prevMS = currMS;
  currMS = millis();
  return float(currMS - prevMS)/1000;
}

void calculateForces() {
  for (int i=0; i < balls.size(); i++) {
    Ball ball = balls.get(i);
    ball.clearForces();
  }
  
  for (int i=0; i < balls.size(); i++) {
    Ball b1 = balls.get(i);
    
    for (int j=i+1; j < balls.size(); j++) {
      Ball b2 = balls.get(j);
      PVector force = calculateGravity(b1, b2);
      b1.addForce(force);
      b2.addForce(PVector.mult(force, -1));
    }
  }
}

void updatePositions(float deltaT) {
  for (int i=0; i < balls.size(); i++) {
    Ball b = balls.get(i);
    b.updatePosition(deltaT);
  }
}

PVector calculateGravity(Ball b1, Ball b2) {
  if (null == b1 || null == b2) {
    return new PVector(0, 0);
  }
  
  PVector distance = PVector.sub(b2.position, b1.position);
  
  float mag = distance.mag();
  if (mag == 0) {
    return new PVector(0, 0);
  }
  
  float constant = GRAVITY * b1.mass * b2.mass / (mag * mag * mag);
  
  PVector gravity = PVector.mult(distance, constant);
  return gravity;
}

void solarSystem() {
  balls.add(new FixedBall(5000, 1, new PVector(0, 0)));
  balls.add(new Ball(50, .3, new PVector(0, -8), new PVector(7.5, 0)));
  balls.add(new Ball(50, .3, new PVector(0, 12), new PVector(7.5, 0)));
  balls.add(new Ball(1, .1, new PVector(0, 13), new PVector(5.2, 0)));
}

void hollowPlanet(float radius, float corners) {
  for (int i=0; i < corners; i++) {
    float angle = i * 2 * PI / corners;
    balls.add(new FixedBall(50, .6, new PVector(radius * sin(angle), radius * cos(angle))));
  }
}