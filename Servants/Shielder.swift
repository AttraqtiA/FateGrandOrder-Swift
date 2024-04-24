class Shielder: Servant { 
  override init(name: String, rarity: Int, equipment: Bool) {
    super.init(name: name, rarity: rarity, equipment: equipment)
  }

  override func attack(enemy: Servant) {
    enemy.minusHP(damage: self.attack)
    print("\n\(Colors.blue)Using a standard attack against \(enemy.name)!\(Colors.reset)") 
    
    self.currHP += self.maxHP * 0.1
    if self.currHP > self.maxHP {
      self.currHP = self.maxHP
    }
    print("\n\(self.name) also heals herself by 10% of her max HP!")
  
  }
}

// neutral damage to all
// Special passive : 10% of max HP heal per turn
// NO ULT OR NP --> NO Equipment too