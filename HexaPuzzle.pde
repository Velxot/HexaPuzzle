import processing.sound.*;

Hexagon[] hexagons;
Enemy enemy;
Player player;
PImage ENEMY;
PImage BACK;
PImage RESULT;
PImage BUTTON;
PImage REDO;
PImage YOUWIN;
PImage YOULOSE;
PImage GAMECLEAR;
PImage DAMAGE;
SoundFile tapSound;
SoundFile attackSound;
SoundFile clearSound;
int situation;
boolean matched;
boolean enemyturn;
int stage;
int reachedstage;
int max_stage=14;
boolean exp_flug;
boolean drop_flug;
int drop_num;
boolean stageselect = false;  //ステージセレクト画面を表示するか
boolean reset = false;  //リセット確認画面を表示するか
boolean clear = false;  //クリア画面を表示するか
String[] stagename = {"草原","砂漠","天界"};
int damageDisplayValue = 0;
long damageDisplayStartTime = 0;
final int DISPLAY_DURATION = 1500; // 1500ミリ秒 (1.5秒) 表示
boolean gameoverSoundPlayed = false;

void setup(){
  size(360,640);
  background(200);
  PFont font = createFont("Meiryo", 50);
  textFont(font);
  stage=0;
  reachedstage=0;
  setEnemy(stage);
  hexagons = new Hexagon[42];
  player = new Player();
  enemy = new Enemy();
  for(int i = 0; i < hexagons.length; i++){
    hexagons[i] = new Hexagon(i/6,i%6);
  }
  exp_flug = true;
  tapSound = new SoundFile(this,"決定ボタンを押す2.mp3");
  attackSound = new SoundFile(this, "小パンチ.mp3");
  clearSound = new SoundFile(this, "決定ボタンを押す8.mp3");
  DAMAGE = loadImage("Images/damage_UI.png");
}

void startBattle(){
  size(360,640);
  background(200);
  setEnemy(stage);
  hexagons = new Hexagon[42];
  enemy = new Enemy();
  for(int i = 0; i < hexagons.length; i++){
    hexagons[i] = new Hexagon(i/6,i%6);
  }
  exp_flug=true;
  drop_flug=true;
  drop_num =(int)random(100);
  
  player.hp=player.max_hp;
  
  gameoverSoundPlayed = false;
}

void draw(){
  enemy.paint();
  player.paint();
  //パズルの描画
  for(int i=0;i<hexagons.length;i++){
    hexagons[i].paint();
  }
  //対戦終了処理
  if(player.getHP() == 0 || enemy.getHP() == 0){
    if(!gameoverSoundPlayed){
      if(enemy.getHP() == 0){
        clearSound.play();
        gameoverSoundPlayed = true;
      }
    }
    gameover();
  }
  //パズル消去
  if(situation==0){
    for(int i = 0; i < hexagons.length; i++){
       hexagons[i].remove();
    }
    situation=1;
    delay(200);
  }
  //パズル供給
  else if(situation == 1){
      boolean supplied = true;
      for(int i = 0; i < hexagons.length; i++){
        hexagons[i].supply();
        if(hexagons[i].getElement() == -1){
          supplied = false;
        }
      }
      if(supplied){
        situation = 2;
        delay(200);
        
        player.applyDamage(enemy, attackSound);
        
        if(enemy.getHP() <= 0){
          situation = 3;
        }
      }
    }
  if(enemyturn){
    enemy.attack(player);
    enemyturn = false;
  }
  
  if(stageselect){
    RESULT = loadImage("Images/result.png");
    BUTTON = loadImage("Images/button.png");
    REDO = loadImage("Images/back.png");
    image(RESULT,85, 370, 175, 180);
    image(REDO,90, 375, 20, 20);
    textSize(18);
    fill(255,255,255);
    for(int i=0;i<=reachedstage/5;i++){
      image(BUTTON,80,400+30*i,190,30);
      text("stage"+(i+1)+"　"+stagename[i],100,420+30*i);
    }
  }
  if(reset){
    RESULT = loadImage("Images/result.png");
    BUTTON = loadImage("Images/button.png");
    image(RESULT,85, 370, 175, 180);
    image(BUTTON,90,500,75,30);
    image(BUTTON,180,500,75,30);
    textSize(20);
    fill(0,0,0);
    text("リセットします。",90,450);
    text("よろしいですか？",90,470);
    fill(255,255,255);
    text("いいえ",98,520);
    text("はい",195,520);
  }
  if(clear){
    image(RESULT,40, 370, 265, 220);
    GAMECLEAR=loadImage("Images/GAMECLEAR.png");
    image(GAMECLEAR,80,380,185,35);
    textSize(20);
    fill(0,0,0);
    text("遊んでくれてありがとう！",60,440);
    text("プログラミング　：Velxot",58,460);
    text("イラスト(怪人)　：Velxot",60,480);
    text("イラスト(その他)：こめず",60,500);
    text("　　背景：Canva",60,520);
    text("　　音声：効果音ラボ",58,540);
    text("～クリックではじめから～",55,570);
  }
}

