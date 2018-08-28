class Spider{
  float x, y, r;
  int id;
  
  Spider(int spider_id) {
    id = spider_id;
    x = random(0, width);
    y = random(0, height);
    fill(255, 255, 255);
    noStroke();
    r = random(50, 120);
    fill(0, 0, 0, 255);
    noStroke();
  }
       
  
  void checkPosition(int spider_id) {
    id = spider_id;
    if ( x <= width && x >= (width - 280) && y <= height && y >= (height - 110)) {
      x -= 200;
      y -= 200;
    }
    if (x <= 150 && y <= 150) {
      x += 200;
      y += 200;
    }
  }
  
  void display(int spider_id) {
    id = spider_id;
    
    
    noStroke();
    fill(255, 255, 255, 20);
    ellipse(x, y, 2 * r, 2 * r);
    
    image(enermy, x - 50, y - 27, 100, 54);
    
  }
}
