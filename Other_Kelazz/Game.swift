import Foundation

// Emoji --> command + ctrl + space
// Emoji on Windows --> Windows key + .

class Game {
  var currentMaster: Master = Master(name: "default")  // Default master, will 100% be replaced after this
  var currentEnemy: Enemy = Enemy()
  var currentServant: Servant = Servant(name: "default", rarity: 0, equipment: false)
  var enemyServant: Servant = Servant(name: "default", rarity: 0, equipment: true) // Any enemy servant is in 3 star rarity, equipment true by default

  func startGame() {
    openingScreen()
    welcomingScreen()
    journeyScreen()
  }

  func openingScreen() {
    // Opening Screen
    while true {
      print(
        "=========================================\n"
          + "Welcome to Chaldea Simulator Terminal"
          + "\n=========================================")
      print(
        "Place where the threads of destiny are yours to weave! As a\(Colors.magenta) Master of the Holy Grail War\(Colors.reset), your journey begins here amidst the boundless expanse of time and space. Within this digital realm, you shall summon heroic spirits known as Servants, legendary figures plucked from history and myth, to aid you in your quest for greatness.\n"
      )
      print(Colors.blue + "Press [return] to begin, Master!" + Colors.reset)

      let return_opening = readLine()

      if return_opening == "" {
        break
      } else {
        print("\n")
      }
    }
  }

  func welcomingScreen() {
    // Welcoming Screen
    while true {
      print(
        "\nAs a \(Colors.magenta)Master\(Colors.reset), your role is pivotal. You must command your chosen Servants with wisdom and cunning, forging bonds that transcend time itself. Through battles both fierce and formidable, you will hone your skills as a strategist, leading your Servants to victory against formidable foes and treacherous adversaries.\n\n\(Colors.blue)Now, may I ask your name?\(Colors.reset)"
      )

      guard let name = readLine(), !name.isEmpty else {
        continue
      }

      let alphabeticPattern = "^[a-zA-Z]+$"

      if name.range(of: alphabeticPattern, options: .regularExpression) != nil {
        currentMaster = Master(name: name)
        print(
          "\n\"\(Colors.magenta)\(currentMaster.name)\(Colors.reset), I ask of you, Are you my master?\""
        )
        break
      }
    }

    print(
      "\nBut what are these \(Colors.servantGold)Servants\(Colors.reset), you ask? They are beings of unparalleled strength and skill, each belonging to one of ~seven distinct classes: Saber, Lancer, Archer, Rider, Caster, Assassin, Berserker, and Extra classes. Each class possesses its own unique attributes and abilities, ensuring a diverse array of strategies at your disposal."
    )

    sleep(1)

    currentMaster.servant_party.append(Shielder(name: "Mash Kyrielight", rarity: 3, equipment: false))

    print(
      "\nBut you're not alone at the start of this journey. A distinguished Servant will accompany you as your first ally. Meet Mash Kyrielight, from a unique class—the neutral Shielder class.\n\n\(Colors.green)Mash Kyrielight 3⭐ Shielder 🛡️  joins your party!\(Colors.reset)"
    )

    print(
      "\nPrepare yourself, Master, for the adventure of a lifetime awaits. Welcome to the Chaldea Simulation Terminal!"
    )

    sleep(1)
  }

