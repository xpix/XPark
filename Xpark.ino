//****************************************************************
/*
* Xpark spooter
* XPIX Development /  Frank Herrmann info@xpix.de
*
* sleepavr code from:
* KHM 2008 / Lab3/  Martin Nawrath nawrath@khm.de
* Kunsthochschule fuer Medien Koeln
* Academy of Media Arts Cologne
*/
//****************************************************************

#include <avr/sleep.h>
#include <avr/wdt.h>
#include "Ultrasonic.h"

#ifndef cbi
#define cbi(sfr, bit) (_SFR_BYTE(sfr) &= ~_BV(bit))
#endif
#ifndef sbi
#define sbi(sfr, bit) (_SFR_BYTE(sfr) |= _BV(bit))
#endif

#define ECHOPIN 2        // Pin to receive echo pulse
#define TRIGPIN 3        // Pin to send trigger pulse
#define MAX_DISTANCE 300 // Maximum distance we want to ping for (in centimeters). Maximum sensor distance is rated at 400-500cm.
#define ULTRAPW 4        // Pin to power up Ultrasonic

#define PINSTATUSLED 10

#define PINRED 7        // LED RED
#define PINGREEN 6      // LED GREEN
#define PINYELLOW 5     // LED YELLOW

#define PHOTO 2

volatile boolean f_wdt=1;

/*
* setup function
 * Initialize the serial line (D0 & D1) at 115200.
 * Then set the pin defined to receive echo in INPUT
 * and the pin to trigger to OUTPUT.
 */

void setup()
{
   Serial.begin(9600);
   Serial.println("XPark Version 0.1 (c) Frank Herrmann 2013");
   
   // Start Status LED
   pinMode(PINSTATUSLED,OUTPUT);    // set all ports into state after sleep
   pinMode(PINRED,OUTPUT);    // set all ports into state after sleep
   pinMode(PINGREEN,OUTPUT);    // set all ports into state after sleep
   pinMode(PINYELLOW,OUTPUT);    // set all ports into state after sleep
   pinMode(ULTRAPW,OUTPUT);    // set all ports into state after sleep

   digitalWrite(PINSTATUSLED, HIGH);
   digitalWrite(PINRED, HIGH);
   digitalWrite(PINGREEN, HIGH);
   digitalWrite(PINYELLOW, HIGH);

   digitalWrite(ULTRAPW, HIGH);
   delay(1000);

   // CPU Sleep Modes
   cbi( MCUCR,SE );      // sleep enable, power down mode
   cbi( MCUCR,SM0 );     // power down mode
   sbi( MCUCR,SM1 );     // power down mode
   
   setup_watchdog(8);
   
   off();
}

/*
* loop function.
 *
 */
void loop()
{
   if (f_wdt==1) {  // wait for timed out watchdog / flag is set when a watchdog timeout occurs
      f_wdt=0;       // reset flag

      pinMode(PINSTATUSLED,OUTPUT);    // set all ports into state after sleep
      digitalWrite(PINSTATUSLED, HIGH);

      int light = analogRead(PHOTO);  // reading photoresistor
      Serial.print("light: " );
      Serial.println(light );

      if(light > 1000){
         // State on and wait some ms
         f_wdt=1;       // reset flag

         // Light, wakeup and measure ... 
         getDistance();
      } else {
        off();

        // Dark, go sleep ... 
         // set all used port to intput to save power
         digitalWrite(ULTRAPW, LOW);
         pinMode(PINSTATUSLED,INPUT);     
         pinMode(PINRED,INPUT);
         pinMode(PINGREEN,INPUT);
         pinMode(PINYELLOW,INPUT);
         // pinMode(ULTRAPW,INPUT);
   
         system_sleep(); // Zzzzz .... 
   
         // set all ports into state after sleep
         // pinMode(ULTRAPW,OUTPUT);
         pinMode(PINRED,OUTPUT);
         pinMode(PINGREEN,OUTPUT);
         pinMode(PINYELLOW,OUTPUT);
         pinMode(PINSTATUSLED,OUTPUT);

         delay(100); // wait for us sensor
      }
   }
}

// Function to turn off all LEDs

void off(){
  digitalWrite(PINRED, LOW);
  digitalWrite(PINYELLOW, LOW);
  digitalWrite(PINGREEN, LOW);
}

long getDistance(){
   digitalWrite(ULTRAPW, HIGH);
   delay(50);
   
   Ultrasonic ultrasonic(TRIGPIN,ECHOPIN); // Create and initialize the Ultrasonic object.
   int cm = ultrasonic.Ranging(CM); // Range is calculated in Centimeters.  

   Serial.print("distance: " );
   Serial.print(cm);
   Serial.println(" cm");
   
   // Switch LED's off
   off();

   if(cm >= 150){
      digitalWrite(PINGREEN, HIGH);
   }
   if(cm < 150 && cm >= 100){
      digitalWrite(PINYELLOW, HIGH);
   }
   if(cm && cm < 100){
      digitalWrite(PINRED, HIGH);
   }
   return cm;
}

//****************************************************************
// set system into the sleep state
// system wakes up when wtchdog is timed out
void system_sleep() {

   // Serial.print("Sleep ..." );
   delay(20);
   
   cbi(ADCSRA,ADEN);                    // switch Analog to Digitalconverter OFF

   set_sleep_mode(SLEEP_MODE_PWR_DOWN); // sleep mode is set here
   sleep_enable();

   sleep_mode();                        // System sleeps here

   sleep_disable();                     // System continues execution here when watchdog timed out
   sbi(ADCSRA,ADEN);                    // switch Analog to Digitalconverter ON
}

//****************************************************************
// 0=16ms, 1=32ms,2=64ms,3=128ms,4=250ms,5=500ms
// 6=1 sec,7=2 sec, 8=4 sec, 9= 8sec
void setup_watchdog(int ii) {

   byte bb;
   int ww;
   if (ii > 9 ) ii=9;
   bb=ii & 7;
   if (ii > 7) bb|= (1<<5);
      bb|= (1<<WDCE);
      ww=bb;
      Serial.println(ww);

      MCUSR &= ~(1<<WDRF);
      // start timed sequence
      WDTCSR |= (1<<WDCE) | (1<<WDE);
      // set new watchdog timeout value
      WDTCSR = bb;
      WDTCSR |= _BV(WDIE);
}

//****************************************************************
// Watchdog Interrupt Service / is executed when  watchdog timed out
ISR(WDT_vect) {
   f_wdt=1;  // set global flag
}




