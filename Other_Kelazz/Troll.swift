class Troll: Enemy {
  // Troll has 70/30 chance of dealing normal attack, or dealing 3x damage to you
  // Gives you 1-10 elixir potion + 50 SQ as a drop

  override init() {
      super.init()
      self.name = "Troll"
      self.maxHP = 1000
      self.currHP = self.maxHP
      self.attack = 100
  }

  override func enemyVital(type: String) {
    if type == "Soft" {
      print("\n🧌 Name : \(self.name) x\(1) 🧌\nHP : \(self.currHP)/\(self.maxHP)")
    } else {
      print("==========================================")
      print("\n🧌 Name : \(self.name) x\(1) 🧌\nHP : \(self.currHP)/\(self.maxHP)\nAttack : \(self.attack)\n")
      print("Troll has 70/30 chance of dealing normal attack, or dealing 3x damage to you. Also gives you 1-10 elixir potion + 50 SQ as a drop")
      print("==========================================")
    }
  }
  
  override func Prolog() {
    print("\n\(Colors.blue)As you enter the forest, you feel a sense of unease wash over you.\nSuddenly, you hear the sound of twigs snapping behind you. You quickly spin around, and \(Colors.red)find a Troll emerging from the shadows.\(Colors.reset)")
  }
  
  override func attack(servant: Servant) {
    let attackChance = Int.random(in: 1...100)
    if attackChance <= 70 {
      servant.minusHP(damage: self.attack)
      print("\n\(Colors.red)The troll deals normal damage! [\(self.attack)]\(Colors.reset)")
    } else {
      servant.minusHP(damage: self.attack * 3)
      print("\n\(Colors.red)The troll deals 3 times damage, they found your weakness part! [\(self.attack * 3)]\(Colors.reset)")
    }
  }

  override func defeatedDrop(master: Master) -> Master {
    var master = master
    let dropChance = Int.random(in: 1...10)
    master.elixir_potion += dropChance
    master.changeSQ(amount: 50, plusminus: true)

    print("\n\(Colors.servantGold)The \(self.name) dropped \(dropChance) Elixir Potion(s) and 50 SQ! 💎\(Colors.reset)")
    return master
  }
}