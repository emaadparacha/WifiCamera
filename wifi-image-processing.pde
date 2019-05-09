//curent mode dbm-normal, not Dbm

/*
Directions:

Enter all rows starting from the top going down. Remember to enter iteration 1 before anything else. to create image, press c.
note: I don't think this program supports more than 2 iterations yet
note: Remember to change "i" in the method createPic() to the number of rows you have
note: the darker the color, the lower the DBM, the better the signal
NOTE: in the createPic() method, the input range is 20-45dBm. if it exceeds this, you have to change your scale!! Plus, you'll get a repeating error message!
*/



//row counters
Row allRows[]; //keeps track of each row
int count; //if enter is pressed, this tells draw() to call enterIndex
int countRows; //

int NAcount; // counts the number of "n/a" in the notepad file
int blackline; //responsible for black line in each pic

PFont f;
// Variable to store text currently being typed
String typing = "";
// Variable to store saved text when return is hit
String saved = "";


void setup() 
{
  allRows = new Row[100]; //note: 100 is an arbitrary number. most likely, 100 rows will never be done for a single pic.
  countRows = 0;
  count = 0;
  NAcount = 0;
  blackline = 0;
 
  size(3000,700); //arbitrary size
  f = createFont("Arial",16,true);
}

void draw()
{
  background(255);
  int indent = 25;
  // Set the font and fill for text
  textFont(f);
  fill(0);
  // Display everything
  text("Please enter index. \nHit enter to save what you typed. ", indent, 40);
  text(typing,indent,90);
  text(saved,indent,130);
  
  if (count == 1)
  {
  enterIndex(saved);
  count = 0;
  }
  //creates the picture and terminates the program after displaying NAcount  
  if (typing.equals("c"))
  {
  createPic();
  System.out.println("NAcount = " + NAcount);
  noLoop();
  }
  
  // System.out.println(allRows.length); //THIS SECTION IS A TESTER! Remember, allRows.length = 100! Therefore, it will give nullpointerexception!
  //if (typing.equals("t"))
  //{
    //for (int i = 0; i < allRows.length; i++)
    //{
      //int [] pixel = allRows[i].getPixel();
      //for (int ix = 0; ix < allRows[i].pixel.length; ix++)
      //{
        //println(pixel[ix]);
      //}
    //}
    //noLoop(); 
  //}
}

//method for creating a new row. This method is the reason why all rows must be entered in the correct order!
void enterIndex(String index)
{
  String iteration = index.substring(0,1);
  String angle = index.substring(1);
  System.out.println("Iteration: " + iteration + "\n Angle: " + angle);
  if (Integer.parseInt(iteration) == 1)
  {
  allRows[countRows] = new Row(index, angle);
  countRows++;
  }
  else
  allRows[countRows-1].avgRow(index); 
}

void createPic()
{
  size(3000,700); //change this at some point
  for (int i = 0; i < 5; i++) //5 is an arbitrary number from the first picture. It represents the number of rows there are!
  {
   //System.out.println(i);
  int [] pixel = allRows[i].getPixel(); //this array keeps track of all the pixels in each row
  int x = allRows[i].getPixel().length; //length of the array pixel
  blackline = 0; //resets blackline to 0

  for (int y = 0; y < x; y++)
  {
    noStroke();
    fill(255-pixel[y]*3,0,0); //this is just dbm*5 (logarithmic scale)
    
    //next 6 lines are for MW! formula: 10^(pixel[y]/10)    
    //pixel[y] input range: 20-45
    //note: if you exceed this range, u will lose screw up the pic!!!!!!!!!!!
    
    //double convert = pixel[y]; //converts it to double for calculation
    //double convert1 = (Math.pow(10,(convert/10)))/100; //converts back to int
    //int convert2 = (int) (Math.round(convert1));
    //if (convert2 > 255)
    //{
    //convert2= 255;
    //error();
    //}
    //System.out.println("convert1: " + convert1);
    //System.out.println("convert2: " + convert2);
    //fill(255-convert2,0,0); //this is power in MW
    


    
    System.out.println(pixel[y] + "num of lines:" + x); //outputs average dbm
    rect(40*y + 1 + blackline,100*i,40,100); //arbitrary dimensions. change when necessary. rect(x position, y position, width, height)
    fill(0,0,0);
    rect(40*y+blackline,100*i,1,100); //vertical black lines
      rect(40*y,100*i,40,1);//horizontal black lines  
    blackline++; //responsible for the black line  between each pixel
    
  }

  }
}

