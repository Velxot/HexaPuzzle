class Chara{
  int max_hp,hp,attack_point,experience;
  
  Chara(){
  }
  
  void Attack(){
  }
  int getHP(){
    return this.hp;
  }
  void setHP(int hp){
    this.hp=hp;
    if(hp<0){
      this.hp=0;
    }
    else if(hp>max_hp){
      this.hp=max_hp;
    }
  }
}
