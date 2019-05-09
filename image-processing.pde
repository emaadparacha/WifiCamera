Row allRows[];
int count;
int countRows;
PFont f;
// Variable to store text currently being typed
String typing = "";

// Variable to store saved text when return is hit
String saved = "";
void setup() 
{
  allRows = new Row[100];
  countRows = 0;
  count = 0;
  size(300,200);
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
  if (typing.equals("c"))
  {

  createPic();
      noLoop();
  }

}

void enterIndex(String index)
{
  String iteration = index.substring(0,1);
  String angle = index.substring(1);
  System.out.println("Iteration: " + iteration + "\n Angle: " + angle + "!");
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
  size(200,200); //change this at some point
  for (int i = 0; i < 1; i++) //change 1
  {
   //System.out.println(i);
  int [] pixel = allRows[i].getPixel(); //edit lines.length
    int x = allRows[i].getPixel().length; //edit lines.length
  for (int y = 0; y < x; y++)
  {
    noStroke();
    fill(allRows[i].getPixel()[y]*5,0,0);
    System.out.println(pixel[y] + "num of lines:" + x);
    rect(5*y + 1,0,5,30);
  }
  }
}



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
  String lines[]; // DBM of each pixel
  int pixel[]; //color of each pixel
  int numRow;
  String angle;
  
  Row (String index, String angle)
  {
  lines = loadStrings("C:\\Users\\CommunistPanda\\log" + index + ".txt"); //add INDEX!!!!!!!!!
  pixel = new int[lines.length];
  pixel[0] = 50;
  numRow = 1;
  fillRow();
  }
  
  void fillRow() 
  {
    
    for (int i = 1 ; i < lines.length; i++) 
    {
    
      if (isInteger(lines[i].substring(25, 27)) &&  Integer.parseInt(lines[i].substring(25, 27)) < 90 &&  Integer.parseInt(lines[i].substring(25, 27)) > 25)
      pixel[i] = Integer.parseInt(lines[i].substring(25, 27));
    
      else
      pixel[i] = pixel [i-1];
    }  
  }
  
  void avgRow(String index) 
  {
    numRow++;
    String linesAVG[] = loadStrings("C:\\Users\\CommunistPanda\\log" + index + ".txt"); //dbm of each pixel for the new one + ADD INDEX!!!!!
    int pixelAVG[] = new int[linesAVG.length]; //color of each pixel for the new one
    
    for (int i = 1 ; i < linesAVG.length; i++) 
    {      
      if (isInteger(linesAVG[i].substring(25, 27)) &&  Integer.parseInt(linesAVG[i].substring(25, 27)) < 90 &&  Integer.parseInt(linesAVG[i].substring(25, 27)) > 25)
      pixelAVG[i] = Integer.parseInt(linesAVG[i].substring(25, 27));
    
      else
      pixelAVG[i] = pixelAVG[i-1];
    }  
    
    for (int i = 1 ; i < linesAVG.length; i++) 
    { 
     if(pixel[i] != 0) //insuring that there isnt a "1/0 error" caused by different length arrays
     {     
      System.out.println("pixeli" + pixel[i]);
      System.out.println("pixelavg" + pixelAVG[i]);
      pixel[i] = (pixel[i] + pixelAVG[i])/numRow;
     }
     else
      pixel[i] = pixelAVG[i];  
    }   
  }  
  
  int [] getPixel() //for testing purposes (allows access to "pixel array" in main code)
  {
    return pixel;
  }

}