  func journeyScreen() {
    // Journey Screen / Main Menu
    while true {
      print("\n\(Colors.blue)What's your order?\(Colors.reset)")
      print(
        "[M]aster info + Add Saint Quartz\n[H]eal your wounds with potion\n[S]ummon a Servant\n[A]ll Servant\n[L]earn about Servants (Codex)\n[B]uy at Merchant's Shop"
      )
      print("\n\(Colors.red)BATTLE QUESTS\(Colors.reset)")
      print(
        "[F]orest of Troll\n[G]olem Mountain\n[T]hief Surprise\n\n[V]ersus Wild Servants\n\n[Q]uit\n\(Colors.blue)Choose : \(Colors.reset)"
      )

      guard let menu = readLine(), !menu.isEmpty else {
        continue
      }

      if menu.caseInsensitiveCompare("M") == .orderedSame {
        currentMaster = C_heckServant(currentMaster: currentMaster)
      } else if menu.caseInsensitiveCompare("H") == .orderedSame {
        currentMaster = H_ealWounds(currentMaster: currentMaster)
      } else if menu.caseInsensitiveCompare("S") == .orderedSame {
        currentMaster = S_ummonServant(currentMaster: currentMaster)
      } else if menu.caseInsensitiveCompare("A") == .orderedSame {
        A_llServant(currentMaster: currentMaster)
      } else if menu.caseInsensitiveCompare("L") == .orderedSame {
        Codex()
      } else if menu.caseInsensitiveCompare("B") == .orderedSame {
        currentMaster = B_uyMerchant(currentMaster: currentMaster)
      } else if menu.caseInsensitiveCompare("F") == .orderedSame {
        if currentMaster.servant_party.isEmpty {
          print("\n\(Colors.red)No Servant found, Master!! You're gonna fight with bare hands??!\(Colors.reset)")
        } else {
          currentMaster = EnemyBattle(currentMaster: currentMaster, enemy_type: "Troll")
        }
      } else if menu.caseInsensitiveCompare("G") == .orderedSame {
        if currentMaster.servant_party.isEmpty {
          print("\n\(Colors.red)No Servant found, Master!! You're gonna fight with bare hands??\(Colors.reset)")
        } else {
          currentMaster = EnemyBattle(currentMaster: currentMaster, enemy_type: "Golem")
        }
      } else if menu.caseInsensitiveCompare("T") == .orderedSame {
        if currentMaster.servant_party.isEmpty {
          print("\n\(Colors.red)No Servant found, Master!! You're gonna fight with bare hands??\(Colors.reset)")
        } else {
          currentMaster = EnemyBattle(currentMaster: currentMaster, enemy_type: "Bandit")
        }
      } else if menu.caseInsensitiveCompare("V") == .orderedSame {
        if currentMaster.servant_party.isEmpty {
          print("\n\(Colors.red)No Servant found, Master!! You're gonna fight with bare hands??\(Colors.reset)")
        } else {
          currentMaster = V_ersusWildServants(currentMaster: currentMaster)
        }
      } else if menu.caseInsensitiveCompare("Q") == .orderedSame {
        print("\n\(Colors.blue)Thank you for playing the Chaldea Simulator!\(Colors.reset)")
        break
      } else {
        print("\nYour decision isn't clear, \(Colors.magenta)Master\(Colors.reset)")
      }
    }
  }
  

  func C_heckServant(currentMaster: Master) -> Master {
    var currentMaster = currentMaster
    while true {
      print(
        "\nHere are your stats, \(Colors.magenta)\(currentMaster.name)\(Colors.reset)!\n❤️‍🩹 Heal Potion : \(currentMaster.heal_potion)\n💧 Elixir Potion : \(currentMaster.elixir_potion)\n💎 Saint Quartz : \(currentMaster.saint_quartz)"
      )
      print(
        "\n\(Colors.servantGold)Servant Info\(Colors.reset)\nIn order to check your servants, please proceed to the \(Colors.blue)[A]ll Servant\(Colors.reset)\nTo learn each Servant's class characteristics, proceed to \(Colors.blue)[L]earn about Servants (Codex)\(Colors.reset)\n\nAdd Saint Quartz funds : \(Colors.blue)or Press [return] to Go Back!\(Colors.reset)"
      )
      let sq_amount = readLine()

      if let integerValue = Int(sq_amount!) {
        if integerValue >= 0 {
          currentMaster.changeSQ(amount: integerValue, plusminus: true)
          print("\n\(integerValue) Saint Quartz has been added to your pocket, Master!")
        } else {
          print("You can't add negative Saint Quartz!")
        }
      } else if sq_amount == "" {
        break
      } else {
        print("\n")
      }
    }

    return currentMaster
  }

