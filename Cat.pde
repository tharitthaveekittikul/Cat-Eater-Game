class Cat{
  Body body;
  Vec2 location;
  //Vec2 velocity;
  //Vec2 acceleration;
  Vec2 move;
  float r;
  
  Cat(){
    r = 10;
    BodyDef bd = new BodyDef();
    bd.type = BodyType.DYNAMIC;
    location = bd.position.set(box2d.coordPixelsToWorld(random(width),random(height-200,height/2)));
    //velocity = new Vec2(100,0);
    //acceleration = new Vec2(0,0);
    move = new Vec2(random(-100,100),0);
    body = box2d.createBody(bd);
    
    CircleShape cat_head = new CircleShape();
    cat_head.m_radius = box2d.scalarPixelsToWorld(r);
    
    //CircleShape cat_body = new CircleShape();
    //cat_body.m_radius = box2d.scalarPixelsToWorld(r);
    FixtureDef fd = new FixtureDef();
    fd.shape = cat_head;
    fd.density = 1;
    fd.friction = 0.3;
    fd.restitution = 0.5;
    
    body.createFixture(fd);
    
    body.setUserData(this);
    //fd.setUserData("Cat");
    
    //body.createFixture(cat_body,1.0);
  }
  void run(){
    //update();
    display();
  }
  
  void applyForce(Vec2 force){
    Vec2 pos = body.getWorldCenter();
    body.applyForce(force,pos);
  }
  
  //void update(){
  //  acceleration.add(new Vec2(random(-width,width),0));
  //  velocity.add(acceleration);
  //  location.add(velocity);
  //}
  

  
  void display(){
    Vec2 pos = box2d.getBodyPixelCoord(body);
    float a = body.getAngle();
    
    rectMode(CENTER);
    pushMatrix();
    translate(pos.x,pos.y);
    rotate(-a);
    fill(175);
    stroke(0);
    strokeWeight(2);
    ellipse(0,0,r*2,r*2);
    line(0, 0, r, 0);
    //ellipse(r-25,0,r*2,r*2);
    popMatrix();
  }
 
}
