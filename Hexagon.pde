class Hexagon{
  private int x,y;          //パズル処理用の座標
  private int pos_x,pos_y;  //描画用の座標
  private float draw_x,draw_y;  //頂点のx.y座標の計算用
  private int r;
  private int element;
  private int skill;
  private boolean matched;
  private String[] image={"Images/skill0.png","Images/skill1.png","Images/skill2.png","Images/skill3.png","Images/skill4.png","Images/skill5.png"};
  private boolean isDisappearing = false;
  private float disappearProgress = 0.0;  // 0.0 ~ 1.0
  private final float DISAPPEAR_SPEED = 0.1;  // 消滅速度
  
  
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
    if(isDisappearing){
      disappearProgress += DISAPPEAR_SPEED;
      if(disappearProgress >= 1.0){
        disappearProgress = 1.0;
      }
    }
    
    color fillColor;
    if(element == 0){
      fillColor = color(255, 70, 136);
    }
    else if(element == 1){
      fillColor = color(70, 200, 136);
    }
    else if(element == 2){
      fillColor = color(70, 136, 255);
    }
    else if(element == 3){
      fillColor = color(230, 230, 70);
    }
    else if(element == 4){
      fillColor = color(230, 70, 230);
    }
    else{
      fillColor = color(255,255,255);
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

    if(isDisappearing){
      float alpha = 255 * (1.0 - disappearProgress);
      float scale = 1.0 - disappearProgress * 0.5; // 50%まで縮小
    
      // 透明度を適用（現在の色に適用）
      fill(red(fillColor), green(fillColor), blue(fillColor), alpha);
    
      scale(scale);
    }
    else{
      fill(fillColor);
    }

    beginShape();
    for (int i = 0; i < 6; i++) {
      draw_x = r * cos(radians(360/6 * i));
      draw_y = r * sin(radians(360/6 * i));

      vertex(draw_x, draw_y);
    }
    endShape(CLOSE);

    popMatrix();
    
    if(skill != -1 && !isDisappearing){
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
  
  //スキルマスをランダムなマスにセット
  void setSkill(){
    //スキル1-1：上下1マス消去
    if(player.item[0]){
      if((int)random(50) == 1){
        skill=0;
      }
    }
    //スキル1-2：上下以外の隣り合うマスを消去
    if(player.item[1]){
      if((int)random(50) == 5){
        skill=1;
      }
    }
    //スキル1-3：体力を10%回復
    if(player.item[2] || player.item[9] || player.item[14] ){
      if((int)random(50) == 1){
        skill=2;
      }
    }
    //スキル1-4：そのマスの攻撃力5倍
    if(player.item[3]){
      if((int)random(50) == 1){
        skill=3;
      }
    }
    //スキル2-1：隣り合う6マスを消去
    if(player.item[5]){
      if((int)random(50) == 1){
        skill=4;
      }
    }
    //スキル3-5：全消し
    if(player.item[13]){
      if((int)random(100) == 1){
        skill=5;
      }
    }
  }
  //スキル処理
  void startSkill(Hexagon[] hexagons,int x,int y){
    //スキル1-1：上下1マスを消去
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
    //スキル1-2：上下以外の隣り合うマスを消去
    if(hexagons[x*6+y].skill == 1){
      hexagons[x*6+y].skill=-1;
      if(x > 0 && y > 0){
        hexagons[(x-1)*6+(y-x%2)].setMatched(true);
        startSkill(hexagons,x-1,y-x%2);
      }
      if(x > 0 && y < 5){
        hexagons[(x-1)*6+(y-x%2+1)].setMatched(true);
        startSkill(hexagons,x-1,y-x%2+1);
      }
      if(x < 6 && y > 0){
        hexagons[(x+1)*6+(y-x%2)].setMatched(true);
        startSkill(hexagons,x+1,y-x%2);
      }
      if(x < 6 && y < 5){
        hexagons[(x+1)*6+(y-x%2+1)].setMatched(true);
        startSkill(hexagons,x+1,y-x%2+1);
      }
      if(x % 2 == 0 && x < 6){
        hexagons[(x+1)*6+(y-x%2)].setMatched(true);
        startSkill(hexagons,x+1,y-x%2);
      }
      if(x % 2 == 0 && x > 0){
        hexagons[(x-1)*6+(y-x%2)].setMatched(true);
        startSkill(hexagons,x-1,y-x%2);
      }
      if(x % 2 == 1){
        hexagons[(x+1)*6+(y-x%2+1)].setMatched(true);
        startSkill(hexagons,(x+1),(y-x%2+1));
      }
      if(x % 2 == 1){
        hexagons[(x-1)*6+(y-x%2+1)].setMatched(true);
        startSkill(hexagons,(x-1),(y-x%2+1));
      }
    }
    //スキル1-3：体力を10%回復 & スキル2-5：体力を20%回復
    if(hexagons[x*6+y].skill == 2){
      hexagons[x*6+y].skill = -1;
      if(player.item[14]){
        player.setHP(player.getHP()+player.max_hp/4);
      }
      else if(player.item[11]){
        player.setHP(player.getHP()+player.max_hp/4);
      }
      else if(player.item[9]){
        player.setHP(player.getHP()+player.max_hp/5);
      }
      else{
        player.setHP(player.getHP()+player.max_hp/10);
      }
    }
    //スキル1-4：そのマスの攻撃力5倍
    if(hexagons[x*6+y].skill == 3){
      hexagons[x*6+y].skill = -1;
      for(int i=0;i<5;i++){
        player.attack();
      }
    }
    
    //スキル2-1：隣り合う6マスを消去
    if(hexagons[x*6+y].skill == 4){
      hexagons[x*6+y].skill=-1;
      if(y > 0){
        hexagons[x*6+(y-1)].setMatched(true);
        startSkill(hexagons,x,y-1);
      }
      if(y < 5){
        hexagons[x*6+(y+1)].setMatched(true);
        startSkill(hexagons,x,y+1);
      }
      if(x > 0 && y > 0){
        hexagons[(x-1)*6+(y-x%2)].setMatched(true);
        startSkill(hexagons,x-1,y-x%2);
      }
      if(x > 0 && y < 5){
        hexagons[(x-1)*6+(y-x%2+1)].setMatched(true);
        startSkill(hexagons,x-1,y-x%2+1);
      }
      if(x < 6 && y > 0){
        hexagons[(x+1)*6+(y-x%2)].setMatched(true);
        startSkill(hexagons,x+1,y-x%2);
      }
      if(x < 6 && y < 5){
        hexagons[(x+1)*6+(y-x%2+1)].setMatched(true);
        startSkill(hexagons,x+1,y-x%2+1);
      }
      if(x % 2 == 0 && x < 6){
        hexagons[(x+1)*6+(y-x%2)].setMatched(true);
        startSkill(hexagons,x+1,y-x%2);
      }
      if(x % 2 == 0 && x > 0){
        hexagons[(x-1)*6+(y-x%2)].setMatched(true);
        startSkill(hexagons,x-1,y-x%2);
      }
      if(x % 2 == 1){
        hexagons[(x+1)*6+(y-x%2+1)].setMatched(true);
        startSkill(hexagons,(x+1),(y-x%2+1));
      }
      if(x % 2 == 1){
        hexagons[(x-1)*6+(y-x%2+1)].setMatched(true);
        startSkill(hexagons,(x-1),(y-x%2+1));
      }
    }
    //スキル3-4：全消し
    if(hexagons[x*6+y].skill == 5){
      for(int i=0;i<42;i++){
        hexagons[i].setMatched(true);
      }
    }
  }
  
  void remove(){
    if(this.matched){ 
      isDisappearing = true;  // アニメーション開始
      this.element = -1;
      this.skill = -1;
      this.matched = false;
      //スキル2-4：10％で5倍ダメージ
      if(player.item[8]){
        if((int)random(10) == 1){
          for(int i=0;i<5;i++){
            player.attack();
          }
        }
        else{
          player.attack();
        }
      }
      else{
        player.attack();
      }
    }
  }


  void supply(){
    if(this.element==-1){
      if(disappearProgress >= 1.0){  // アニメーション完了後に補充
        this.element=(int)random(5);
        this.skill = -1;
        this.matched = false;
        this.isDisappearing = false;
        this.disappearProgress = 0.0;
        setSkill();
      }
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
