class Bandit: Enemy {
  // Bandit steals 10 SQ every turn
  // Gives you a mouthful 200-500 SQ as a drop
  
  var stolen: Int = 0

  override init() {
      super.init()
      self.name = "Bandit"
      self.maxHP = 1000
      self.currHP = self.maxHP
      self.attack = 100
  }

  override func enemyVital(type: String) {
    if type == "Soft" {
      print("\n🪙 Name : \(self.name) x\(1) 🪙\nHP : \(self.currHP)/\(self.maxHP)")
    } else {
      print("\n🪙 Name : \(self.name) x\(1) 🪙\nHP : \(self.currHP)/\(self.maxHP)\nAttack : \(self.attack)\n")
      print("Bandit steals 10 SQ every turn. Also gives you a mouthful 200-500 SQ as a drop")
    }
  }
  
  override func Prolog() {
    print("\n\(Colors.blue)Bustling marketplace. Cries and bartering drown out your unease. A hand clamps your mouth, stifling a gasp. 'Don't move,' a low voice rasps. A hooded figure looms, eyes gleaming with avarice. \(Colors.red)A bandit for your belongings.\(Colors.reset)")
  }

  func banditSteal(master: Master) -> Master {
    var master = master
    master.changeSQ(amount: 10, plusminus: false)

    return master
  }

  override func attack(servant: Servant) {
    servant.minusHP(damage: self.attack)

    print("\n\(Colors.red)The bandit deals damage and steals 10 SQ from you! [\(self.attack)]\(Colors.reset)")
  }

  override func defeatedDrop(master: Master) -> Master {
    var master = master
    let dropChance = Int.random(in: 200...500)
    master.changeSQ(amount: dropChance, plusminus: true)

    print("\(Colors.servantGold)The \(self.name) dropped \(dropChance) SQ! 💎\(Colors.reset)")
    return master
  }
}