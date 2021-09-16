import shiffman.box2d.*;
import org.jbox2d.common.*;
import org.jbox2d.dynamics.joints.*;
import org.jbox2d.collision.shapes.*;
import org.jbox2d.collision.shapes.Shape;
import org.jbox2d.common.*;
import org.jbox2d.dynamics.*;
import org.jbox2d.dynamics.contacts.*;

Box2DProcessing box2d;
ArrayList<Food> food;
Cat cat;
Food f;
Boundary floor;
Boundary wall_L;
Boundary wall_R;
Vec2 wind;

void setup(){
  size(500,500);
  box2d = new Box2DProcessing(this);
  box2d.createWorld();
  box2d.listenForCollisions();
  box2d.setGravity(0,-9.8);
  wind = new Vec2(random(-3.8,-3.8),0);
  cat = new Cat();
  food = new ArrayList<Food>();
  floor = new Boundary(width/2,height+100,width,height);// x,y,w,h location and size
  wall_L = new Boundary(0,0,10,height*2);
  wall_R = new Boundary(width,0,10,height*2);
  
}
void draw(){
  Vec2 move = new Vec2(random(-300,300),random(10,30));
  //println(move);
  box2d.step();
  background(255);
  floor.display();
  wall_L.display();
  wall_R.display();
  
  cat.run();
  cat.applyForce(move);
  
  for(Food f : food){
    f.run();
    f.killBody();
    f.applyForce(wind);
  }
  try{
    f.killBody();
  }
  catch(Exception e){
    
  }
}

void mousePressed(){
  f = new Food();
  food.add(f);
}

void beginContact(Contact cp){
  Fixture f1 = cp.getFixtureA();
  Fixture f2 = cp.getFixtureB();
  
  Body b1 = f1.getBody();
  Body b2 = f2.getBody();
  
  Object o1 = b1.getUserData();
  Object o2 = b2.getUserData();
  
  if(o1.getClass() == Cat.class && o2.getClass() == Food.class){
    //Cat c = (Cat) o1;
    Food f = (Food) o2;
    f.eaten();
  }
}

void endContact(Contact cp){

}

//void keyPressed(){
//  if(key == 'k'){
//    f.killBody();
//  }