void mousePressed(){
  if(reset){
    if ( mouseX >= 100 && mouseX <= 100 + 60 && mouseY >= 500 && mouseY <= 500 + 20 ){
      tapSound.play();
      reset=false;
    }
    if ( mouseX >= 192 && mouseX <= 192 + 60 && mouseY >= 500 && mouseY <= 500 + 20 ){
      tapSound.play();
      //ステータス全リセット
      reset=false;
      setup();
      startBattle();
    }
    return;
  }
  if(clear){
    tapSound.play();
    //ステータス全リセット
    clear=false;
    setup();
    startBattle();
    return;
  }
  else if(stageselect){
    if((mouseX-100) * (mouseX-100)+ (mouseY-385) *(mouseY-385) <= 20 * 20){
      tapSound.play();
      stageselect = false;
    }
    for(int i=0;i<=reachedstage/5;i++){
      if ( mouseX >= 80 && mouseX <= 80 + 190 && mouseY >= 400+30*i && mouseY <= 400 + 30*i + 30 ){
        tapSound.play();
        stage = i*5;
        stageselect=false;
        startBattle();
        break;
      }
    }
    return;
  }
  else if(player.getHP() == 0 || enemy.getHP() == 0){
    if ( mouseX >= 100 && mouseX <= 100 + 60 && mouseY >= 500 && mouseY <= 500 + 20 ){
      tapSound.play();
      reset=true;
    }
    if ( mouseX >= 192 && mouseX <= 192 + 60 && mouseY >= 500 && mouseY <= 500 + 20 ){
      tapSound.play();
      if(enemy.getHP() == 0){
        stage++;
        if(reachedstage<stage && stage<=max_stage){
          reachedstage=stage;
        }
      }
      startBattle();
    }
    if(reachedstage / 5 >= 1){
      if ( mouseX >= 100 && mouseX <= 100 + 150 && mouseY >= 470 && mouseY <= 470 + 30 ){
        tapSound.play();
        stageselect = true;
      }
    }
  }
  else if(!enemyturn){
    for(int i = 0; i < hexagons.length; i++){
       if(hexagons[i].selected()){
           situation = 0;
           enemyturn = true;
       }
    }
  }
}

