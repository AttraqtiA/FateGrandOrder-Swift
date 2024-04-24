class Golem: Enemy {
  // Golem has passive healing of 10% max HP,
  // Gives you 1-10 heal potion + 50 SQ as a drop

  override init() {
      super.init()
      self.name = "Golem"
      self.maxHP = 1500
      self.currHP = self.maxHP
      self.attack = 100
  }

  override func enemyVital(type: String) {
    if type == "Soft" {
      print("\n🪨 Name : \(self.name) x\(1) 🪨\nHP : \(self.currHP)/\(self.maxHP)")
    } else {
      print("\n🪨 Name : \(self.name) x\(1) 🪨\nHP : \(self.currHP)/\(self.maxHP)\nAttack : \(self.attack)\n")
      print("Golem has passive healing of 10% max HP. Also gives you 1-10 health potion + 50 SQ as a drop")
    }
  }
  
  override func Prolog() {
    print("\n\(Colors.blue)As you make your way through the rugged mountain terrain, you can feel the chill of the wind biting at your skin. Suddenly, you hear a sound that makes you freeze in your tracks. That's when you see it - \(Colors.red)a massive, snarling Golem emerging from the shadows.\(Colors.reset)")
  }
  
  override func attack(servant: Servant) {
    self.currHP += self.maxHP * 0.1
    if self.currHP > self.maxHP {
      self.currHP = self.maxHP
    }
    
    servant.minusHP(damage: self.attack)
    print("\n\(Colors.red)The bandit deals damage and steals 10 SQ from you! [\(self.attack)]\(Colors.reset)")
  }

  override func defeatedDrop(master: Master) -> Master {
    var master = master
    let dropChance = Int.random(in: 1...10)
    master.heal_potion += dropChance
    master.changeSQ(amount: 50, plusminus: true)

    print("\n\(Colors.servantGold)The \(self.name) dropped \(dropChance) Heal Potion(s) and 50 SQ! 💎\(Colors.reset)")
    return master
  }
}