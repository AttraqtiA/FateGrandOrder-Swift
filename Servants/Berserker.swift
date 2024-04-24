class Berserker: Servant { 
  override init(name: String, rarity: Int, equipment: Bool) {
    super.init(name: name, rarity: rarity, equipment: equipment)
  }

  override func attack(enemy: Servant) {
        if enemy is Shielder {
          enemy.minusHP(damage: self.attack)
          print("\n\(Colors.blue)Using a standard attack against \(enemy.name)!\(Colors.reset)") 
        } else {
          enemy.minusHP(damage: self.attack * 2)
          print("\n\(Colors.red)\(self.name) attacks \(enemy.name) with a powerful thrust! (Strong)\(Colors.reset)")
        }

  }

// strong against Everyone, except Shielder (2x damage)
// NO ULT OR NP --> NO Equipment too
}
