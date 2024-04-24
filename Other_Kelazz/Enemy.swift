class Enemy {
  // Golem has passive healing of 10% max HP,
  // Gives you 1-10 health potion + 50 SQ as a drop

  var name: String
  var maxHP: Double
  var currHP: Double
  var attack: Double

  init() {
    self.name = "default"
    self.maxHP = 0
    self.currHP = self.maxHP
    self.attack = 0
  }

  func enemyVital(type: String) {
    print("Info leaked")
  }

  func Prolog() {
    print("Intentional Yapping.inc")
  }

  func attack(servant: Servant) {
    servant.minusHP(damage: self.attack)
  }
  
  func minusHP(damage: Double) {
    currHP -= damage
  }

  func defeatedDrop(master: Master) -> Master {
    // drop chance
    return master
  }
}