//error message
void error()
{
  for (int i = 0;i<50;i++)
  {
 System.out.println("ERROR: > 255 bro! (see createPic)"); 
  }
}

//adds to NAcount
void addNA()
{
  NAcount++;
}

//method that keeps track of every pressed key
void keyPressed() 
{
  // If the return key is pressed, save the String and clear it
  if (key == '\n' ) 
  {
    saved = typing;
    // A String can be cleared by setting it equal to ""
    typing = ""; 
    count = 1;
  } 
  else 
  {
    // Otherwise, concatenate the String
    // Each character typed by the user is added to the end of the String variable.
    typing = typing + key; 
  }
}

//checks if a string is an integer
boolean isInteger(String s) 
{
  try 
  { 
    Integer.parseInt(s); 
  } 
  
  catch(NumberFormatException e) 
  { 
    return false; 
  }
  // only got here if we didn't return false
  return true;
}




class Row 
{
  String lines[]; // DBM of each pixel (converted to a positive #) (position 0 is info about wifi router)
  int pixel[]; //keeps track of average dbm of each pixel (position 0 is the first average dbm)
  int numRow; //number of iterations for 1 row
  String angle; //angle of the row
  
  Row (String index, String angle)
  {
  lines = loadStrings("C:\\Users\\htt\\pic3logs\\log" + index + ".txt");
  pixel = new int[lines.length];
  pixel[0] = 30; //another random number
  numRow = 1;
  fillRow();
  }
  
  void fillRow() 
  {
    
    for (int i = 1 ; i < lines.length; i++) //it starts at 1, because the first line in notepad is info about the wifi
    {
    
      if (isInteger(lines[i].substring(24, 26)) &&  Integer.parseInt(lines[i].substring(24, 26)) < 100 &&  Integer.parseInt(lines[i].substring(24, 26)) > 20) //if the dbm is between 20 and 100 and not "n/a"
        pixel[i] = Integer.parseInt(lines[i].substring(24, 26));
    
      else //otherwise put the value of the last pixel into this one..
      {
        pixel[i] = pixel [i-1];
        addNA();
      }
    }  
  }
  
  //same as fillRow() except that there is an averaging method, too!
  void avgRow(String index) 
  {
    numRow++;
    String linesAVG[] = loadStrings("C:\\Users\\htt\\pic3logs\\log" + index + ".txt"); //dbm of each pixel for the new one + ADD INDEX!!!!!
    int pixelAVG[] = new int[linesAVG.length]; //color of each pixel for the new one
    
    for (int i = 1 ; i < linesAVG.length; i++) 
    {      
      if (isInteger(linesAVG[i].substring(24, 26)) &&  Integer.parseInt(linesAVG[i].substring(24, 26)) < 100 &&  Integer.parseInt(linesAVG[i].substring(24, 26)) > 20)
      pixelAVG[i] = Integer.parseInt(linesAVG[i].substring(24, 26));
    
      else
      {
        pixelAVG[i] = pixelAVG[i-1];
        addNA();
      }
    }  
    
    for (int i = 1 ; i < linesAVG.length; i++) 
    { 
     if(i < pixel.length) //insuring that there isnt a "1/0 error" caused by different length arrays
     {
      System.out.println("");     
      System.out.println("pixel1: " + pixel[i]);
      System.out.println("pixel2: " + pixelAVG[i]); //
      pixel[i] = (pixel[i] + pixelAVG[i])/numRow;
      System.out.println("average:" + pixel[i]);
     }
     // else //the problem with these 2 lines is that the length of pixel[i] is already fixed
     //pixel[i] = pixelAVG[i];  //instead of just deleting, get 2 in! 
    }   
  }  
  
  int [] getPixel() //for testing purposes (allows access to "pixel array" in main code)
  {
    return pixel;
  }
}