  func H_ealWounds(currentMaster: Master) -> Master {
    var currentMaster = currentMaster
    var servant_address: Int = -1

    if currentMaster.heal_potion > 0 {
      while true {
        print("\nChoose a \(Colors.servantGold)Servant\(Colors.reset) to heal!")
        for (index, servant) in currentMaster.servant_party.enumerated() {
          print(
            "\(index + 1). \(servant.name) \(servant.rarity) ⭐ \(type(of: servant)) | HP \(servant.currHP)/\(servant.maxHP) | ATK \(servant.attack) | MP \(servant.currMP)/\(servant.maxMP) | NP \(servant.NP_gauge)%"
          )
          if servant.equipment {
            print("⚔️  Special Equipment : \(Colors.green)Equipped\(Colors.reset)")
          } else {
            print("⚔️  Special Equipment : \(Colors.red)None\(Colors.reset)")
          }
        }

        print("Choose : \(Colors.blue)Press [return] to go back\(Colors.reset)")
        let deploy = readLine()

        if let integerValue = Int(deploy!) {
          if integerValue >= 1 && integerValue <= currentMaster.servant_party.count {
            currentServant = currentMaster.servant_party[integerValue - 1]
            servant_address = integerValue - 1
            break
          } else {
            print("\nYour decision isn't clear, \(Colors.magenta)Master\(Colors.reset)")
          }
        } else if deploy == "" {
          return currentMaster
        } else {
          print("\nYour decision isn't clear, \(Colors.magenta)Master\(Colors.reset)")
        }
      }


      while true {
        if currentMaster.heal_potion > 0 {
          print("You have \(currentMaster.heal_potion) Heal Potions")
          print("\nAre you sure you want to use a heal potion? (Y/N)")

          let heal = readLine()

          if heal?.caseInsensitiveCompare("Y") == .orderedSame {
            currentServant.useHealPotion()
            currentMaster.minusHealPotion(amount: 1)
            currentMaster.servant_party[servant_address] = currentServant

          } else if heal?.caseInsensitiveCompare("N") == .orderedSame {
            break
          } else {
            print("\n")
          }
        } else {
          print("\n\(Colors.red)You don't have any heal potions, \(Colors.magenta)Master\(Colors.reset)")
          break
        }
      }
    } else {
      print("\n\(Colors.red)You don't have any heal potions, \(Colors.magenta)Master\(Colors.reset)")
    }

    return currentMaster
  }

  func S_ummonServant(currentMaster: Master) -> Master {
    var currentMaster = currentMaster
    while true {
      print(
        "\nDo you want to summon a servant? \(Colors.backgroundGold)One summon = 3 Saint Quartz\(Colors.reset)\nYou have \(currentMaster.saint_quartz) Saint Quartz\nChances : 5⭐ (5%), 4⭐ (10%), 3⭐ (20%), 2⭐ (30%), 1⭐ (35%)\nDo you want to summon once? (Y/N) \(Colors.blue)Press [return] to go back\(Colors.reset)"
      )

      let summonChoice = readLine()

      if summonChoice == "" {
        break
      } else if summonChoice?.caseInsensitiveCompare("Y") == .orderedSame {
        if currentMaster.saint_quartz >= 3 {
          print("\nAnalyzing the Saint Quartz...")
          sleep(1)
          print("Searching for a Servant to Link...")
          sleep(1)
          let newServant: Servant = currentMaster.summonServant(summonType: "Normal")
          if newServant.rarity == 5 || newServant.rarity == 4 {
            print(
              "\(Colors.servantGold)\(newServant.name) \(newServant.rarity) ⭐ \(type(of: newServant)) joins your party!\(Colors.reset)"
            )
          } else {
            print(
              "\(Colors.green)\(newServant.name) \(newServant.rarity) ⭐ \(type(of: newServant)) joins your party!\(Colors.reset)"
            )
          }

          currentMaster.changeSQ(amount: 3, plusminus: false)
          currentMaster.servant_party.append(newServant)
        } else {
          print("\n\(Colors.red)You don't have enough Saint Quartz, Master!\(Colors.reset)")
        }
      } else if summonChoice?.caseInsensitiveCompare("N") == .orderedSame {
        break
      } else {
        print("\n")
      }
    }

    return currentMaster
  }

  func A_llServant(currentMaster: Master) {
    while true {
      if currentMaster.servant_party.isEmpty {
        print("\n\(Colors.red)No Servant found, Master!!\(Colors.reset)")
      } else {
        print(
          "\nHere are your \(Colors.servantGold)Servants, \(Colors.magenta)Master\(Colors.reset)!")
        for servant in currentMaster.servant_party {
          print(
            "🥷  \(servant.name) \(servant.rarity) ⭐ \(type(of: servant)) | HP \(servant.currHP)/\(servant.maxHP) | ATK \(servant.attack) | MP \(servant.currMP)/\(servant.maxMP) | NP \(servant.NP_gauge)%"
          )

          if servant is Berserker || servant is Shielder {
            print("⛔ Special Equipment \(Colors.red)Locked\(Colors.reset)")
          } else {
            if servant.equipment {
              print("⚔️  Special Equipment : \(Colors.green)Equipped\(Colors.reset)")
            } else {
              print("⚔️  Special Equipment : \(Colors.red)None\(Colors.reset)")
            }
          }
        }
      }
      print("\n\(Colors.blue)Press [return] to go back\(Colors.reset)")
      let allservants_return = readLine()

      if allservants_return == "" {
        break
      } else {
        print("\n")
      }
    }
  }

