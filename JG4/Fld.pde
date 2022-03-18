
/**
 this class is field
 */

Player myPlayer=new Player();

class Player {

  PVector cPos=new PVector(0, 0, 0);
  PVector cDir=new PVector(1, 0, 0);
  PVector cHor=new PVector(0, 1, 0);
  PVector cTrg=new PVector(100, 0, 0);
  float size=displayWidth*0.05;
  float aperture = 20.0f;
  PVector de = new PVector(0,0,0);  
  float kren=0;
  PShape shp;
  
  public Player() {
    this.cPos.x=bw*5.0;
    this.cPos.y=0.0;
    this.cPos.z=75.0;
    this.size=30;

    this.cDir.set(1, 0, 0);
    }//constructor
    
    
  public void moveY(float dy ){
    
     
     this.kren+=dy*0.003;
     
     this.cPos.y+=dy;//*abs(this.kren);
     
     
    // this.cPos.y+=this.kren*10.0;
     
     }//rorate
    
 public boolean isImpact(){
   
   int xi=(int)(cPos.x/bw);
   int yi=(int)(cPos.y/bw);
   score=xi;
   if (getH(xi,yi)>cPos.z) return true;
   
   
   
  return false;
   
   
   
   
 }




  //camReCalc
  void camReCalc() {
    
    cHor.x=-cDir.y;
    cHor.y=+cDir.x;
    cHor.z=0;

    cTrg.set(cPos.x+cDir.x*1000.0, 
             cPos.y+cDir.y*1000.0, 
             cPos.z+cDir.z*1000.0);

    //vector betwen eye
    de.x = cHor.x*aperture;
    de.y = cHor.y*aperture;
    de.z = cHor.z*aperture;
    
    
  }//camReCalc
  
  
  void control() {


    this.cPos.y+=(mouseX-width/2)*0.01;
    this.cPos.x-=(mouseY-height/2)*0.01;

  //  return;
    
    
     //synchronize(Jwf){
     this.cPos.x+=Jwf.getAx();//ax;
     this.cPos.y+=Jwf.ay;
     
     //Jwf.ax*=0.95;
    // Jwf.ay*=0.95;
     
     
     
   //  }
    // println("ay="+Jwf.ay);
     
     /*
     if (this.cPos.x<0)     this.cPos.x=0;
     if (this.cPos.x>width) this.cPos.x=width;
     
     this.cPos.y+=jData.ax;
     
     if (this.cPos.y<0)      this.cPos.y=0;
     if (this.cPos.y>height) this.cPos.y=height;
     
     */
  }//control





}//class Player

//width of box
float bw=100.0;
int changWidth=10;

class VIndex{
   int i;
   int j;
   VIndex(int inpI,int inpJ){
     this.i=inpI;
     this.j=inpJ;
     }
   }//class VIndex
   
class Fld {

  //width of the one box

  PShape[] shapeLine;//array of shape by direction
  int [] shpXPos;//position of shape
  
  
  int boxInLine=20;
  int boxInDir=10;
  
  //constructor
  Fld(int bForward,int bWidth) {
  
    
    this.boxInLine=bWidth;
    this.boxInDir=bForward;
    
    shapeLine=new PShape[boxInDir];
    shpXPos=  new int[boxInDir];
    
    
    //defined cell of player
    int ax=(int)(myPlayer.cPos.x/bw);
    
    //generate start shapes
    for(int i=0;i<boxInDir;i++){  
       shapeLine[i]=getShapeLine(ax+i);
       shpXPos[i]=ax+i;
       }//next i
   
    
  }//constructor

 //prgShellFor create shpLine in thread
 void createLineInArray(int index,
                        int xPosi){
                          
     //markAsUncomplette
     this.shpXPos[index]=-1;
     
     PShape newLine=getShapeLine(xPosi);
     
     
     shapeLine[index]=newLine;
     //markAsComplette
     this.shpXPos[index]=xPosi;
     
     
     }//createLinrInArray

 
 PShape getShapeLine(int posXi){
   
   //defined leftPosition of cell
   int ay=(int)(myPlayer.cPos.y/bw);
   
   //create shape of line of box
   PShape lineAll=createShape(GROUP);
   
   for (int j=ay-boxInLine;
            j<=ay+boxInLine;
            j++){
      
     lineAll.addChild(
             boxCreate(posXi,j)
             );
            
     }//next j
        
   return lineAll;
   
   }//getShapeLine
   
   
  

