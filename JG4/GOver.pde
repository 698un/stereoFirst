
boolean gameOverProcess=false;
float timeGameOver=-1;


void gameOver(){
  
  if (gameOverProcess==false) timeGameOver=2.0;
  
  gameOverProcess=true;
  
  timeGameOver+=-dt;
  
  if (timeGameOver<=0) {
          gameOverProcess=false;
          textAlign(LEFT);
          reStart();
          return;
          }
  
  fill(255,0,0,7);
  rect(0,0,width,height);
  textAlign(CENTER);
  fill(255,255,0);
  
  text("your score: " +score,
          width/2-pWidth/2,
          height/2);
          
  //text("your score: " +score,
       //   width/2+pWidth/2,
        //  height/2);
  
  }//gameOver
  
  
  
  