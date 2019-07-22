class Creature
{
  public var attack, health: Int
  
  init(_ attack: Int, _ health: Int)
  {
    self.attack = attack
    self.health = health
  }
}

class CardGame
{
  var creatures: [Creature]
  
  init(_ creatures: [Creature])
  {
    self.creatures = creatures
  }
  
  // the arguments creature1 and creature2 are indices in the 'creatures array'
  //
  // method returns the index of the creature that won the fight
  // returns -1 if there is no clear winner (both alive or both dead)
  func combat(_ creature1: Int, _ creature2: Int) -> Int
  {
    hit(creatures[creature1], creatures[creature2])
    hit(creatures[creature2], creatures[creature1])
    
    if (creatures[creature1].health > 0 && creatures[creature2].health > 0) ||
      (creatures[creature1].health <= 0 && creatures[creature2].health <= 0) {
      return -1
    } else if creatures[creature1].health > 0 {
      return creature1
    } else if creatures[creature2].health > 0 {
      return creature2
    }
    return -1
  }
  
  internal func hit(_ attacker: Creature, _ other: Creature)
  {
    precondition(false, "this method needs to be overridden")
  }
}

class TemporaryCardDamageGame : CardGame
{
  override func hit(_ attacker: Creature, _ other: Creature)
  {
    if (other.health - attacker.attack) <= 0 {
      other.health -= attacker.attack
    }
  }
}

class PermanentCardDamage : CardGame
{
  override func hit(_ attacker: Creature, _ other: Creature)
  {
    other.health -= attacker.attack
  }
}
