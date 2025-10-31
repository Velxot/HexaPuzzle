class Enemy extends Chara{
  int drop;
  // ダメージ表示用のフィールド
  private int lastDamage = 0;
  private long damageDisplayStartTime = 0;
  private final int DAMAGE_DISPLAY_DURATION = 1500; // 1.5秒
  private float damageDisplayOffsetX = 0;
  private float damageDisplayOffsetY = 0;
  
  // フェードアウト用のフィールドを追加
  private boolean isFadingOut = false;
  private float fadeAlpha = 255;
  private final float FADE_SPEED = 10; // フェード速度（大きいほど速い）
  
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
      drop=30;
    }
    else if(stage==6){
      max_hp = 100 + (int)random(100);
      hp = max_hp;
      attack_point = 50 + (int)random(6);
      experience = 100;
      drop=30;
    }
    else if(stage==7){
      max_hp = 200 + (int)random(100);
      hp = max_hp;
      attack_point = 50 + (int)random(6);
      experience = 150;
      drop=30;
    }
    else if(stage==8){
      max_hp = 250 + (int)random(100);
      hp = max_hp;
      attack_point = 60 + (int)random(6);
      experience = 150;
      drop=30;
    }
    else if(stage==9){
      max_hp = 500 + (int)random(100);
      hp = max_hp;
      attack_point = 75 + (int)random(6);
      experience = 200;
      drop=20;
    }
    else if(stage==10){
      max_hp = 500 + (int)random(100);
      hp = max_hp;
      attack_point = 100 + (int)random(6);
      experience = 250;
      drop=5;
    }
    else if(stage==11){
      max_hp = 600 + (int)random(100);
      hp = max_hp;
      attack_point = 150 + (int)random(6);
      experience = 250;
      drop=5;
    }
    else if(stage==12){
      max_hp = 950 + (int)random(100);
      hp = max_hp;
      attack_point = 400 + (int)random(6);
      experience = 300;
      drop=5;
    }
    else if(stage==13){
      max_hp = 800 + (int)random(100);
      hp = max_hp;
      attack_point = 400 + (int)random(6);
      experience = 350;
      drop=5;
    }
    else if(stage==14){
      max_hp = 1000 + (int)random(100);
      hp = max_hp;
      attack_point = 500 + (int)random(6);
      experience = 500;
      drop=5;
    }
    
    //スキル3-1：アイテムドロップ率を50％に固定
    if(player.item[10]){
      drop=50;
    }
    if(player.item[12]){
      attack_point /=2;
    }
  }
  
  int getExperience(){
    return this.experience;
  }
  
  void attack(Player player){
    player.setHP(player.getHP()-this.attack_point);
  }
  
  // 攻撃を受け付け、ダメージ表示を開始するメソッド
  public void receiveDamage(int damage) {
    this.setHP(this.getHP() - damage);
    this.lastDamage = damage;
    this.damageDisplayStartTime = millis();
    this.damageDisplayOffsetX = random(-50, 50); 
    this.damageDisplayOffsetY = random(-50, 50);
    
    // HPが0になったらフェードアウト開始
    if(this.hp <= 0){
      isFadingOut = true;
    }
  }
  
void paint(){
    // フェードアウト処理
    if(isFadingOut){
      fadeAlpha -= FADE_SPEED;
      if(fadeAlpha < 0){
        fadeAlpha = 0;
      }
    }
    image(BACK,0,0,360,265);
    // 敵の画像に透明度を適用してから描画
    tint(255, 255, 255, fadeAlpha);
    //image(ENEMY,60,20, 240, 240);//AIイラスト用
    image(ENEMY,0,-95, 360, 360);//人力イラスト用
    
    // tintをリセット
    noTint();
    
    fill(255, 0, 0);
    rect(80,8,200,8);
    fill(0,255,0);
    rect(80,8,200*hp/max_hp,8);
    
    // ダメージ表示
    long elapsedTime = millis() - damageDisplayStartTime;
  
    if (elapsedTime < DAMAGE_DISPLAY_DURATION) {
    
      final float ENEMY_CENTER_X = 180; 
      final float ENEMY_CENTER_Y = 200;
    
      // 1. 透明度（Alpha値）を計算
      int alpha = (int)map(elapsedTime, 0, DAMAGE_DISPLAY_DURATION, 255, 0);
      alpha = constrain(alpha, 0, 255);
      
      // 2. 表示位置を計算 (ランダムオフセットと時間経過による上昇を加える)
      float displayX = ENEMY_CENTER_X + damageDisplayOffsetX;
      float verticalOffset = map(elapsedTime, 0, DAMAGE_DISPLAY_DURATION, 0, -40); // 40ピクセル上昇
      float displayY = ENEMY_CENTER_Y + damageDisplayOffsetY + verticalOffset;
      
      // 3. 画像とテキストの描画
      
      // 画像のサイズ
      float bubbleWidth = 80;
      float bubbleHeight = 50;
      
      // 画像の中心座標を計算
      float bubbleImageX = displayX - bubbleWidth / 2;
      float bubbleImageY = displayY - bubbleHeight / 2;
      
      // PImageの透明度を設定
      tint(255, 255, 255, alpha); 
      
      // 3-1. ダメージ吹き出し画像を描画
      // HexaPuzzle.pdeのグローバル変数 DAMAGE_BUBBLE_IMAGE を使用
      image(DAMAGE, bubbleImageX, bubbleImageY, bubbleWidth, bubbleHeight);
      
      // tintをリセット (他の画像に影響しないように)
      noTint(); 
      
      // 3-2. 数値の描画
      textSize(24); // 画像サイズに合わせて調整
      String damageText = "-" + lastDamage;
      
      // テキストは画像の中心に配置
      textAlign(CENTER);
      
      fill(255, 0, 0, alpha);
      
      // テキストを描画 (displayYはテキストのベースライン。画像の中心Yに合わせるため調整)
      text(damageText, displayX, displayY + 8); // +8 は微調整用
      
      // 描画設定を元に戻す
      textAlign(LEFT);
    }
  }
  
  // フェードアウトが完了したかを確認するメソッド（オプション）
  public boolean isFadeComplete(){
    return fadeAlpha <= 0;
  }
  
  // 新しいバトル開始時にリセット
  public void resetFade(){
    isFadingOut = false;
    fadeAlpha = 255;
  }
}