  func B_uyMerchant(currentMaster: Master) -> Master {
    var currentMaster = currentMaster

    while true {
      print(
        "\n\(Colors.blue)What're ya buyin, Stranger?\(Colors.reset)\nYou have \(currentMaster.saint_quartz) Saint Quartz (SQ)"
      )
      var limitedshop_trigger: Bool = false
      let fivestar_servant = Int.random(in: 1...100)
      if fivestar_servant <= 20 {
        limitedshop_trigger = true
        print("\(Colors.servantGold)Got somethin' that might interest ya'!\(Colors.reset)")
        print("0. 💛Random 5 star Servant ticket💛 \(Colors.backgroundGold)[100 SQ]\(Colors.reset)")
      } else {
        print("\(Colors.blue)~There's a 20% chance for a tempting item to appear~\(Colors.reset)")
      }

      print("\n1. Heal Potion \(Colors.backgroundGold)[5 SQ]\(Colors.reset)")
      print("\n2. Elixir Potion \(Colors.backgroundGold)[5 SQ]\(Colors.reset)")

      print("\nClass-Unique Equipment \(Colors.backgroundGold)[Each 20 SQ]\(Colors.reset)")
      print(
        "3. Sword (Saber)\n4. Bow n Arrow (Archer)\n5. Spear (Lancer)\n6. Horse (Rider)\n7. Wand (Caster)\n8. Knife (Assassin)\n\(Colors.blue)Press [return] to go back\(Colors.reset) Choose : "
      )
      let shopping = readLine()

      if let integerValue = Int(shopping!) {
        if limitedshop_trigger && integerValue == 0 {
          if currentMaster.saint_quartz >= 100 {
            print("\nAnalyzing the Saint Quartz...")
            sleep(1)
            print("Searching for a \(Colors.servantGold)Gold Servant\(Colors.reset) to Link...")
            sleep(1)
            let newServant: Servant = currentMaster.summonServant(summonType: "Limited")
            print(
              "\(Colors.green)\(newServant.name) \(newServant.rarity) ⭐ \(type(of: newServant)) joins your party!\(Colors.reset)"
            )

            currentMaster.changeSQ(amount: 100, plusminus: false)
            currentMaster.servant_party.append(newServant)
          } else {
            print("\n\(Colors.red)You don't have enough Saint Quartz, Master!\(Colors.reset)")
          }

        } else if integerValue == 1 {
          currentMaster.addHealPotion(amount: 1)
        } else if integerValue == 2 {
          currentMaster.addElixirPotion(amount: 1)
        } else if integerValue >= 3 && integerValue <= 8 {
          if currentMaster.saint_quartz >= 20 {
            if integerValue == 3 {
              currentMaster.checkPartyEquipment(classID: 1)
            } else if integerValue == 4 {
              currentMaster.checkPartyEquipment(classID: 2)
            } else if integerValue == 5 {
              currentMaster.checkPartyEquipment(classID: 3)
            } else if integerValue == 6 {
              currentMaster.checkPartyEquipment(classID: 4)
            } else if integerValue == 7 {
              currentMaster.checkPartyEquipment(classID: 5)
            } else if integerValue == 8 {
              currentMaster.checkPartyEquipment(classID: 6)
            }
          } else {
            print("\n\(Colors.red)You don't have enough Saint Quartz, Master!\(Colors.reset)")
          }
        } else {
          print("\nYour decision isn't clear, \(Colors.magenta)Master\(Colors.reset)")
        }
      } else if shopping == "" {
        break
      } else {
        print("\n")
      }
    }

    return currentMaster
  }

