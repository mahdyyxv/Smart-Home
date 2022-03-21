// libraries
#include <ESP8266WiFi.h>

// variables



const char* ssid = "Your ssid name "; 
const char* password = " ssid password";


const char MAIN_page[] PROGMEM = R"=====(
<!DOCTYPE html>
<html>
<head>
 <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
  <meta charset="utf-8">
  <title>
    SMART ROOM CONTROL PAGE
  </title>
</head>
<body>
  <div class="bg-image" style="
      background-image: url('https://www.shutterstock.com/image-illustration/3d-rendered-illustration-low-poly-black-1926483812');
      height: 100vh;
    ">
      <div style=" text-align: center;">
      <h1 style="padding-top: 10px ;font-family: serif;">
        <p style="display: flex ; border-bottom-style: solid ; border-color: #FFECB3 ; ">
          HELLO TO MY SMART ROOM  
        </p><br>
      </h1>
      <div class = "ST" style="text-align: left; padding-top: 100;" >
          <p class="lamb"> lamb state is:" + R1State + "  </p>
          <p class="lamb2"> lamb2 state is:" + R2State + "   </p>
          <p class="lamb3"> lamb3 state is:" + R3State + "   </p>
          <p class="WASHING"> Waching machine state is:" + R4State + "   </p>
          <p class="AIRCON"> Air cond state is:" + R5State + "   </p> 
        </div>
      <h3 style="padding-bottom: 10px ;">
        LIGHT CONTROL <br>
      </h3>
      <div style="padding-bottom: 10px ;">
        <a href="/LIGHT=ON/OFF"> 
          <button type="button" class="btn btn-outline-success">TURN LIGHT ON / OFF</button>
        </a>
      </div>
      <h3 style="padding-bottom: 10px ;">
        AIRCON CONTROL <br>
      </h3>
      <div style="padding-bottom: 10px ;">
        <a href="/AIRCON=ON/OFF"> 
          <button type="button" class="btn btn-outline-success">TURN AIRCON ON / OFF</button>
        </a>
      </div>
      <h3 style="padding-bottom: 10px ;">
        WASHING MACHINE CONTROL <br>
      </h3>
      <div style="padding-bottom: 10px ;">
        <a href="/WM=ON/OFF"> 
          <button type="button" class="btn btn-outline-success">TURN WASHING MACHINE ON / OFF</button>
        </a>
      </div>
      <h3 style="padding-bottom: 10px ;">
        TEMP AND GAS STATUS <br>
      </h3>
      <div style="padding-bottom: 10px ;">
        <a href="/GT"> 
          <button type="button" class="btn btn-outline-success">GET</button>
        </a>
      </div>
    </div>
    
    </div>
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM" crossorigin="anonymous"></script>

</body>
</html>
)=====";

String GASTMP = "1234567891DB";
String RST = "00000000000B";
String R1ONOFF ="1234567891QB";
String R2ONOFF ="1234567891WB";
String R3ONOFF ="1234567891EB";
String R4ONOFF ="1234567891RB";
String R5ONOFF ="1234567891TB";
unsigned long myTime;
int R1State, R2State, R3State, R4State, R5State;



//IPAddress local_IP(192, 168, 1, 66);
//IPAddress gateway(192, 168, 1, 1);
//IPAddress subnet(255, 255, 255, 0);


WiFiServer server(80);
//declare functions

// setup 

void setup() {
  Serial.begin(9600);
  delay(50); 
  pinMode(14, INPUT);
  pinMode(12, OUTPUT);
  
//  if (!WiFi.config(local_IP, gateway, subnet)){}

  WiFi.begin(ssid, password);
  

  while (WiFi.status() != WL_CONNECTED) {
    delay(100);
  }
  
  server.begin();
}

//////////////////////////////////////// CODE /////////////////////////////////////

