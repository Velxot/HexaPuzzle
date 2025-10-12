class Enemy extends Chara{
  int drop;
  Enemy(){
    super();
    if(stage==0){
      max_hp = 50 + (int)random(50);
      hp = max_hp;
      attack_point = 2 + (int)random(6);
      experience = 10;
      drop=33;
    }
    else if(stage==1){
      max_hp = 75 + (int)random(100);
      hp = max_hp;
      attack_point = 5 + (int)random(6);
      experience = 12;
      drop=33;
    }
    else if(stage==2){
      max_hp = 100 + (int)random(100);
      hp = max_hp;
      attack_point = 10 + (int)random(6);
      experience = 15;
      drop=20;
    }
    else if(stage==3){
      max_hp = 100 + (int)random(100);
      hp = max_hp;
      attack_point = 15 + (int)random(6);
      experience = 20;
      drop=10;
    }
    else if(stage==4){
      max_hp = 125 + (int)random(100);
      hp = max_hp;
      attack_point = 15 + (int)random(6);
      experience = 30;
      drop=50;
    }
    else if(stage==5){
      max_hp = 150 + (int)random(100);
      hp = max_hp;
      attack_point = 20 + (int)random(6);
      experience = 50;
      drop=100;
    }
    else if(stage==6){
      max_hp = 100 + (int)random(100);
      hp = max_hp;
      attack_point = 50 + (int)random(6);
      experience = 100;
      drop=100;
    }
    else if(stage==7){
      max_hp = 200 + (int)random(100);
      hp = max_hp;
      attack_point = 50 + (int)random(6);
      experience = 150;
      drop=100;
    }
    else if(stage==8){
      max_hp = 250 + (int)random(100);
      hp = max_hp;
      attack_point = 60 + (int)random(6);
      experience = 150;
      drop=100;
    }
    else if(stage==9){
      max_hp = 500 + (int)random(100);
      hp = max_hp;
      attack_point = 30 + (int)random(6);
      experience = 500;
      drop=100;
    }
    else if(stage==10){
      max_hp = 450 + (int)random(100);
      hp = max_hp;
      attack_point = 60 + (int)random(6);
      experience = 450;
      drop=5;
    }
    else if(stage==11){
      max_hp = 500 + (int)random(100);
      hp = max_hp;
      attack_point = 75 + (int)random(6);
      experience = 500;
      drop=5;
    }
    else if(stage==12){
      max_hp = 750 + (int)random(100);
      hp = max_hp;
      attack_point = 70 + (int)random(6);
      experience = 600;
      drop=5;
    }
    else if(stage==13){
      max_hp = 800 + (int)random(100);
      hp = max_hp;
      attack_point = 100 + (int)random(6);
      experience = 750;
      drop=5;
    }
    else if(stage==14){
      max_hp = 1000 + (int)random(100);
      hp = max_hp;
      attack_point = 90 + (int)random(6);
      experience = 800;
      drop=5;
    }
  }
  
  int getExperience(){
    return this.experience;
  }
  
  void attack(Player player){
    player.setHP(player.getHP()-this.attack_point);
  }
  
  void paint(){
    image(BACK,0,0,360,265);
    image(ENEMY,60,20, 240, 240);
    fill(255, 0, 0);
    rect(80,8,200,8);
    fill(0,255,0);
    rect(80,8,200*hp/max_hp,8);
  }
}