  // ENEMY BATTLE -- VERSUS TROLL, GOLEM, OR BANDIT
  func EnemyBattle(currentMaster: Master, enemy_type: String) -> Master {
    var currentMaster = currentMaster
    var shield_trigger: Bool = false
    var wrong_input: Bool = false
    var servant_address: Int = -1

    while true {
      print("\nChoose a \(Colors.servantGold)Servant\(Colors.reset) to Deploy!")
      for (index, servant) in currentMaster.servant_party.enumerated() {
        print(
          "\(index + 1). \(servant.name) \(servant.rarity) ⭐ \(type(of: servant)) | HP \(servant.currHP)/\(servant.maxHP) | ATK \(servant.attack) | MP \(servant.currMP)/\(servant.maxMP) | NP \(servant.NP_gauge)%"
        )
        if servant.equipment {
          print("⚔️  Special Equipment : \(Colors.green)Equipped\(Colors.reset)")
        } else {
          print("⚔️  Special Equipment : \(Colors.red)None\(Colors.reset)")
        }
      }

      print("Choose : \(Colors.blue)Press [return] to go back\(Colors.reset)")
      let deploy = readLine()

      if let integerValue = Int(deploy!) {
        if integerValue >= 1 && integerValue <= currentMaster.servant_party.count {
          currentServant = currentMaster.servant_party[integerValue - 1]
          servant_address = integerValue - 1
          break
        } else {
          print("\nYour decision isn't clear, \(Colors.magenta)Master\(Colors.reset)")
        }
      } else if deploy == "" {
        return currentMaster
      } else {
        print("\nYour decision isn't clear, \(Colors.magenta)Master\(Colors.reset)")
      }
    }

    if enemy_type == "Troll" {
      currentEnemy = Troll()
    } else if enemy_type == "Golem" {
      currentEnemy = Golem()
    } else if enemy_type == "Bandit" {
      currentEnemy = Bandit()
    }

    currentEnemy.Prolog()

    while true {
      if currentServant.currHP <= 0 {
        print("\n\(Colors.red)\(currentServant.name) got defeated! You Lost the battle!\(Colors.reset)")
        print("\n\(Colors.red)\(currentServant.name) has been removed from your party! But you could summon him again!\(Colors.reset)")
        currentMaster.servant_party.remove(at: servant_address)

        break
      } else {
        currentEnemy.enemyVital(type: "Soft")
        print(
          "\n\n🥷 \(currentServant.name) \(currentServant.rarity) ⭐ \(type(of: currentServant)) | HP \(currentServant.currHP)/\(currentServant.maxHP) | ATK \(currentServant.attack) | MP \(currentServant.currMP)/\(currentServant.maxMP)"
        )

        // YOUR TURN ⚔️
        print(
          "\n\(Colors.blue)Choose your action : \(Colors.reset)\n1. Physical attack, no MP required, deal 100 damage\n2. Meteor, use 15 MP, deal 250 damage\n3. Shield, use 10 MP, block enemy's attack for 1 turn"
        )

        print(
          "\n4. Use Heal Potion\n5. Use Elixir Potion\n6. Scan enemy's vital for info\n7. Flee from battle\n\n\(Colors.blue)Your command, \(Colors.magenta)Master?\(Colors.reset)"
        )

        let action = readLine()

        if let integerValue = Int(action!) {
          if integerValue == 1 {
            currentServant.physical_atk(enemy: currentEnemy)
          } else if integerValue == 2 {
            currentServant.meteor(enemy: currentEnemy)
          } else if integerValue == 3 {
            if currentServant.shield(enemy: currentEnemy) {
              shield_trigger = true
            }
          } else if integerValue == 4 {
              while true {
                if currentMaster.heal_potion > 0 {
                  print("You have \(currentMaster.heal_potion) Heal Potions")
                  print("\nAre you sure you want to use a heal potion? (Y/N)")

                  let heal = readLine()

                  if heal?.caseInsensitiveCompare("Y") == .orderedSame {
                    currentServant.useHealPotion()
                    currentMaster.minusHealPotion(amount: 1)
                  } else if heal?.caseInsensitiveCompare("N") == .orderedSame {
                    break
                  } else {
                    print("\n")
                  }
                } else {
                  print("\n\(Colors.red)You don't have any heal potions, \(Colors.magenta)Master\(Colors.reset)")
                  break
                }
              }

          } else if integerValue == 5 {
              while true {
                if currentMaster.elixir_potion > 0 {
                  print("You have \(currentMaster.elixir_potion) Elixir Potions")
                  print("\nAre you sure you want to use an elixir potion? (Y/N)")

                  let elixir = readLine()

                  if elixir?.caseInsensitiveCompare("Y") == .orderedSame {
                    currentServant.useElixirPotion()
                    currentMaster.minusElixirPotion(amount: 1)

                  } else if elixir?.caseInsensitiveCompare("N") == .orderedSame {
                    break
                  } else {
                    print("\n")
                  }
                } else {
                  print("\n\(Colors.red)You don't have any elixir potions, \(Colors.magenta)Master\(Colors.reset)")
                  break
                }
              }
          } else if integerValue == 6 {
            print("\n====================================\n\(Colors.blue)Scanning for enemy's vital...\(Colors.reset)")
            sleep(1)
            currentEnemy.enemyVital(type: "Vital")
            print("====================================")
          } else if integerValue == 7 {
            print("\n\(Colors.red)What a coward, you flee from the battle\(Colors.reset)")
            currentMaster.servant_party[servant_address] = currentServant
            break
          } else {
            print("\nYour decision isn't clear, \(Colors.magenta)Master\(Colors.reset)")
            wrong_input = true
          }
        } else {
          print("\nYour decision isn't clear, \(Colors.magenta)Master\(Colors.reset)")
          wrong_input = true
        }
      }


      // ENEMY TURN 😡
      if currentEnemy.currHP <= 0 {
        print("\n\(Colors.green)The \(currentEnemy.name) has been defeated! You Won!!\(Colors.reset)")
        currentMaster = currentEnemy.defeatedDrop(master: currentMaster)
        currentMaster.servant_party[servant_address] = currentServant

        break
      } else {
        if shield_trigger || wrong_input {
          // Blocked, print already existed at Servant.shield(), then turn back to false!
          shield_trigger = false
          wrong_input = false // if wrong input like string or "" or [return], will block enemy's turn too, actually kind of similar to shield tho, but doesnt use MP
        } else {
          if let troll = currentEnemy as? Troll {
            troll.attack(servant: currentServant)
          } else if let golem = currentEnemy as? Golem {
            golem.attack(servant: currentServant)
          } else if let bandit = currentEnemy as? Bandit {
            currentMaster = bandit.banditSteal(master: currentMaster)
            bandit.attack(servant: currentServant)
          } else {
            print("\n--Wrong enemy input--")
          }
        }
      }
    }

    return currentMaster
  }

