PImage bee, grass, gameOver, startScreen, enermy, house, gamewin, output, s;
int num = 10;
int gameStart = 0;
int gameCase = 1;

color red = color(255, 0, 0);
color orange = color(210, 105, 30);
color yellow = color(255, 255, 0);
color green = color(124, 252, 0);

int passedTime = 0;

Spider[] spider = new Spider[num];


void setup() {
  size(1200, 680);
  smooth();
  noStroke();
  frameRate(60);
  
  grass = loadImage("background.jpg");
  gameOver = loadImage("gameover.jpg");
  startScreen = loadImage("startscreen.jpg");
  gamewin = loadImage("win.jpg");  

  grass.loadPixels();
  loadPixels();
  
  bee = loadImage("bee.gif");
  enermy = loadImage("spider.gif");
  house = loadImage("home.png");
  
  for(int i = 0; i < num; i++) {
    spider[i] = new Spider(i);
  }
  

  
}

void draw() {  
  if (gameStart == 0) {
    background(startScreen);
  }
  else if (gameCase == 0) {
    gameOver();
  }
  else {
    background(grass);        
    passedTime = 0;
    image(house, 25, 25, 50, 50);
    
   for(int i = 0; i < num; i++) {
      spider[i].display(i);
      spider[i].checkPosition(i);
    }  
    
    output = get();
  
 
 for (int x = 0; x < output.width; x++) {
    for (int y = 0; y < output.height; y++ ) {
      // Calculate the 1D location from a 2D grid
      int loc = x + y * output.width;
      // Get the R,G,B values from image
      float r,g,b;
      r = red (output.pixels[loc]);
      g = green (output.pixels[loc]);
      b = blue (output.pixels[loc]);
      // Calculate an amount to change brightness based on proximity to the mouse
      float maxdist = 80;//dist(0,0,width,height);
      float d = dist(x, y, mouseX, mouseY);
      float adjustbrightness = 255*(maxdist-d)/maxdist;
      r += adjustbrightness;
      g += adjustbrightness;
      b += adjustbrightness;
      // Constrain RGB to make sure they are within 0-255 color range
      r = constrain(r, 0, 255);
      g = constrain(g, 0, 255);
      b = constrain(b, 0, 255);
      // Make a new color and set pixel in the window
      color c = color(r, g, b);
      //color c = color(r);
      pixels[y*width + x] = c;
    }
 }
  
  updatePixels();   
  
  
  image(bee, mouseX - 40, mouseY - 50);
    
    for(int i = 0; i < num; i++) {
      float distance = (mouseX - spider[i].x) * (mouseX - spider[i].x) + (mouseY - spider[i].y) * (mouseY - spider[i].y) - spider[i].r * spider[i].r;
      if(distance < 0) {
        gameCase = 0;
      } 
    }
    
    timer();
    
//   warning();
//   println("tick");
  }
}

void mouseClicked(){
  if (gameStart == 0 && mouseX >= (width - 280) && mouseY >= (height - 110) && mouseX <= width && mouseY <= height) {
    gameStart = 1;
//    timer();
  }
  if (gameCase == 1 && (mouseX <= 100) && (mouseY <= 100 ) && (mouseX > 0) && (mouseY > 0)) {
    gameWin();
  } 
}

void gameOver() {
  stop();
  background(gameOver);
  noLoop();
}

void gameWin() {
  stop();
  background(gamewin);
  noLoop();
}

void warning() {  
  ellipse(60, height - 60, 50, 50);  
  for(int i = 0; i < num; i++) {
    float distance = (mouseX - spider[i].x) * (mouseX - spider[i].x) + (mouseY - spider[i].y) * (mouseY - spider[i].y) - spider[i].r * spider[i].r;
    if (distance < 100 && distance >= 0) {
      fill(red);
    }
    else {
      if(distance < 180 && distance >= 100) { 
        fill(orange);
      }
      else {
        if(distance < 250 && distance >= 180) {
          fill(yellow);
        }
        else {
          if (distance >= 250) {  
            fill(green);
          }
        }
      }
    }
  }
  ellipse(60, height - 60, 50, 50);
}

void timer() {
  
  start();
    passedTime = (millis() / 1000);
    int time = 60 - passedTime;
//    passedTime = second();
    if(time == 0) {
      gameCase = 0;
    }
    
    textSize(50);
    text(time, 60, height - 60);
    fill(255, 255, 255, 255);
}
     
  
