class plane{
  float x, y;
  float px = 0, py = 0;
  float speed = 1;
  int SHOOT_COUNT = 30;
  int s_count = 0;
  
  int SHOOT_COUNT_AOE = 30;
  int s_count_aoe = 0;
  
  
  
  PImage img;
  int flag = 0;
  void draw(){
    if (flag == 1){
      //fill(color(122,144, 166));
      image(img, x, y, 60, 30);
    }
    else if (flag == 2){
      //fill(255);
      //rect(x, y, 60, 30);
      image(img, x, y, 60, 30);
    }

    //fill(255);
  }
  
  plane(float _x, float _y, int _flag){
    x = _x;
    y = _y;
    flag = _flag;
    if (flag == 1) img = loadImage("plane1.png");
    else if (flag == 2) img = loadImage("plane2.png");
  }
  
  void setPxy(float _px, float _py){
    px = _px;
    py = _py;
  }
  
  void move(){
    float tx = x + px * speed;
    float ty = y + py * speed;
    if (tx < 0 || ty < 0 || tx + 60 > 500 || ty + 30 > 800) return ;
    x = tx;
    y = ty;
  }
  
  void setSpeed(float _s){
    speed = _s;
  }
  
  void setShootCount(int _cnt){
    // 
    SHOOT_COUNT = _cnt;
  }
  int IsShoot(){
    s_count += 1;
    if (s_count >= SHOOT_COUNT){
      s_count = 0;
      return 1;
    }
    return 0;
  }
  
  int IsShootAoe(){
    s_count_aoe += 1;
    if (s_count_aoe >= SHOOT_COUNT_AOE){
      s_count_aoe = 0;
      return 1;
    }
    return 0;
  }
  
  
  int IsIn(float _x, float _y){
    if (_x >= x && _x <= x + 60 && _y >= y && _y <= y + 30) return 1;
    return 0;
  }
  
}
