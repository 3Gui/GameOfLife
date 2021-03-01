import de.bezier.guido.*;
//Declare and initialize constants NUM_ROWS and NUM_COLS = 20
public final static int NUM_ROWS = 80;
public final static int NUM_COLS = 100;
private Life[][] buttons; //2d array of Life buttons each representing one cell
private boolean[][] buffer; //2d array of booleans to store state of buttons array
private boolean running = true; //used to start and stop program

public void setup () {
  //noStroke();
  stroke(255);
  size(1000, 800);
  frameRate(10);
  // make the manager
  Interactive.make( this );
  buttons = new Life[NUM_ROWS][NUM_COLS];
  //your code to initialize buttons goes here
  for (int r = 0; r < NUM_ROWS; r++) {
    for (int c = 0; c < NUM_COLS; c++) {
      buttons[r][c] = new Life(r, c);
    }
  }
  buffer = new boolean[NUM_ROWS][NUM_COLS];
  //your code to initialize buffer goes here
  for (int r = 0; r < NUM_ROWS; r++) {
    for (int c = 0; c < NUM_COLS; c++) {
      buffer[r][c] = buttons[r][c].getLife();
    }
  }
}

public void draw () {
  background( 0 );
  if (running == false) //pause the program
    return;
  copyFromButtonsToBuffer();

  //use nested loops to draw the buttons here
  for (int r = 0; r < NUM_ROWS; r++) {
    for (int c = 0; c < NUM_COLS; c++) {
      if (countNeighbors(r, c) == 3) { 
        buffer[r][c] = true;
      } else if (countNeighbors(r, c) == 2 && buttons[r][c].getLife()) { 
        buffer[r][c] = true;
      } else {
        buffer[r][c] = false;
      }
      buttons[r][c].draw();
    }
  }
  copyFromBufferToButtons();
}

public void keyPressed() {
  if(key == 'a'){
    running = !running;
  }
  if(key == 's'){
    frameRate(3);
  }
  if(key == 'd'){
    frameRate(8);
  }
  if(key == 'f'){
    frameRate(15);
  }
  if(key == 'g'){
    frameRate(30);
  }
}

public void copyFromBufferToButtons() {
  for (int r = 0; r < NUM_ROWS; r++) {
    for (int c = 0; c < NUM_COLS; c++) {
      buttons[r][c].setLife(buffer[r][c]);
    }
  }
}

public void copyFromButtonsToBuffer() {
  for (int r = 0; r < NUM_ROWS; r++) {
    for (int c = 0; c < NUM_COLS; c++) {
      buffer[r][c] = buttons[r][c].getLife();
    }
  }
}

public boolean isValid(int r, int c) {
  if (r < NUM_ROWS && c < NUM_COLS && c >= 0 && r >= 0) {
    return true;
  }
  return false;
}

public int countNeighbors(int row, int col) {
  int neighbors = 0;


  for (int r =  row-1; r < row+2; r++) {
    for (int c =  col-1; c< col+2; c++) {

      if (isValid(r, c) && buttons[r][c].getLife()  && !(r ==  row && c==col)) {
        neighbors++;
      }
    }
  }

  return neighbors;
}

public class Life {
  private int myRow, myCol;
  private float x, y, width, height;
  private boolean alive;
  private int randColor = color((int)(Math.random()*155) +100,(int)(Math.random()*155) +100,(int)(Math.random()*155) +100);
  public Life (int row, int col) {
    width = 1000/NUM_COLS;
    height = 800/NUM_ROWS;
    myRow = row;
    myCol = col; 
    x = myCol*width;
    y = myRow*height;
    alive = Math.random() < .5; // 50/50 chance cell will be alive
    Interactive.add( this ); // register it with the manager
  }

  // called by manager
  public void mousePressed () {
    alive = !alive; //turn cell on and off with mouse press
  }
  public void draw () {    
    if (alive != true){
      noStroke();
      fill(0);
    }
    else {
     stroke(0);
    fill(204, 255, 255);
    }
    rect(x, y, width, height);
    
  }
  public boolean getLife() {
    //replace the code one line below with your code
    return alive;
  }
  public void setLife(boolean living) {
    alive = living;
  }
}
