class Player extends Chara{
    int level;
    boolean levelflug;
    int[] level_info ={0,25,50,100,250,500,1000,1500,2200,3000,4000,5000,6000,7500,10000,15000,20000,25000,30000,50000,80000,100000};
    int[] hp_info = {100,120,145,175,200,225,250,280,315,350,380,420,450,475,500,530,570,600,650,700,800,900,1000,1200,1400};
    int[] ap_info = {5,6,7,8,10,12,14,16,16,20,23,26,30,35,40,45,50,57,63,70,80,90,100,110,120,135,150,200};
    boolean[] item ={false,false,false,false,false,false,false,false,false,false,false,false,false,false,false};
  
    public int currentTurnDamage = 0;
  
  Player(){
    super();
    experience = level_info[0];
    level = 1;
    max_hp = hp_info[0];
    hp = max_hp;
    attack_point = ap_info[0];
  }
  
  void attack(){
    this.currentTurnDamage += this.attack_point;
  }
  
  void applyDamage(Enemy enemy, SoundFile attackSound) {
    if (this.currentTurnDamage > 0) {
        // 敵に合計ダメージを適用し、ダメージ表示をトリガー
        enemy.receiveDamage(this.currentTurnDamage);
        
        // 音声再生 (HexaPuzzle.pdeから移動させます)
        if (attackSound != null) {
            attackSound.play();
        }
    }
    // ダメージをリセット
    this.currentTurnDamage = 0;
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
      //スキル1-5：体力1.5倍、攻撃力1.5倍
      if(player.item[4]){
         player.max_hp=player.max_hp*3/2;
         player.attack_point=player.attack_point*3/2;
      }
      //スキル2-2：攻撃力3倍
      if(player.item[6]){
         player.attack_point*=3;
      }
      //スキル2-3：体力3倍
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