void setEnemy(int stage){
  if(stage==0){
    ENEMY=loadImage("Images/hopper_hex.png");
    BACK=loadImage("Images/grassland.png");
  }
  if(stage==1){
    ENEMY=loadImage("Images/mantis_hex.png");
    BACK=loadImage("Images/grassland.png");
  }
  if(stage==2){
    ENEMY=loadImage("Images/butterfly_hex.png");
    BACK=loadImage("Images/grassland.png");
  }
  if(stage==3){
    ENEMY=loadImage("Images/honet_hex.png");
    BACK=loadImage("Images/grassland.png");
  }
  if(stage==4){
    ENEMY=loadImage("Images/redibug_hex.png");
    BACK=loadImage("Images/grassland.png");
  }
  if(stage==5){
    ENEMY=loadImage("Images/sasori_hex.png");
    BACK=loadImage("Images/desert.png");
  }
  if(stage==6){
    ENEMY=loadImage("Images/kangaroo_hex.png");
    BACK=loadImage("Images/desert.png");
  }
  if(stage==7){
    ENEMY=loadImage("Images/rakuda_hex.png");
    BACK=loadImage("Images/desert.png");
  }
  if(stage==8){
    ENEMY=loadImage("Images/datyou_hex.png");
    BACK=loadImage("Images/desert.png");
  }
  if(stage==9){
    ENEMY=loadImage("Images/elephant_hex.png");
    BACK=loadImage("Images/desert.png");
  }
  if(stage==10){
    ENEMY=loadImage("Images/poseidon.png");
    BACK=loadImage("Images/heaven.png");
  }
  if(stage==11){
    ENEMY=loadImage("Images/zeus.png");
    BACK=loadImage("Images/heaven.png");
  }
  if(stage==12){
    ENEMY=loadImage("Images/hades.png");
    BACK=loadImage("Images/heaven.png");
  }
  if(stage==13){
    ENEMY=loadImage("Images/angel.png");
    BACK=loadImage("Images/heaven.png");
  }
  if(stage==14){
    ENEMY=loadImage("Images/satan.png");
    BACK=loadImage("Images/heaven.png");
  }
}

void gameover(){
  RESULT = loadImage("Images/result.png");
  BUTTON = loadImage("Images/button.png");
  image(RESULT,85, 370, 175, 180);
  image(BUTTON,90,500,75,30);
  image(BUTTON,180,500,75,30);
  textSize(40);
  fill(0,0,0);
  
  if(enemy.getHP() == 0){
    if(stage==max_stage){
      clear=true;
    }
    YOUWIN=loadImage("Images/YOUWIN.png");
    image(YOUWIN,90,380,165,30);
    textSize(20);
    if(exp_flug){
      player.checkLevel(enemy.getExperience());
      exp_flug=false;
    }
    if(enemy.drop>=drop_num){
      text("GET",100,430);
      fill(255,255,255);
      ellipse(150,422,20,20);
      fill(0,0,0);
      image(ENEMY,140,412,20,20);
      drop_flug=false;
      player.item[stage]=true;
      text(enemy.getExperience() + " EXP",170,430);
    }
    else{
      text(enemy.getExperience() + " EXP",130,430);
    }
    if(player.levelflug){
      text("LEVEL UP!",130,470);
    }
    else{
      text("次のレベルまで",100,450);
      text(player.experience + "/" + player.level_info[player.level],140,470);
    }
    fill(255,255,255);
    text("やめる",98,520);
    text("次へ",195,520);
  }
  else{
    YOULOSE=loadImage("Images/YOULOSE.png");
    image(YOULOSE,90,380,165,30);
    textSize(15);
    fill(0,0,0);
    textSize(20);
    fill(255,255,255);
    text("やめる",98,520);
    text("再挑戦",188,520);
    if(stage/5 ==0){
      textSize(15);
      fill(0,0,0);
      text("再挑戦を押して",100,430);
      text("もう一度勝負！",100,450);
    }
    else if(stage/5 == 1){
      textSize(15);
      fill(0,0,0);
      text("弱い敵と戦って",100,430);
      text("レベル上げをしよう",100,450);
    }
    else if(stage/5 == 2){
      textSize(15);
      fill(0,0,0);
      text("各敵はランダムで",100,430);
      text("強化アイテムを落とす",100,450);
      text("弱い敵も重要だ！",100,470);
    }
  }
  if(reachedstage/5>=1){
    textSize(20);
    fill(255,255,255);
    image(BUTTON,100,470,150,30);
    text("別ステージへ",110,490);
  }
}
