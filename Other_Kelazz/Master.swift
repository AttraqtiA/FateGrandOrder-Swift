struct Master {  // pakai Mutating, can't inherit
  var name: String
  var heal_potion: Int
  var elixir_potion: Int
  var saint_quartz: Int
  var servant_party: [Servant]

  init(name: String) {
    self.name = name
    self.heal_potion = 0
    self.elixir_potion = 0
    self.saint_quartz = 0
    self.servant_party = []
  }

  mutating func changeSQ(amount: Int, plusminus: Bool) {
    if plusminus {
      self.saint_quartz += amount
    } else {
      self.saint_quartz -= amount
    }
  }

  func summonServant(summonType: String) -> Servant {  // Shielder is not summonable
    let gachaRarity = Int.random(in: 1...100)
    let gachaClass = Int.random(in: 1...7)
    var rarityResult: Int = 0

    if summonType == "Limited" {
      rarityResult = 5
    } else {
      if gachaRarity <= 5 {  // 5%
        rarityResult = 5
      } else if gachaRarity >= 6 && gachaRarity <= 15 {  // 10%
        rarityResult = 4
      } else if gachaRarity >= 16 && gachaRarity <= 35 {  // 20%
        rarityResult = 3
      } else if gachaRarity >= 36 && gachaRarity <= 65 {  // 30%
        rarityResult = 2
      } else if gachaRarity >= 66 && gachaRarity <= 100 {  // 35%
        rarityResult = 1
      }
    }

    if gachaClass == 1 {
      return Saber(name: "Arthur Pendragon", rarity: rarityResult, equipment: false)
    } else if gachaClass == 2 {
      return Archer(name: "Arjuna", rarity: rarityResult, equipment: false)
    } else if gachaClass == 3 {
      return Lancer(name: "Leonidas", rarity: rarityResult, equipment: false)
    } else if gachaClass == 4 {
      return Rider(name: "Iskandar", rarity: rarityResult, equipment: false)
    } else if gachaClass == 5 {
      return Caster(name: "Merlin", rarity: rarityResult, equipment: false)
    } else if gachaClass == 6 {
      return Assassin(name: "Jack the Ripper", rarity: rarityResult, equipment: false)
    } else if gachaClass == 7 {
      return Berserker(name: "Heracles", rarity: rarityResult, equipment: false)
    }

    return Servant(name: "default", rarity: 0, equipment: false)
  }

  mutating func addHealPotion(amount: Int) {
    if self.saint_quartz >= 5 {
      self.saint_quartz -= 5
      self.heal_potion += amount
      print("\n\(Colors.green)You bought 1 Heal Potion!\(Colors.reset)")
    } else {
      print("\n\(Colors.red)You don't have enough Saint Quartz, Master!\(Colors.reset)")
    }
  }

  mutating func addElixirPotion(amount: Int) {
    if self.saint_quartz >= 5 {
      self.saint_quartz -= 5
      self.elixir_potion += amount
      print("\n\(Colors.green)You bought 1 Elixir Potion!\(Colors.reset)")
    } else {
      print("\n\(Colors.red)You don't have enough Saint Quartz, Master!\(Colors.reset)")
    }
  }

  mutating func minusHealPotion(amount: Int) {
    self.heal_potion -= amount
  }

  mutating func minusElixirPotion(amount: Int) {
    self.elixir_potion -= amount
  }
  
  // Equipment Equip + Check
  mutating func checkPartyEquipment(classID: Int) {
    var specificServants: [Servant] = []
    var check: Bool = false

    if classID == 1 {  // Saber
      print(
        "Here are your \(Colors.servantGold)Sabers\(Colors.reset) with \(Colors.red)NO Equipment\(Colors.reset),\(Colors.magenta) Master! \(Colors.reset)"
      )
      for servant in self.servant_party {
        if servant is Saber && servant.equipment == false {
          check = true
          specificServants.append(servant)
        }
      }
      for (index, servant) in specificServants.enumerated() {
        print(
          "\(index + 1). \(servant.name) \(servant.rarity) ⭐ \(type(of: servant)) | HP \(servant.currHP)/\(servant.maxHP) | ATK \(servant.attack) | MP \(servant.currMP)/\(servant.maxMP) | NP \(servant.NP_gauge)%"
        )
      }
      if !check {
        print("\nYou don't have any Saber Servant with no equipment, Master!")
      } else {
        print("Choose : ")
        let equip = readLine()

        if let integerValue = Int(equip!) {
          if integerValue >= 1 && integerValue <= specificServants.count {
            specificServants[integerValue - 1].equipment = true
            self.saint_quartz -= 20
            print("\(specificServants[integerValue - 1].name) has been equipped with Sword!")
          } else {
            print("Your decision isn't clear, \(Colors.magenta)Master\(Colors.reset)")
          }
        } else if equip == "" {
          // break
        } else {
          print("\n")
        }
      }

    } else if classID == 2 {  // Archer
      print(
        "Here are your \(Colors.servantGold)Archers\(Colors.reset) with \(Colors.red)NO Equipment\(Colors.reset),\(Colors.magenta) Master! \(Colors.reset)"
      )
      for servant in self.servant_party {
        if servant is Archer && servant.equipment == false {
          check = true
          specificServants.append(servant)
        }
      }
      for (index, servant) in specificServants.enumerated() {
        print(
          "\(index + 1). \(servant.name) \(servant.rarity) ⭐ \(type(of: servant)) | HP \(servant.currHP)/\(servant.maxHP) | ATK \(servant.attack) | MP \(servant.currMP)/\(servant.maxMP) | NP \(servant.NP_gauge)%"
        )
      }
      if !check {
        print("\nYou don't have any Archer Servant with no equipment, Master!")
      } else {
        print("Choose : ")
        let equip = readLine()

        if let integerValue = Int(equip!) {
          if integerValue >= 1 && integerValue <= specificServants.count {
            specificServants[integerValue - 1].equipment = true
            self.saint_quartz -= 20
            print("\(specificServants[integerValue - 1].name) has been equipped with Bow n Arrow!")
          } else {
            print("Your decision isn't clear, \(Colors.magenta)Master\(Colors.reset)")
          }
        } else if equip == "" {
          // break
        } else {
          print("\n")
        }
      }
    } else if classID == 3 {  // Lancer
      print(
        "Here are your \(Colors.servantGold)Lancers\(Colors.reset) with \(Colors.red)NO Equipment\(Colors.reset),\(Colors.magenta) Master! \(Colors.reset)"
      )
      for servant in self.servant_party {
        if servant is Lancer && servant.equipment == false {
          check = true
          specificServants.append(servant)
        }
      }
      for (index, servant) in specificServants.enumerated() {
        print(
          "\(index + 1). \(servant.name) \(servant.rarity) ⭐ \(type(of: servant)) | HP \(servant.currHP)/\(servant.maxHP) | ATK \(servant.attack) | MP \(servant.currMP)/\(servant.maxMP) | NP \(servant.NP_gauge)%"
        )
      }
      if !check {
        print("\nYou don't have any Lancer Servant with no equipment, Master!")
      } else {
        print("Choose : ")
        let equip = readLine()

        if let integerValue = Int(equip!) {
          if integerValue >= 1 && integerValue <= specificServants.count {
            specificServants[integerValue - 1].equipment = true
            self.saint_quartz -= 20
            print("\(specificServants[integerValue - 1].name) has been equipped with Spear!")
          } else {
            print("Your decision isn't clear, \(Colors.magenta)Master\(Colors.reset)")
          }
        } else if equip == "" {
          // break
        } else {
          print("\n")
        }
      }
    } else if classID == 4 {  // Rider
      print(
        "Here are your \(Colors.servantGold)Riders\(Colors.reset) with \(Colors.red)NO Equipment\(Colors.reset),\(Colors.magenta) Master! \(Colors.reset)"
      )
      for servant in self.servant_party {
        if servant is Rider && servant.equipment == false {
          check = true
          specificServants.append(servant)
        }
      }
      for (index, servant) in specificServants.enumerated() {
        print(
          "\(index + 1). \(servant.name) \(servant.rarity) ⭐ \(type(of: servant)) | HP \(servant.currHP)/\(servant.maxHP) | ATK \(servant.attack) | MP \(servant.currMP)/\(servant.maxMP) | NP \(servant.NP_gauge)%"
        )
      }
      if !check {
        print("\nYou don't have any Rider Servant with no equipment, Master!")
      } else {
        print("Choose : ")
        let equip = readLine()

        if let integerValue = Int(equip!) {
          if integerValue >= 1 && integerValue <= specificServants.count {
            specificServants[integerValue - 1].equipment = true
            self.saint_quartz -= 20
            print("\(specificServants[integerValue - 1].name) has been equipped with Horse!")
          } else {
            print("Your decision isn't clear, \(Colors.magenta)Master\(Colors.reset)")
          }
        } else if equip == "" {
          // break
        } else {
          print("\n")
        }
      }
    } else if classID == 5 {  // Caster
      print(
        "Here are your \(Colors.servantGold)Casters\(Colors.reset) with \(Colors.red)NO Equipment\(Colors.reset),\(Colors.magenta) Master! \(Colors.reset)"
      )
      for servant in self.servant_party {
        if servant is Caster && servant.equipment == false {
          check = true
          specificServants.append(servant)
        }
      }
      for (index, servant) in specificServants.enumerated() {
        print(
          "\(index + 1). \(servant.name) \(servant.rarity) ⭐ \(type(of: servant)) | HP \(servant.currHP)/\(servant.maxHP) | ATK \(servant.attack) | MP \(servant.currMP)/\(servant.maxMP) | NP \(servant.NP_gauge)%"
        )
      }
      if !check {
        print("\nYou don't have any Caster Servant with no equipment, Master!")
      } else {
        print("Choose : ")
        let equip = readLine()

        if let integerValue = Int(equip!) {
          if integerValue >= 1 && integerValue <= specificServants.count {
            specificServants[integerValue - 1].equipment = true
            self.saint_quartz -= 20
            print("\(specificServants[integerValue - 1].name) has been equipped with Wand!")
          } else {
            print("Your decision isn't clear, \(Colors.magenta)Master\(Colors.reset)")
          }
        } else if equip == "" {
          // break
        } else {
          print("\n")
        }
      }
    } else if classID == 6 {  // Assassin
      print(
        "Here are your \(Colors.servantGold)Assassin\(Colors.reset) with \(Colors.red)NO Equipment\(Colors.reset),\(Colors.magenta) Master! \(Colors.reset)"
      )
      for servant in self.servant_party {
        if servant is Assassin && servant.equipment == false {
          check = true
          specificServants.append(servant)
        }
      }
      for (index, servant) in specificServants.enumerated() {
        print(
          "\(index + 1). \(servant.name) \(servant.rarity) ⭐ \(type(of: servant)) | HP \(servant.currHP)/\(servant.maxHP) | ATK \(servant.attack) | MP \(servant.currMP)/\(servant.maxMP) | NP \(servant.NP_gauge)%"
        )
      }
      if !check {
        print("\nYou don't have any Assassin Servant with no equipment, Master!")
      } else {
        print("Choose : ")
        let equip = readLine()

        if let integerValue = Int(equip!) {
          if integerValue >= 1 && integerValue <= specificServants.count {
            specificServants[integerValue - 1].equipment = true
            self.saint_quartz -= 20
            print("\(specificServants[integerValue - 1].name) has been equipped with Knife!")
          } else {
            print("Your decision isn't clear, \(Colors.magenta)Master\(Colors.reset)")
          }
        } else if equip == "" {
          // break
        } else {
          print("\n")
        }
      }
    } else {
      print("No way more than 6 classes that can equip, Master!")
    }
  }

}
