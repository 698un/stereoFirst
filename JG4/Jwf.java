
import java.net.*;
import java.io.*;

 import processing.*;

public class Jwf extends Thread{
    private int portNumber;
    
    public static boolean vibro;
    
    //parameters of joistic
    public static float mx=0;
    public static float my=0;

    public static String clientMessage=new String("none1");
    private static float ax=0.0f;
    public static float ay=0;
    public static float az=0;
    
    public static JData jdata=new JData();
    
    
    Socket socket;

    //constructor
    public Jwf(Socket inpSocket){
        this.socket = inpSocket;
        setDaemon(true);
        System.out.println("start socket");
        start();
        }//Constructor
    
    
    
   public void run(){


    InputStream input;// =   socket.getInputStream();//поток на входе серверу
    OutputStream output;

        try{
           input =  socket.getInputStream();//поток на входе серверу
           output = socket.getOutputStream();//поток на выходе сервера(о��вет)
         } catch (Exception e) {return;}


    
       int bytesCount;
       byte[] buffer;
       
          try{
           buffer = new byte[256*1024];//массив байт в который запиш������м запрос клиента
           bytesCount = input.read(buffer);//читаем массив байтов на входе
           } catch(Exception e){return;}
          
           //if request is empty
           if (bytesCount<=0) {
              try{  output.flush();
                    output.close();
                    //input.close();
                    //socket.close();
                } catch (Exception e){};
             return;
             }

           //convert full request(in bytes) to one String
           String contentString = new String(buffer,0,bytesCount);
           // parseData();
           //System.out.println(contentString);
           
           clientMessage = contentString;
           
           parseData(clientMessage);
           
           
           StringBuffer response = new StringBuffer("");//Data of result
           
           //answer if joistic search server
           if ("ping".equals(clientMessage)) {       
                 response.append("ok");
                 }
         
           //if need for vibro
           if (vibro==true && response.length()==0){
             response.append("vibro");
             vibro=false;
             }
           
           
           //answer not null!!!
           if (response.length()==0) response.append("none");

          //производим запись параметров ответа
          try {

            output.write(response.toString().getBytes());
            //System.out.println(response);
            output.flush();
            output.close();
           // input.close();
           // socket.close();
            
            } catch (IOException e)
              { 
                System.out.println("IOE");
              }

    }//run




    public static void main(String[] arg){  
      
   
      
        int portNumber = Integer.parseInt(arg[0]);
        System.out.println(portNumber);

        try {
            ServerSocket server = new ServerSocket(portNumber);
       
            //System.out.println(server.getInetAddress());
            
               //.getLocalHost()
            // .getHostAddress());
        
            while (true){
                //System.out.println("wait data");
                new Jwf(server.accept());
                }//while
            }//try

        catch (Exception e) {    System.out.println("error null");       }
  
    }//main;
    
    
   private static void parseData(String parseString){
     System.out.println("parse="+parseString);
     if ("ping".equals(parseString)) return;
    try{
     //parseString.trim();
      String[] flds=parseString.split("#");
      
      //parse Axelerometer
      String[] axelStr=flds[0].split("/");
      ax=Float.parseFloat(axelStr[0])*10.0f;;
      ay=Float.parseFloat(axelStr[1]);
      az=Float.parseFloat(axelStr[2]);
      
      //parse mouse
      String[] mouseFld=flds[1].split("/");
      mx=Float.parseFloat(mouseFld[0]);
      my=Float.parseFloat(mouseFld[1]);
      
      flds=null;
      axelStr=null;
      mouseFld=null;
      
      }//try
      
      catch (Exception e){
        System.out.println("errorformat");    
        }
     
     System.out.println(ax);
     System.out.println(ay);
     
     setAx(ax);
     jdata.ax=Math.round(ax);
     
     System.out.println(jdata.ax);
     
     //myPlayer.camReCalc();
     
   }//parseData
   
   public static float getAx(){
     return ax;
     }
     
  public static void setAx(float x){
    
    ax=x;
    
  }
}//class Jwf


 class JData{
   
   public int ax;
   public JData(){
     this.ax=1;
     }
     
     
     
     
 }//class JData



