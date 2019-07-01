// CQS

public class Creature
{
  var name: String
  private var _attack: Int
  private var _defense: Int
  private let game: Game
  
  public var attack: Int {
    get {
      var attackPoints = _attack
      if game.containsGoblinKing()
        && isGoblin()
        && !isGoblinKing() {
        attackPoints += 1
      }
      return attackPoints
    }
  }
  
  public var defense: Int {
    if isGoblin() {
      let numberOfGoblins = game.numberOfGoblinsInPlay()
      return _defense + numberOfGoblins - 1 // Remove one from self
    }
    return _defense
  }
  
  init(game: Game, name: String, attack: Int, defense: Int) {
    self.game = game
    self.name = name
    _attack = attack
    _defense = defense
  }
  
  func isGoblin() -> Bool {
    return name.contains("Goblin")
  }
  
  func isGoblinKing() -> Bool {
    return name == "Goblin King"
  }
}

public class Goblin : Creature
{
  public init(game: Game)
  {
    super.init(game: game, name: "Goblin", attack: 1, defense: 1)
  }
  
  override init(game: Game, name: String, attack: Int, defense: Int) {
    super.init(game: game, name: "Goblin", attack: attack, defense: defense)
  }
  
  override func isGoblin() -> Bool {
    return true
  }
}

public class GoblinKing : Goblin
{
  public override init(game: Game)
  {
    super.init(game: game, name: "Goblin King", attack: 3, defense: 3)
  }
  
  override func isGoblinKing() -> Bool {
    return true
  }
}

public class Game
{
  public var creatures = [Creature]()
  
  public init(){}
  
  func containsGoblinKing() -> Bool {
    return creatures.contains { $0.isGoblinKing() }
  }
  
  func numberOfGoblinsInPlay() -> Int {
    var numberOfGoblins = 0
    for creature in creatures {
      if creature.isGoblin() {
        numberOfGoblins += 1
      }
    }
    return numberOfGoblins
  }
}
