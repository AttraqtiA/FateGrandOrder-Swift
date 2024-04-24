class Lancer: Servant { 
  override init(name: String, rarity: Int, equipment: Bool) {
    super.init(name: name, rarity: rarity, equipment: equipment)
  }

  override func attack(enemy: Servant) {
    if enemy is Archer {
      enemy.minusHP(damage: self.attack * 1.5)
      print("\n\(Colors.red)\(self.name) attacks \(enemy.name) with a powerful thrust! (Strong)\(Colors.reset)")
    } else {
      enemy.minusHP(damage: self.attack)
      print("\n\(Colors.blue)Using a standard attack against \(enemy.name)!\(Colors.reset)") 
    }

    let NP_gain = Int.random(in: 20...50)

    self.NP_gauge += NP_gain 
    if self.NP_gauge > 100 {
      self.NP_gauge = 100
    }
    print("\n\(Colors.magenta)\(self.name) gains \(NP_gain)% NP! \(Colors.reset)")
  }

  override func noblePhantasm(enemy: Servant) {
    print("\n\(Colors.servantGold)\(self.name) uses Thermopylae Enomotia! Heals 70% HP and deal 2.5x damage! \(Colors.reset)")
    self.currHP += self.maxHP * 0.7
    if self.currHP > self.maxHP {
      self.currHP = self.maxHP
    }
    enemy.minusHP(damage: self.attack * 2.5)

    self.NP_gauge = 0
  }
}

// strong against Archer
// NP : Increase max HP stat permanently (even after battle) by 30%