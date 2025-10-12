class Player extends Chara{
    int level;
    boolean levelflug;
    int[] level_info ={0,25,50,100,250,500,1000,1500,2200,3000,4000,5000,6000,7500,10000};
    int[] hp_info = {100,120,145,175,200,225,250,280,315,350,380,420,450,475,500};
    int[] ap_info = {5,6,7,8,10,12,14,16,16,20,23,26,30,35,40};
    boolean[] item ={false,false,false,false,false,false,false,false,false,false,false,false,false,false,false};
  Player(){
    super();
    experience = level_info[0];
    level = 1;
    max_hp = hp_info[0];
    hp = max_hp;
    attack_point = ap_info[0];
  }
  
  void attack(Enemy enemy){
    enemy.setHP(enemy.getHP()-this.attack_point);
  }
  
  void checkLevel(int exp){
    levelflug = false;
    this.experience += exp;
    if(experience >=level_info[level]){
      this.max_hp = hp_info[level];
      this.attack_point = ap_info[level];
      this.level++;
      levelflug = true;
      //ステータス上昇スキル適用
      if(player.item[4]){
         player.max_hp=player.max_hp*3/2;
         player.attack_point=player.attack_point*3/2;
      }
      if(player.item[6]){
         player.attack_point*=3;
      }
      if(player.item[7]){
         player.max_hp*=3;
      }
    }
  }
  
  void paint(){
    fill(255,0,0);
    rect(8,264,336,20);
    fill(0,255,0);
    rect(8,264,336*hp/max_hp,20);
    textSize(20);
    fill(0,0,0);
    text("HP:"+hp+"/"+max_hp,80,282);
    text("ATK:"+attack_point,240,282);
    text("LV:"+level,8,282);
  }
}
