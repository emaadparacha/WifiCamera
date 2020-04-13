//This code connects an nRF24L01 to an Arduino board and prints the strength of wifi signals

//How it works: loops through each channel 50 times and adds to "values[]" and then it prints values[] with a number 1-50. 50 is strongest, 1 is weakest
//note: only channels 30-60 are used in order to maximize speed
//testCarrier vs. testRPD. RPD is better!
//note: since notepad formatting is a dick, cut and paste this into word, ctrl+f "^p", replace all!, paste into notepad
/**
 * Channel scanner
 *
 * Example to detect interference on the various channels available.
 * This is a good diagnostic tool to check whether you're picking a
 * good channel for your application.
 *
 */

#include <SPI.h>
#include "nRF24L01.h"
#include "RF24.h"
#include "printf.h"

//
// Hardware configuration
//

// Set up nRF24L01 radio on SPI bus plus pins 9 & 10

RF24 radio(9,10);

//
// Channel info
//

const uint8_t num_channels = 45;
uint8_t values[num_channels];

//
// Setup
//

void setup(void)
{
  //
  // Print preamble
  //

  Serial.begin(57600);
  printf_begin();
  printf("\n\rRF24/examples/scanner/\n\r");

  //
  // Setup and configure rf radio
  //

  radio.begin();
  radio.setAutoAck(false);

  // Get into standby mode
  radio.startListening();
  radio.stopListening();

}

//
// Loop
//

const int num_reps = 75;
int row = 1;
int total = 0;

void loop(void)
{
  // Clear measurement values
  memset(values,0,sizeof(values));
  total = 0;
  // Scan all channels num_reps times
  int rep_counter = num_reps;
  while (rep_counter--)
  {
    int i = num_channels;
    for (int i = num_channels; i >= 30; i--)
    {
      // Select this channel
      radio.setChannel(i);

      radio.startListening();
      delayMicroseconds(60);
      radio.stopListening();

      // Did we get a carrier?
      if ( radio.testRPD() )
        ++values[i];
    }
  }

  // Print out channel measurements,
 int i = 0;
  while ( i < num_channels ) //first while loop calculates total
  {
   //if (values[i] == 1) //gets rid of random noise
    //values[i] = 0;
    total = total + values[i];
    ++i;
  }
  Serial.print(total);
  Serial.print("   ");

  i = 0;
  while ( i < num_channels) // 2nd while loop outputs values[i]
  {
    Serial.print(values[i]);
    ++i;
  }
  Serial.print("    ");
  Serial.print(row);

  printf("\n\r");
  row++;
}
