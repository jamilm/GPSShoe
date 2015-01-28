#include <TinyGPS.h> //Import GPS Library
#include <Ultrasonic.h> //Import Ultrasound Library
Ultrasonic ultrasonic( 11, 12 ); //Set Ultrasound I/O Pins


TinyGPS gps; //Start GPS Instance
void getgps(TinyGPS &gps) //Declare the Function
{
}

//Declaring Motor's
int F = 4;
int FR = 7;
int R  = 2;
int BR = 6;
int B = 10;
int BL = 3;
int L  = 8;
int FL = 5;
int Proximity = 9;


void setup() //Run Once
{
  Serial.begin(4800); //Start Serial
  
  //Set I/O Pins
    pinMode(2, OUTPUT);     
    pinMode(3, OUTPUT); 
    pinMode(4, OUTPUT);     
    pinMode(5, OUTPUT); 
    pinMode(6, OUTPUT);     
    pinMode(7, OUTPUT); 
    pinMode(8, OUTPUT);     
    pinMode(9, OUTPUT); 
    pinMode(10, OUTPUT);     
    pinMode(13, INPUT); 
}

void loop() //Loop
{


  
  while(Serial.available())     // While there is data on the RX pin
  {
      int c = Serial.read();    // Load the data into a variable
      if(gps.encode(c))      // If there is a new valid sentence
      {
        getgps(gps);         // Grab the Data
      }
      
  }
 
   float latitude, longitude; //Make Floating Point Numbers
     gps.f_get_position(&latitude, &longitude); //Extract and Imput Latitude and Lonitude from GPS to Varibles
     
  latitude = 46.318288;
  longitude = -79.440744;

float rLong = longitude/180*3.14159265358; //Convert Longitude to Radians
float rLat = latitude/180*3.14159265358; //Convert Latitude to Radians

float dLat = 46.343847; //Declare Destination Latitude 
float dLong = -79.490461; //Declare Destination Longitude 

float drLat = dLat/180*3.14159265358; //Convert Destination Latitude to Radians
float drLong = dLong/180*3.14159265358; //Convert Destination Longitude to Radians

//Find Bearing Between Current Location and Waypoint
int Heading = atan2(sin(drLong-rLong)*cos(drLat),
cos(rLat)*sin(drLat)-sin(rLat)*cos(drLat)*cos(drLong-rLong) )*180/3.14159265358;
Heading = (Heading+360) % 360;

//Make Varible Equal Compass Direction
  long cheading = pulseIn(13, HIGH); 
  cheading = (cheading / 100) - 1;
   if (cheading >360)
 {
   cheading = cheading - 360;
 }
 
 //Find the Angle Relative to the Direction the Person is Pointing and the Waypoint
  int uAngle =  Heading - cheading;
  if(uAngle < 0)
  {
    uAngle = uAngle + 360;
  }
  
  //Find distance of Obstacle 
  int dist = ultrasonic.Ranging(CM);
Serial.println(dist);
int sensVal = constrain(dist, 0, 50); //Constrain to 50 CM

 int val = sensVal;
  val = map(sensVal, 50, 0, 0, 255); //Map Distance to PWM
  analogWrite(9, val); //Power Motor

  Serial.println(cheading);
  Serial.println(Heading);
  Serial.println(uAngle);

//Determine Which Motor to Turn On
  {

  if (uAngle > 338 )
      {
        digitalWrite(F, HIGH); //turn Front Motor On
        digitalWrite(FR, LOW);  //turn Front Right Motor Off
        digitalWrite(R, LOW);   //turn Right Motor Off
        digitalWrite(BR, LOW);  //turn Back Right Motor Off
        digitalWrite(B, LOW);  //turn Back Motor Off
        digitalWrite(BL, LOW);  //turn Back Left Motor Off
        digitalWrite(L, LOW);   //turn Left Motor Off
        digitalWrite(FL, LOW);  //turn Front Left Motor Off

      }
      
        else if (uAngle < 23 )
      {
        digitalWrite(F, HIGH); //turn Front Motor On
        digitalWrite(FR, LOW);  //turn Front Right Motor Off
        digitalWrite(R, LOW);   //turn Right Motor Off
        digitalWrite(BR, LOW);  //turn Back Right Motor Off
        digitalWrite(B, LOW);  //turn Back Motor Off
        digitalWrite(BL, LOW);  //turn Back Left Motor Off
        digitalWrite(L, LOW);   //turn Left Motor Off
        digitalWrite(FL, LOW);  //turn Front Left Motor Off
      }
      
      else if ( uAngle > 24 && uAngle <68)
   {
        digitalWrite(F, LOW); //turn Front Motor Off
        digitalWrite(FR, HIGH);  //turn Front Right Motor On
        digitalWrite(R, LOW);   //turn Right Motor Off
        digitalWrite(BR, LOW);  //turn Back Right Motor Off
        digitalWrite(B, LOW);  //turn Back Motor Off
        digitalWrite(BL, LOW);  //turn Back Left Motor Off
        digitalWrite(L, LOW);   //turn Left Motor Off
        digitalWrite(FL, LOW);  //turn Front Left Motor Off

      }
  
    else if (uAngle >69 && uAngle <114)
   {
        digitalWrite(F, LOW); //turn Front Motor Off
        digitalWrite(FR, LOW);  //turn Front Right Motor Off
        digitalWrite(R, HIGH);   //turn Right Motor On
        digitalWrite(BR, LOW);  //turn Back Right Motor Off
        digitalWrite(B, LOW);  //turn Back Motor Off
        digitalWrite(BL, LOW);  //turn Back Left Motor Off
        digitalWrite(L, LOW);   //turn Left Motor Off
        digitalWrite(FL, LOW);  //turn Front Left Motor Off

      }

      else if (uAngle >115 && uAngle <160)
   {
       digitalWrite(F, LOW); //turn Front Motor Off
        digitalWrite(FR, LOW);  //turn Front Right Motor Off
        digitalWrite(R, LOW);   //turn Right Motor Off
        digitalWrite(BR, HIGH);  //turn Back Right Motor On
        digitalWrite(B, LOW);  //turn Back Motor Off
        digitalWrite(BL, LOW);  //turn Back Left Motor Off
        digitalWrite(L, LOW);   //turn Left Motor Off
        digitalWrite(FL, LOW);  //turn Front Left Motor Off

      }
      
      else if (uAngle >161 && uAngle <206)
   {
        digitalWrite(F, LOW); //turn Front Motor Off
        digitalWrite(FR, LOW);  //turn Front Right Motor Off
        digitalWrite(R, LOW);   //turn Right Motor Off
        digitalWrite(BR, LOW);  //turn Back Right Motor Off
        digitalWrite(B, HIGH);  //turn Back Motor On
        digitalWrite(BL, LOW);  //turn Back Left Motor Off
        digitalWrite(L, LOW);   //turn Left Motor Off
        digitalWrite(FL, LOW);  //turn Front Left Motor Off

      }
      
       else if (uAngle >207 && uAngle <252)
   {
       digitalWrite(F, LOW); //turn Front Motor Off
        digitalWrite(FR, LOW);  //turn Front Right Motor Off
        digitalWrite(R, LOW);   //turn Right Motor Off
        digitalWrite(BR, LOW);  //turn Back Right Motor Off
        digitalWrite(B, LOW);  //turn Back Motor Off
        digitalWrite(BL, HIGH);  //turn Back Left Motor On
        digitalWrite(L, LOW);   //turn Left Motor Off
        digitalWrite(FL, LOW);  //turn Front Left Motor Off
      }

        else if (uAngle >253 && uAngle <298)
   {
       digitalWrite(F, LOW); //turn Front Motor Off
        digitalWrite(FR, LOW);  //turn Front Right Motor Off
        digitalWrite(R, LOW);   //turn Right Motor Off
        digitalWrite(BR, LOW);  //turn Back Right Motor Off
        digitalWrite(B, LOW);  //turn Back Motor Off
        digitalWrite(BL, LOW);  //turn Back Left Motor Off
        digitalWrite(L, HIGH);   //turn Left Motor On
        digitalWrite(FL, LOW);  //turn Front Left Motor Off

      }
      
       else if (uAngle >299 && uAngle <338)
   {
       digitalWrite(F, LOW); //turn Front Motor Off
        digitalWrite(FR, LOW);  //turn Front Right Motor Off
        digitalWrite(R, LOW);   //turn Right Motor Off
        digitalWrite(BR, LOW);  //turn Back Right Motor Off
        digitalWrite(B, LOW);  //turn Back Motor Off
        digitalWrite(BL, LOW);  //turn Back Left Motor Off
        digitalWrite(L, LOW);   //turn Left Motor Off
        digitalWrite(FL, HIGH);  //turn Front Left Motor On
      }
      

    }
}

