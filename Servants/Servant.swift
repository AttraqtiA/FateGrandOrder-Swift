class Servant { // As wild servant, when defeated, will drop flat 300 SQ + 5 heal potion + 5 elixir potion
    var name: String
    var maxHP: Double
    var currHP: Double
    var attack: Double
    var rarity: Int // 1 - 5 star
    var currMP: Int
    var maxMP: Int
    var NP_gauge: Int
    var equipment: Bool

  init(name: String, rarity: Int, equipment: Bool) {
      self.name = name
      self.rarity = rarity
      self.NP_gauge = 0
      self.maxHP = 1000
      self.currHP = self.maxHP
      self.maxMP = 100
      self.currMP = self.maxMP
      self.attack = 100
      self.equipment = equipment
  }

    func physical_atk(enemy: Enemy) {
      enemy.minusHP(damage: 100)
      print("\n\(Colors.blue)\(self.name) attacks \(enemy.name) physically [100]\(Colors.reset)!")
    }

    func meteor(enemy: Enemy) {
      if self.currMP >= 15 {
        currMP -= 15
        enemy.minusHP(damage: 250)
        print("\n\(Colors.blue)\(self.name) calls a meteor against \(enemy.name) [250] \(Colors.reset)!")
      } else {
        print("\n\(Colors.red)Not enough MP\(Colors.reset)")
      }
    }

    func shield(enemy: Enemy) -> Bool {
      if self.currMP >= 10 {
        currMP -= 10
        print("\n\(Colors.green)\(self.name) blocks \(enemy.name)'s next attack'\(Colors.reset)!")
        return true
      } else {
        print("\n\(Colors.red)Not enough MP\(Colors.reset)")
        return false
      }
    }
  
    func attack(enemy: Servant) {
      
      enemy.minusHP(damage: self.attack)
    }

    func minusHP(damage: Double) {
      self.currHP -= damage
    }

    func useHealPotion() {
      let old_HP = self.currHP
      self.currHP += 200 
      if self.currHP > self.maxHP {
        self.currHP = self.maxHP
      }

      print("\n\(Colors.green)Healed from \(old_HP)/\(self.maxHP) to \(self.currHP)/\(self.maxHP)\(Colors.reset)")
    }

    func useElixirPotion() {
      let old_MP = self.currMP
      self.currMP += 20 
      if self.currMP > self.maxMP {
        self.currMP = self.maxMP
      }

      print("\(Colors.green)Recharged from \(old_MP)/\(self.maxMP) to \(self.currMP)/\(self.maxMP)\(Colors.reset)")
    }
  
    func noblePhantasm(enemy: Servant) {
      // Deal ult damage, heal, and stuff, will be override for sure
    }

    func defeatedDrop(master: Master) -> Master {
      var master = master
      master.changeSQ(amount: 300, plusminus: true)
      master.heal_potion += 5
      master.elixir_potion += 5

      print("\(Colors.servantGold)The \(self.name) dropped 300 SQ, 5 Heal Potion, and 5 Elixir Potion! 💎\(Colors.reset)")
      
      return master
    }
}