  // VERSUS SERVANTS -- NOBLE PHANTASM ENABLED
  func V_ersusWildServants(currentMaster: Master) -> Master {
    var currentMaster = currentMaster
    var servant_address: Int = -1
    var wrong_input: Bool = false
    
    while true {
      print("\nChoose a \(Colors.servantGold)Servant\(Colors.reset) to Deploy!\n\(Colors.red)Servants with no equipment can't use Noble Phantasm\(Colors.reset)")
      for (index, servant) in currentMaster.servant_party.enumerated() {
        print(
          "\(index + 1). \(servant.name) \(servant.rarity) ⭐ \(type(of: servant)) | HP \(servant.currHP)/\(servant.maxHP) | ATK \(servant.attack) | MP \(servant.currMP)/\(servant.maxMP) | NP \(servant.NP_gauge)%"
        )
        if servant.equipment {
          print("⚔️  Special Equipment : \(Colors.green)Equipped\(Colors.reset)")
        } else {
          print("⚔️  Special Equipment : \(Colors.red)None\(Colors.reset)")
        }
      }

      print("Choose : \(Colors.blue)Press [return] to go back\(Colors.reset)")
      let deploy = readLine()

      if let integerValue = Int(deploy!) {
        if integerValue >= 1 && integerValue <= currentMaster.servant_party.count {
          currentServant = currentMaster.servant_party[integerValue - 1]
          servant_address = integerValue - 1
          break
        } else {
          print("\nYour decision isn't clear, \(Colors.magenta)Master\(Colors.reset)")
        }
      } else if deploy == "" {
        return currentMaster
      } else {
        print("\nYour decision isn't clear, \(Colors.magenta)Master\(Colors.reset)")
      }
    }

    let gachaClass = Int.random(in:1...7)
    if gachaClass == 1 {
      enemyServant = Saber(name: "\(Colors.red)[Alter] Arthur Pendragon\(Colors.reset)", rarity: 3, equipment: true) // can ult
    } else if gachaClass == 2 {
      enemyServant = Archer(name: "\(Colors.red)[Alter] Arjuna\(Colors.reset)", rarity: 3, equipment: true)
    } else if gachaClass == 3 {
      enemyServant = Lancer(name: "\(Colors.red)[Alter] Leonidas\(Colors.reset)", rarity: 3, equipment: true)
    } else if gachaClass == 4 {
      enemyServant = Rider(name: "\(Colors.red)[Alter] Iskandar\(Colors.reset)", rarity: 3, equipment: true)
    } else if gachaClass == 5 {
      enemyServant = Caster(name: "\(Colors.red)[Alter] Merlin\(Colors.reset)", rarity: 3, equipment: true)
    } else if gachaClass == 6 {
      enemyServant = Assassin(name: "\(Colors.red)[Alter] Jack the Ripper\(Colors.reset)", rarity: 3, equipment: true)
    } else if gachaClass == 7 {
      enemyServant = Berserker(name: "\(Colors.red)[Alter] Heracles\(Colors.reset)", rarity: 3, equipment: false) // but not for Berserker
    } 

    while true {
      if currentServant.currHP <= 0 {
        print("\n\(Colors.red)\(currentServant.name) got defeated! You Lost the battle!\(Colors.reset)")
        print("\n\(Colors.red)\(currentServant.name) has been removed from your party! But you could summon him again!\(Colors.reset)")
        currentMaster.servant_party.remove(at: servant_address)

        break
      } else {
        print("\nYou encounter a Wild Servant!!!") // Always have equipment on true
        if enemyServant is Berserker { // when Berserker, can't ult
          print(
            "\n🥷 🔴\(enemyServant.name) \(enemyServant.rarity) ⭐ \(type(of: enemyServant)) | HP \(enemyServant.currHP)/\(currentServant.maxHP) | ATK \(enemyServant.attack) | \(Colors.red)NP LOCKED\(Colors.reset)"
          )
        } else {
          print(
            "\n🥷 🔴\(enemyServant.name) \(enemyServant.rarity) ⭐ \(type(of: enemyServant)) | HP \(enemyServant.currHP)/\(currentServant.maxHP) | ATK \(enemyServant.attack) | NP \(enemyServant.NP_gauge)%"
          )
        }
        

        if currentServant.equipment {
          print(
            "\n\n🥷 🟢\(currentServant.name) \(currentServant.rarity) ⭐ \(type(of: currentServant)) | HP \(currentServant.currHP)/\(currentServant.maxHP) | ATK \(currentServant.attack) | NP \(currentServant.NP_gauge)%"
          )
        } else { // If no equipment, can't ult
          print(
            "\n\n🥷 🟢\(currentServant.name) \(currentServant.rarity) ⭐ \(type(of: currentServant)) | HP \(currentServant.currHP)/\(currentServant.maxHP) | ATK \(currentServant.attack) | \(Colors.red)NP LOCKED\(Colors.reset)"
          )
        }
        
        // YOUR TURN ⚔️
        print(
          "\n\(Colors.blue)Choose your action : \(Colors.reset)"
        )
        if currentServant.NP_gauge >= 100 && currentServant.equipment {
          print("\n\(Colors.servantGold)0. Launch Noble Phantasm\(Colors.reset)")
        }
        print(
          "\n1. Deal Servant Skill\n2. Use Heal Potion\n3. Flee from battle\n\n\(Colors.blue)Your command, \(Colors.magenta)Master?\(Colors.reset)"
        )

        let action = readLine()

        if let integerValue = Int(action!) {
          if integerValue == 0 && currentServant.NP_gauge >= 100 && currentServant.equipment {
            currentServant.noblePhantasm(enemy: enemyServant)
          } else if integerValue == 1 {
            currentServant.attack(enemy: enemyServant)
          } else if integerValue == 2 {
              while true {
                if currentMaster.heal_potion > 0 {
                  print("You have \(currentMaster.heal_potion) Heal Potions")
                  print("\nAre you sure you want to use a heal potion? (Y/N)")

                  let heal = readLine()

                  if heal?.caseInsensitiveCompare("Y") == .orderedSame {
                    currentServant.useHealPotion()
                    currentMaster.minusHealPotion(amount: 1)
                  } else if heal?.caseInsensitiveCompare("N") == .orderedSame {
                    break
                  } else {
                    print("\n")
                  }
                } else {
                  print("\n\(Colors.red)You don't have any heal potions, \(Colors.magenta)Master\(Colors.reset)")
                  break
                }
              }
          } else if integerValue == 3 {
            print("\n\(Colors.red)What a coward, you flee from the battle\(Colors.reset)")
            currentMaster.servant_party[servant_address] = currentServant
            break
          } else {
            print("\nYour decision isn't clear, \(Colors.magenta)Master\(Colors.reset)")
            wrong_input = true
          }
        } else {
          print("\nYour decision isn't clear, \(Colors.magenta)Master\(Colors.reset)")
          wrong_input = true
        }
      }


      // WILD SERVANT TURN 😡
      if enemyServant.currHP <= 0 {
        print("\n\(Colors.green)The \(enemyServant.name) has been defeated! You Won!!\(Colors.reset)")
        currentMaster = enemyServant.defeatedDrop(master: currentMaster)

        break
      } else {
        if enemyServant.NP_gauge >= 100 && enemyServant.equipment {
          enemyServant.noblePhantasm(enemy: currentServant)
        } else if wrong_input {
          // if wrong input like string or "" or [return], will block enemy's turn too
          wrong_input = false
        } else {
          enemyServant.attack(enemy: currentServant)
        }
      }
    }

    return currentMaster
  }