  public PShape boxCreate(int xi, 
    int yi) {

    float h=getH(xi, yi);

    //PShape box1=createShape(BOX,200.0);
    PShape box2=createShape(GROUP);

    float fx1, fx2, fy1, fy2;



    fx1 = xi*bw;
    fx2 = (xi+1)*bw;

    fy1 = yi*bw;
    fy2 = (yi+1)*bw;

    //frontFace
    PShape fc=createShape();
    fc.beginShape(); 
    fc.vertex(fx1, fy1, 0);
    fc.vertex(fx1, fy1, h);
    fc.vertex(fx1, fy2, h);
    fc.vertex(fx1, fy2, 0);
    fc.endShape(CLOSE);
    box2.addChild(fc);

    //LeftFace
    fc=createShape();
    fc.beginShape(); 
    fc.vertex(fx1, fy1, 0);
    fc.vertex(fx2, fy1, 0);
    fc.vertex(fx2, fy1, h);
    fc.vertex(fx1, fy1, h);
    fc.endShape(CLOSE);
    box2.addChild(fc);

    //RightFace
    fc=createShape();
    fc.beginShape(); 
    fc.vertex(fx1, fy2, 0);
    fc.vertex(fx2, fy2, 0);
    fc.vertex(fx2, fy2, h);
    fc.vertex(fx1, fy2, h);
    fc.endShape(CLOSE);
    box2.addChild(fc);

    //TOPFace
    fc=createShape();
    fc.beginShape(); 
    fc.vertex(fx1, fy1, h);
    fc.vertex(fx2, fy1, h);
    fc.vertex(fx2, fy2, h);
    fc.vertex(fx1, fy2, h);
    fc.endShape(CLOSE);
    box2.addChild(fc);

    //box2.setFill(color(255, 255, 0));
    box2.setStroke(color(255, 0, 0));


    //reposition vertext of the box


    return box2;
  }//boxCreate


  void display() {
    
    
    PVector de = myPlayer.de;
    
    //reCalc transparent
    float dz;
    float alpha;
    for(int i=0;i<this.boxInDir;i++){
    
      dz=(shpXPos[i]*bw-myPlayer.cPos.x)/bw*20.0;
      dz=255-dz;
      if (dz<0) dz=0;
      
      alpha=dz*3;
      if (alpha>255) alpha=255;
      //alpha=255;
      shapeLine[i].setFill(color(dz,dz,dz,alpha));
      }//next i
    
    
    
    //Left eye
    de=myPlayer.de.mult(-1);
    pgRedraw(de);
    image(pg1,width/2-pWidth,0);
    
    //Right eye
    de=myPlayer.de.mult(-1);
    pgRedraw(de);
    image(pg1,width/2,0);
    
    stroke(0);
    line(width/2,0,
         width/2,height);
 
    if (frameCount%5==0) update();
    
    }

  void pgRedraw(PVector de){
    
    pg1.beginDraw();
    pg1.background(64,127,255);
    
    //set camera as player
    pg1.camera(-200.0+myPlayer.cPos.x+de.x,
               myPlayer.cPos.y+de.y,
               75+myPlayer.cPos.z+de.z,
               
               myPlayer.cTrg.x+de.x,
               myPlayer.cTrg.y+de.y,
               myPlayer.cTrg.z+de.z,
               
               0,0,-1);
               
               
    //pg1.lights();
    pg1.pointLight(127,127,127,
                   myPlayer.cPos.x,
                   myPlayer.cPos.y,
                   bw+myPlayer.cPos.z);
    
    pg1.pointLight(127,127,127,
                   myPlayer.cPos.x,
                   myPlayer.cPos.y,
                   bw*0.25+myPlayer.cPos.z);
               
                   
                   
                   
                 //  255,0,0);
  
   
   for(int i=0;i<this.boxInDir;i++){
      //draw only complette shapeLine
      if (shpXPos[i]>0) pg1.shape(shapeLine[i]);
      }//next i
   
   pg1.translate(myPlayer.cPos.x,
                 myPlayer.cPos.y,
                 myPlayer.cPos.z);
   pg1.scale(20);
   pg1.noStroke();
   pg1.rotateX(-myPlayer.kren+HALF_PI);
   pg1.shape(myPlayer.shp);
   //pg1.box(10);
   
   pg1.endDraw();
    
   }//pgRedraw

  /**
   this method define deprecated 
   shapes in field 
   and create new actual shape in the field
   */
   
    
  void update() {
    
    int playerPosXi=(int)(myPlayer.cPos.x/bw);
    
    
    
     //run by all lines
     for (int i=0;i<this.boxInDir;i++){
       
       //not verify inComplette lines
       if (shpXPos[i]<0) continue;
       
       if (shpXPos[i]<playerPosXi){
         
          createLineInArray(i,
                            shpXPos[i]+this.boxInDir);
                      
         
          }//if inViewField
          
       
       
       
       
     }//next i
     

     }//update
    
}//class Fld


float getH(int xi, int yi) {

    float rnd = (1+sin(sin(yi*4739.33+2747.34)*xi*2343+yi*cos(xi*23212)))*0.5;
    
    float rnd1=47784.2388+xi*yi*3774.3993-xi*388.43;
    
    rnd1=(1+sin(rnd1))*0.5;
    
    float limit=exp(-xi*0.0001);
    
    if (rnd1<limit) rnd*=0.1;
    
    float h = 10+rnd*200.0;
    
    return h;
    }//getH




