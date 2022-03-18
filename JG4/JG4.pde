

float angleX=0;
float angleY=0;
float angleZ=0;

//axelerometer
//AxMgr accel;
float ax, ay, az;

Fld field;
PGraphics pg1;//
int pWidth;

void setup(){
 
  
  //accel = new AxMgr(this);
  
  //2D because two monitor in screen
  fullScreen(P2D);
  orientation(LANDSCAPE);
  
  pWidth=(int)(width/2*0.75);
  
  pg1=createGraphics(pWidth,
                     displayHeight,
                     OPENGL);
       
  thread("startServer");
  textSize(30);
  //println(LOCAL_IP);
  field=new Fld(20,15);
  
  myPlayer.shp=loadShape("plane1.obj");
  myPlayer.shp.setFill(color(255,255,0));
  reStart();
  }//setup


int score=0;
void reStart(){
    
    //field=new Fld(20,15);
    
   // myPlayer.cPos.set(0,0,0);
    myPlayer.cPos.x=0;
    myPlayer.cPos.y =field.boxInLine*0.77*bw; 
    myPlayer.cPos.z=50;
    
    field=new Fld(20,15);
    
    score=0;
    background(0);
  
    }//reStart




float tOld=0;
float tNow;
float dt;
void draw(){
  
  accelerationEvent();
  
  
  tNow=millis()*0.001;
  dt=tNow-tOld;
  tOld=tNow;
  
  if (gameOverProcess) {
    
         gameOver();
         return;
         }
  
  //take data from netController
 // jData.fromString(Jwf.clientMessage);
  
  
  // myPlayer.control();
  control();
  // myPlayer.display();
  //myPlayer.cPos.x+=1.0;
  //myPlayer.cPos.y+=1.0;
  
  //ellipse(jData.mx,jData.my,10,10);
  
  myPlayer.camReCalc();
  reDraw();
  
  
  if (myPlayer.isImpact()) gameOver();
  
  //write info
  fill(255);
 // text(Jwf.jdata.ax,100,200);
// text(Jwf.ay,100,230);
  text(ay,200,260);
  text("frameRate: "+frameRate,200,290);
  text("Score: "+score,200,320);
  
 // text(Jwf.clientMessage,100,100);
  
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                
  }//draw
  

 public void control(){
   
   //const velocity by X axis
   myPlayer.cPos.x+=500.0*dt;
   
   //gisteresis of rotate
   myPlayer.kren*=exp(-dt*1.0);
   
   //if (touches.length<=0) return;
   
   //float dx=-(touches[0].y-height/2)*0.3;
   //float dy=+(touches[0].x-width/2)*0.5;
   
   //float dy=ay*600.0;
   float dy = 1.0*(mouseX-width*0.5)/width*600;   
   
   
   println(ay);
  // myPlayer.cPos.x+=10;
   myPlayer.moveY(dy*dt);
   
   //if (frameCount%2==0) 
       // thread("fieldUpdate");
 
   }
  
  void fieldUpdate(){
    
    field.update();
    
  }
  
void startServer(){
   String[] args = new String[2];
   args[0] = "8090";
   args[1] = null;
  
   Jwf.main(args); 

   }//startServer

  
 void mousePressed(){

   Jwf.vibro=true;

   }
 
 void reDraw(){

   field.display();
 
   }
 
 public void resume() {
 // if (accel != null) {
  //  accel.resume();
//  }
}

public void pause() {
  //if (accel != null) {
   // accel.pause();
  //}
}
/*
public void shakeEvent(float force) {
  println("shake : " + force);
}
*/
float axelSens=0.15;

void accelerationEvent() {
  
  float y = (mouseX-width/2)/width*10.0;
//  println(mouseX);
  
  
//  println("acceleration: " + x + ", " + y + ", " + z);
  //ax=ax*(axelSens-1) + x*(axelSens);
  
  ay=ay*(axelSens-1) + y*(axelSens);
  
  //az=az*(axelSens-1) + z*(axelSens);
  
  
  
}
