class Rider: Servant { 
  override init(name: String, rarity: Int, equipment: Bool) {
    super.init(name: name, rarity: rarity, equipment: equipment)
  }

  override func attack(enemy: Servant) {
    if enemy is Caster {
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
    print("\n\(Colors.servantGold)\(self.name) uses Ionioi Hetairoi! Recovers to full HP!! \(Colors.reset)")
    self.currHP = self.maxHP

    self.NP_gauge = 0
  }

  // strong against Caster
  // NP : Heal 100% HP
}