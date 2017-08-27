#include <Servo.h>

Servo leftDrive;
Servo rightDrive;
int leftDrivePin = 3;
int rightDrivePin = 5;

int ledPin = 13;

int frontLeftIR = A0;
int frontRightIR = A1;
int leftIR = A2;

int currentPosition;
int targetPosition;

bool isMoving;
bool isForward;
bool isServing;
bool debug = false;

void setup() {
  // Set the pins of the respective drive motors
  leftDrive.attach(leftDrivePin);
  rightDrive.attach(rightDrivePin);

  // Set the pinModes of the respective IR sensors (line trackers)
  pinMode(frontLeftIR, INPUT);
  pinMode(frontRightIR, INPUT);
  pinMode(leftIR, INPUT);

  // Initialize the current position of the robot
  currentPosition = 1;
  targetPosition = 2;

  isMoving = false;
  isServing = false;

  Serial.begin(9600);
  if (!debug) {
    delay(5000);
    if ( (targetPosition != currentPosition)  || isMoving) {
      isMoving = true;
      moveToTarget();
      delay(1500);
    }

    setPosition(3);
    setPosition(4);
    delay(5000);
    turn(-90, 1500);
    delay(500);
    forward(-90, 5000);
    
  }

}

void turn(int speed, int duration) {
  int rightSpeed = speed;
  int leftSpeed = speed;
  setMotorSpeed(rightDrive, rightSpeed); // reverse one side
  setMotorSpeed(leftDrive, leftSpeed);
  delay(duration);
  setMotorSpeed(rightDrive, 0); // reverse one side
  setMotorSpeed(leftDrive, 0);
}

void forward(int speed, int duration){
  int rightSpeed = -speed;
  int leftSpeed = speed;
  setMotorSpeed(rightDrive, rightSpeed); // reverse one side
  setMotorSpeed(leftDrive, leftSpeed);
  delay(duration);
  setMotorSpeed(rightDrive, 0); // reverse one side
  setMotorSpeed(leftDrive, 0);
}

void setPosition(int position) {
  targetPosition = position;
  isMoving = true;
  moveToTarget();
  delay(1500);
}

void loop() {
  printCalibrationValues();
  // Check the serial for settings of position
  //  if (Serial.available()) {
  //    // Check if the robot is moving
  //    if (!isMoving) {
  //      // Set the target position
  //    }
  //  }
  //
  //  // Needs a way to cancel the request; if it cancelled the request as it was turning, finish turn, then move back and go home.
  //
  //   if the robot is being requested to serve

}


// Necessary parameters for update position function
bool isOnFloor = false; // bool to describe if the leftIR is on the floor
const int FLOOR_VALUE = 50; // Lower Bound for Left IR Sensor
const int TAPE_VALUE = 850; // Upper bound for Left IR Sensor
const int RIGHT_FLOOR = 200; // Lower bound for floor for Left IR Sensor
const int LEFT_FLOOR = 200;

void moveToTarget() {
  bool isForward;
  const int moveSpeed = 90;
  // Read when the left sensor jumps from high values to a low value.
  // Update the sensor; increment position if moving forward, decrement otherwise
  while (isMoving) {
    // Determine if moving forward or backwards, make sensor count jumps
    if (targetPosition > currentPosition) {
      // move forward at a good speed
      moveStraight(moveSpeed);
      isForward = true;
      updatePosition(isForward); // position updates by increasing
    } else if (targetPosition < currentPosition) {
      // move backward at a good speed
      isForward = false;
      moveStraight(-(moveSpeed));
      updatePosition(isForward); // position updates by decreasing
    } else {
      // check if overshoot the target, if left sensor jumps from low values to high values
      while (analogRead(leftIR) <= TAPE_VALUE) {
        if (isForward) moveStraight(-50);
        else moveStraight(50);
      }
      moveStraight(0);
      //    turnToDoor();
      //    delay(5000);
      //    turnBack();
      isMoving = false;
    }
  }
}

// TODO Future code
//void turnToDoor() {
//  // turn until the front IR finds something and the left IR finds the stuff
//
//}
//
//void turnBack() {
//
//}

void printCalibrationValues() {
  int sensorValue = analogRead(leftIR);
  int FRIRValue = analogRead(frontRightIR); // front right IR value
  int FLIRValue = analogRead(frontLeftIR); // front left IR value
  Serial.println(String(currentPosition) + "\t" + String(sensorValue) + "\t" + String(FLIRValue) + "\t" + String(FRIRValue));

}

void updatePosition(bool isForward) {
  int sensorValue = analogRead(leftIR);
  if (sensorValue < FLOOR_VALUE) {
    isOnFloor = true;
  }
  if (sensorValue > TAPE_VALUE) {
    // if it was on the floor previously
    if (isOnFloor) {
      if (isForward) currentPosition++;
      else currentPosition--;
    }
    isOnFloor = false;
  }
}

void moveStraight(int speed) {
  int FRIRValue = analogRead(frontRightIR); // front right IR value
  int FLIRValue = analogRead(frontLeftIR); // front left IR value
  int rightSpeed = -speed;
  int leftSpeed = speed;
  int forwardCoef = 3;
  int backwardCoef = 4;
  if (FRIRValue < RIGHT_FLOOR && FLIRValue < LEFT_FLOOR) {

  }
  else if (FRIRValue < RIGHT_FLOOR) {
    if (speed > 0) {
      leftSpeed /= forwardCoef;
    } else {
      rightSpeed /= backwardCoef;
    }
  }
  else if (FLIRValue < LEFT_FLOOR) {
    if (speed > 0) {
      rightSpeed /= forwardCoef;
    } else {
      leftSpeed /= backwardCoef;
    }
  }
  if (!debug) {
    setMotorSpeed(rightDrive, rightSpeed); // reverse one side
    setMotorSpeed(leftDrive, leftSpeed);
  }
}

void setMotorSpeed(Servo motor, int speed) {
  // The maximum pulse width (microseconds) accepted by VEX Motor Controller 29
  int maxuS = 2300;
  // The minimum pulse width (microseconds) accepted by VEX Motor Controller 29
  int minuS = 700;

  int toMotor = map(speed, -127, 127, minuS, maxuS);
  motor.writeMicroseconds(toMotor);
}


