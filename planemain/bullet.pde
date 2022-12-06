class bullet{
  float x,y;
  float ex, ey;
  float xx, yy;
  float speed = 3;
  int flag;
  
  bullet(float _x, float _y, float _ex, float _ey, int _flag){
    x = _x;
    y = _y;
    ex = _ex;
    ey = _ey;
    flag = _flag;
    
    float tx = ex - x;
    float ty = ey - y;
    
    float xy = sqrt(tx * tx + ty * ty);
    xx = speed * tx / xy;
    yy = speed * ty / xy;
    
  }
  
  void setSpeed(float _s){
    speed = _s;
  }
  
  void draw(){
    if (flag == 1){
      fill(255);
    }
    else if (flag == 2){
      fill(color(255, 0, 0));
    }
    ellipse(x, y, 10, 10);
    fill(255);
  }
  
  void move(){
    x += xx;
    y += yy;
  }
  
}
