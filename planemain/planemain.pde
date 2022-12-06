plane h;
bullet b[] = new bullet[1010];
plane a[] = new plane[1010];
other o = new other();

int BULLET_MAX = 1000;
int b_last = 0;

int ARMY_MAX = 1000;
int a_last = 0;

int CREATE_COUNT = 50;
int c_count;

void AOE(int n){
  float angle_e = 360.0 / n;
  float angle = 0;
  int x = 250, y = 300;
  int r = 500;
  for (int i = 0 ; i < n ;i ++){
    float tx = cos(angle) * r + x;
    float ty = sin(angle) * r + y;
    shootBullet(x, y, tx, ty, 1, 3);
    angle += angle_e;
    angle += random(100);
  }
}

void setup(){
  size(500, 800);
  background(220);
  h  = new plane(200, 700, 1);
  h.setSpeed(2);
  h.setShootCount(10);
  AOE(55);
}

void shootBullet(float _x, float _y, float _ex, float _ey, int _flag, float _s){
  for (int i = 0 ; i < BULLET_MAX; i ++){
    //println(i);
    if (b[i] == null){
      b[i] = new bullet(_x, _y, _ex, _ey, _flag);
      if (i > b_last) b_last = i;;
      b[i].setSpeed(_s);
      break;
    }
  }
}



void drawBullet(){
  for (int i = 0 ; i <= b_last; i ++){
    if (b[i] == null) continue;
    if (o.stop == 0) b[i].move();
    if (b[i].x <= 0 || b[i].y <= 0 || b[i].x >= 500 || b[i].y >= 800){
      b[i] = null;
      continue;
    }
    b[i].draw();
  }
}

void createArmy(){
  c_count += 1;
  //println("ct", c_count);
  if (c_count < CREATE_COUNT) return ;
  c_count = 0;
  
  for (int i = 0 ;i < ARMY_MAX; i ++){
    if(a[i] == null){
      a[i] = new plane(random(400), 0, 2);
      a[i].setShootCount(50);
      a[i].setPxy(0, 1);
      if (i > a_last) a_last = i;
      break;
    }
  }
}

void drawArmy(){
  for (int i = 0 ; i <= a_last ; i ++){
    if (a[i] == null) continue;
    if (o.stop == 0 && a[i].IsShoot() == 1 ){
      shootBullet(a[i].x + 30, a[i].y + 50, h.x + 30, h.y + 20, 2, 2);
    }
    if (o.stop == 0) a[i].move();
    if (a[i].x < 0 || a[i].x > 500 || a[i].y < 0 || a[i].y > 800){
      a[i] = null;
      continue;
    }
    a[i].draw();
  }
}

void checkCrash(){
  for (int i = 0 ; i <= b_last; i ++){
    if (b[i] == null) continue;
    if (b[i].flag == 1){
      // hero's bullet
      for (int j = 0 ; j <= a_last; j ++){
        if (a[j] == null) continue;
        if (a[j].IsIn(b[i].x, b[i].y) == 1){
          a[j] = null;
          b[i] = null;
          o.score += 100;
          break;
        }
      } 
    }
    else if (b[i].flag == 2){
      if (h.IsIn(b[i].x, b[i].y) == 1){
        b[i] = null;
        o.life_count -= 1;
        if (o.life_count == 0){
          // game over
          o.stop = 1;
          h.setPxy(0, 0);
        }
      }
    }
  }
}


void draw(){
  background(220);
  h.move();
  
  if (o.stop == 0 && h.IsShoot()==1){
      shootBullet(h.x + 30, h.y, h.x + 30, -100, 1, 4);
      shootBullet(h.x + 30, h.y, h.x + 30 - 100, -100, 1, 4);
      shootBullet(h.x + 30, h.y, h.x + 30 + 100, -100, 1, 4);
  }
  if (o.stop == 0 && h.IsShootAoe() == 1){
    //AOE(78);
   }
  drawBullet();
  h.draw();
  if (o.stop == 0) createArmy();
  drawArmy();
  o.draw();
  checkCrash();
  if (o.stop == 1) o.gameOver();
}

void keyPressed(){
  if (keyCode == UP){
    if (o.stop == 0) h.setPxy(0, -1);
  }
  else if (keyCode == DOWN){
   if (o.stop == 0) h.setPxy(0, 1);
  }
  else if (keyCode == LEFT){
   if (o.stop == 0) h.setPxy(-1, 0);
  }
  else if (keyCode == RIGHT){
   if (o.stop == 0) h.setPxy(1, 0);
  }
  else{
    if (o.stop == 1){
      // gameover to retry
      h.x = 200;
      h.y = 700;
      for (int i = 0 ; i < a_last; i ++) a[i] = null;
      for (int i = 0 ; i < b_last; i ++) b[i] = null;
      a_last = b_last = 0;
      o.score = 0;
      o.life_count = 5;
      o.stop = 0;
    }
  }
}

void keyReleased(){
  h.setPxy(0, 0);
}