  func Codex() {
    while true {
      print(
        "\nEach class of \(Colors.servantGold)Servants\(Colors.reset) has their own unique capabilities in battlefield. When they're equipped with their own unique \(Colors.servantGold)equipment\(Colors.reset), they gain the ability to do ultimate move or \(Colors.servantGold)Noble Phantasm (NP)\(Colors.reset)."
      )

      print(
        "\n🛡️ Shielder : Neutral, has passive healing 10% of HP every turn, NOT summonable, \(Colors.red)NO NP, No Equipment\(Colors.reset)"
      )
      print(
        "\n⚔️ Saber : strong against Lancer (1.5x damage), \(Colors.servantGold)NP : Increase attack stat permanently (even after battle) by 50%\(Colors.reset)"
      )
      print(
        "\n🏹 Archer : strong against Saber (1.5x damage), \(Colors.servantGold)NP : Deal attack with 5x damage\(Colors.reset)"
      )
      print(
        "\n🗡️ Lancer : strong against Archer (1.5x damage), \(Colors.servantGold)NP : Heals 70% HP and deal 2.5x damage!\(Colors.reset)"
      )
      print(
        "\n🏇 Rider : strong against Caster (1.5x damage), \(Colors.servantGold)NP : Heal 100% HP\(Colors.reset)"
      )
      print(
        "\n🧙 Caster : strong against Assassin (1.5x damage), \(Colors.servantGold)NP : Heals 50% HP and deal 3.0x damage\(Colors.reset)"
      )
      print(
        "\n🔪 Assassin : strong against Rider (1.5x damage), \(Colors.servantGold)NP : 50% chance to instant kill enemy\(Colors.reset)"
      )
      print(
        "\n👹 Berserker : strong against anyone, except Shielder (2x damage), \(Colors.red)NO NP, No Equipment\(Colors.reset)"
      )

      print(
        "\n\(Colors.servantGold)Noble Phantasm\(Colors.reset) can be used when Equipment is equipped && 100% NP gauge"
      )
      print(
        "\n\(Colors.red)The above Servant interactions, skills, and Noble Phantasm action are only available for [V]ersus Wild Servants\(Colors.reset)"
      )
      print(
        "\n\(Colors.blue)While in monster battle, servants can only perform : \(Colors.reset)\n1. Physical attack, no MP required, deal 100 damage\n2. Meteor, use 15 MP, deal 250 damage\n3. Shield, use 10 MP, block enemy's attack for 1 turn"
      )
      print("\(Colors.blue)Press [return] to go back\(Colors.reset)")
      let codex_return = readLine()

      if codex_return == "" {
        break
      } else {
        print("\n")
      }
    }
  }
}

struct Colors {
  static let bold = "\u{001B}[1m"
  static let underline = "\u{001B}[4m"

  static let reset = "\u{001B}[0;0m"
  static let black = "\u{001B}[0;30m"
  static let red = "\u{001B}[0;31m"
  static let green = "\u{001B}[0;32m"
  static let yellow = "\u{001B}[0;33m"
  static let blue = "\u{001B}[0;34m"
  static let magenta = "\u{001B}[0;35m"
  static let cyan = "\u{001B}[0;36m"
  static let white = "\u{001B}[0;37m"

  static let backgroundBlack = "\u{001B}[40m"
  static let backgroundRed = "\u{001B}[41m"
  static let backgroundGreen = "\u{001B}[42m"
  static let backgroundYellow = "\u{001B}[43m"
  static let backgroundBlue = "\u{001B}[44m"
  static let backgroundMagenta = "\u{001B}[45m"
  static let backgroundCyan = "\u{001B}[46m"
  static let backgroundWhite = "\u{001B}[47m"

  static let servantGold = "\u{001B}[38;5;220m"
  static let backgroundGold = "\u{001B}[48;5;220m"
}
