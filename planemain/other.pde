class other{
  int score = 0;
  int life_count = 5;
  int stop = 0;
  void draw(){
    noStroke();
    fill(color(122, 144, 166));
    rect(0, 0, 500, 50);
    fill(255);
    stroke(0);
    textSize(28);
    text("score:"+score, 10, 35);
    // socre
    
    fill(color(200, 150, 100));
    for (int i = 0; i < life_count ; i ++){
      rect(470 - 25 * i, 7, 17, 35);
    }
    
    fill(255);
    // life
  }
  
  void gameOver(){
    textSize(45);
    text("GAME OVER!\nPRESS KEY TO CONTINUE!", 0, 400);
  }
  
}
