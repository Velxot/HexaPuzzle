class Hexagon{
  private int x,y;          //パズル処理用の座標
  private int pos_x,pos_y;  //描画用の座標
  private float draw_x,draw_y;  //頂点のx.y座標の計算用
  private int r;
  private int element;
  private int skill;
  private boolean matched;
  private String[] image={"skill0.png"};
  
  Hexagon(int x,int y){
    this.x = x;
    this.y = y;
    r = 30;
    matched = false;
    element = (int)random(5);
    skill=-1;
    setSkill();
  }
  
  void paint(){
    if(element == 0){
      fill(255, 0, 0);
    }
    else if(element == 1){
      fill(0, 255, 0);
    }
    else if(element == 2){
      fill(0, 0, 255);
    }
    else if(element == 3){
      fill(255, 255, 0);
    }
    else if(element == 4){
      fill(255, 0, 255);
    }
    else{
      fill(255,255,255);
    }
    if(x%2==0){
      pos_x = 30+x*50;
      pos_y = 350+y*55;
    }
    else{
      pos_x = 30+x*50;
      pos_y = 320+y*55;
    }
    
    pushMatrix();
    translate(pos_x, pos_y);

    beginShape();
    for (int i = 0; i < 6; i++) {
      draw_x = r * cos(radians(360/6 * i));
      draw_y = r * sin(radians(360/6 * i));

      vertex(draw_x, draw_y);
    }
    endShape(CLOSE);

    popMatrix();
    
    if(skill != -1){
      PImage SKILL;
      SKILL=loadImage(image[skill]);
      image(SKILL,pos_x-15, pos_y-15, 30, 30);
    }
  }
  
  void setMatched(boolean matched){
    this.matched = matched;
  }
  
  boolean getMatched(){
    return this.matched;
  }
    
  int getElement(){
    return this.element;
  }
  void setElement(int element){
    this.element = element;
  }
  
  void findMatch(Hexagon[] hexagons,int x,int y){
    //左上と同色か判定
    if(x > 0 && y > 0 && this.element == hexagons[(x-1)*6+(y-x%2)].getElement() && hexagons[(x-1)*6+(y-x%2)].getMatched() != true){
      hexagons[(x-1)*6+(y-x%2)].setMatched(true);
      findMatch(hexagons,(x-1),(y-x%2));
    }
    //左下と同色か判定
    if(x > 0 && y < 5 && this.element == hexagons[(x-1)*6+(y-x%2+1)].getElement() && hexagons[(x-1)*6+(y-x%2+1)].getMatched() != true){
      hexagons[(x-1)*6+(y-x%2+1)].setMatched(true);
      findMatch(hexagons,(x-1),(y-x%2+1));
    }
    //上と同色か判定
    if(y > 0 && this.element == hexagons[x*6+(y-1)].getElement() && hexagons[x*6+(y-1)].getMatched() != true){
      hexagons[x*6+(y-1)].setMatched(true);
      findMatch(hexagons,x,y-1);
    }
    //下と同色か判定
    if(y < 5 && this.element == hexagons[x*6+(y+1)].getElement() && hexagons[x*6+(y+1)].getMatched() != true){
      hexagons[x*6+(y+1)].setMatched(true);
      findMatch(hexagons,x,y+1);
    }
    //右上と同色か判定
    if(x < 6 && y > 0 && this.element == hexagons[(x+1)*6+(y-x%2)].getElement() && hexagons[(x+1)*6+(y-x%2)].getMatched() != true){
      hexagons[(x+1)*6+(y-x%2)].setMatched(true);
      findMatch(hexagons,(x+1),(y-x%2));
    }
    //右下と同色か判定
    if(x < 6 && y < 5 && this.element == hexagons[(x+1)*6+(y-x%2+1)].getElement() && hexagons[(x+1)*6+(y-x%2+1)].getMatched() != true){
      hexagons[(x+1)*6+(y-x%2+1)].setMatched(true);
      findMatch(hexagons,(x+1),(y-x%2+1));
    }
    //例外処理(右上)
    if(x % 2 == 0 && x < 6 && this.element == hexagons[(x+1)*6+(y-x%2)].getElement() && hexagons[(x+1)*6+(y-x%2)].getMatched() != true){
      hexagons[(x+1)*6+(y-x%2)].setMatched(true);
      findMatch(hexagons,(x+1),(y-x%2)); 
    }
    //例外処理(左上)
    if(x % 2 == 0 && x > 0 && this.element == hexagons[(x-1)*6+(y-x%2)].getElement() && hexagons[(x-1)*6+(y-x%2)].getMatched() != true){
      hexagons[(x-1)*6+(y-x%2)].setMatched(true);
      findMatch(hexagons,(x-1),(y-x%2));
    }
    //例外処理(右下)
    if(x % 2 == 1 && this.element == hexagons[(x+1)*6+(y-x%2+1)].getElement() && hexagons[(x+1)*6+(y-x%2+1)].getMatched() != true){
      hexagons[(x+1)*6+(y-x%2+1)].setMatched(true);
      findMatch(hexagons,(x+1),(y-x%2+1));
    }
    //例外処理(左下)
    if(x % 2 == 1 && this.element == hexagons[(x-1)*6+(y-x%2+1)].getElement() && hexagons[(x-1)*6+(y-x%2+1)].getMatched() != true){
      hexagons[(x-1)*6+(y-x%2+1)].setMatched(true);
      findMatch(hexagons,(x-1),(y-x%2+1));
    }
    startSkill(hexagons,x,y);
  }
  
  //スキル処理
  void setSkill(){
    //スキル1：上下1マス消去
    if(player.item[0]){
      if((int)random(50) == 1){
        skill=0;
      }
    }
  }
  void startSkill(Hexagon[] hexagons,int x,int y){
    if(hexagons[x*6+y].skill == 0){
      hexagons[x*6+y].skill=-1;
      if(y > 0){
        hexagons[x*6+(y-1)].setMatched(true);
        startSkill(hexagons,x,y-1);
      }
      if(y < 5){
        hexagons[x*6+(y+1)].setMatched(true);
        startSkill(hexagons,x,y+1);
      }
    }
  }
  
  void remove(){
    if(this.matched){ 
      this.element = -1;
      this.skill = -1;
      this.matched = false;
      player.attack(enemy);
    }
  }
  void supply(){
    if(this.element==-1){
      this.element=(int)random(5);
    }
  }
  
  
  boolean selected(){
    if((mouseX-pos_x)*(mouseX-pos_x) + (mouseY-pos_y)*(mouseY-pos_y) < r*r){
      this.matched = true;
      findMatch(hexagons,this.x,this.y);
      return true;
    }
    else{
      return false;
    }
  }
}
