#include <Servo.h> 

Servo leftSide;
Servo rightSide

void setup() 
{ 
  pinMode(motorPin,OUTPUT);
  leftSide.attach(5);
  Serial.begin(9600);
} 

void loop() {
  if(Serial.available()){
    int value = Serial.parseInt();
    setMotorSpeed(leftSide, value);
    
  }
}

void setMotorSpeed(Servo motor, int speed){
  int toMotor = map(speed, -127, 127, 700, 2300);
  motor.writeMicroseconds(toMotor);
}