void loop() {
  WiFiClient client = server.available();

  label:
  myTime=millis();
  if(myTime >= 9000){goto label2;}
  
  if(!client){
    Serial.printf("%sAB", WiFi.localIP().toString().c_str());
    goto label;
  }
  
  // Read the first line of the requests
  
    label2:
    String request = client.readStringUntil('\r');    
    client.flush();
    
    // Match the request
  
    if (request.indexOf("/LIGHT=ON/OFF") != -1)  {
      Serial.print(RST);
      delay(1);
      Serial.print(R1ONOFF);
    }
    if (request.indexOf("/LIGHT2=ON/OFF") != -1)  {
      Serial.print(RST);
      delay(1);
      Serial.print(R2ONOFF);
    }
    if (request.indexOf("/LIGHT3=ON/OFF") != -1)  {
      Serial.print(RST);
      delay(1);
      Serial.print(R3ONOFF);
    }
      
    if (request.indexOf("/AIRCON=ON/OFF") != -1)  {
      Serial.print(RST);
      delay(1);
      Serial.print(R4ONOFF);
    }
    
    if (request.indexOf("/WM=ON/OFF") != -1)  {
      Serial.print(RST);
      delay(1);
      Serial.print(R5ONOFF);
    }
    
    if (request.indexOf("/GT") != -1)  {
      Serial.print(RST);
      delay(1);
      Serial.print(GASTMP);
    }      
  String s = MAIN_page;
  client.println(s);
  // Return the response  
  delay(1);

 
}




/*
 *   
//  while(Serial.available()<=0){
//      myTime=millis();
//      Serial.printf("%sAB", WiFi.localIP().toString().c_str());
//      
//      if(myTime <= 8600){break;}
//  }
  
  //   Check if a client has connected 
//  while(!Serial.available()){
//    myTime=millis();
//    if(myTime >= 9000){break;}
//    Serial.printf("%sAB", WiFi.localIP().toString().c_str());
//    delay(50);
//    return;
//  }
// 
//  
  if(digitalRead(14) == HIGH){
   
   if(Serial.available()>0){
     String inByte = Serial.readStringUntil('B');
     char delimeter = inByte[9];
//    ;Serial.print("AB")
     if(delimeter == '0'){delay(100);}
//     switch(delimeter){
//      case '0':delay(100);Serial.print("192.168.1.180AB");break;
//
//      case 'A': 
//        client.println("<div class = \"ST\" style=\"text-align: left; padding-top: 100;\" ><p class=\"lamb\"> lamb state is: OFF </p></div>");
//        break;
//      case 'B':  
//        client.println("<div class = \"ST\" style=\"text-align: left; padding-top: 100;\" ><p class=\"lamb\"> lamb state is: OFF </p></div>");
//        break;
//      case 'C': 
//        client.println("<div class = \"ST\" style=\"text-align: left; padding-top: 100;\" ><p class=\"lamb2\"> lamb2 state is: OFF </p></div>");
//        break;
//      case 'D': 
//        client.println("<div class = \"ST\" style=\"text-align: left; padding-top: 100;\" ><p class=\"lamb2\"> lamb2 state is: OFF </p></div>");
//        break;
//      case 'E': 
//        client.println("<div class = \"ST\" style=\"text-align: left; padding-top: 100;\" ><p class=\"lamb3\"> lamb3 state is: OFF </p></div>");
//        break;
//      case 'F': 
//        client.println("<div class = \"ST\" style=\"text-align: left; padding-top: 100;\" ><p class=\"lamb3\"> lamb3 state is: OFF </p></div>");
//        break;
//      case 'G':
//        client.println("<div class = \"ST\" style=\"text-align: left; padding-top: 100;\" ><p class=\"WASHING\"> Washing machine state is: ON </p></div>");
//        break;
//      case 'H': 
//        client.println("<div class = \"ST\" style=\"text-align: left; padding-top: 100;\" ><p class=\"WASHING\"> Washing machine state is: OFF </p></div>");
//        break;
//      case 'I': 
//        client.println("<div class = \"ST\" style=\"text-align: left; padding-top: 100;\" ><p class=\"AIRCON\"> Air cond state is: ON </p></div>");
//        break;
//      case 'J': 
//        client.println("<div class = \"ST\" style=\"text-align: left; padding-top: 100;\" ><p class=\"AIRCON\"> Air cond state is: OFF </p></div>");
//        break;
//      default: digitalWrite(12,LOW);
//     }
//     
   }
  }*/
