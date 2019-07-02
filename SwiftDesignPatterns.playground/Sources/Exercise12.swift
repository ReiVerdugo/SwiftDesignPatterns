// CQS

enum Stats {
  case attack
  case defense
}

class Query {
  let stats: Stats
  var result = 0
  
  init(stats: Stats) {
    self.stats = stats
  }
}

public class Creature
{
  var name: String
  let _attack: Int
  let _defense: Int
  let game: Game
  
  public var attack: Int {
    return _attack
  }
  
  public var defense: Int {
    return _defense
  }
  
  init(game: Game, name: String, attack: Int, defense: Int) {
    self.game = game
    self.name = name
    _attack = attack
    _defense = defense
  }
  
  func query(_ query: Query,source: Creature, stat: Stats) {}
}

public class Goblin : Creature
{
  override public var attack: Int {
    let query = Query(stats: .attack)
    for creature in game.creatures {
      creature.query(query, source: self, stat: .attack)
    }
    return query.result
  }
  
  override public var defense: Int {
    let query = Query(stats: .defense)
    for creature in game.creatures {
      creature.query(query, source: self, stat: .defense)
    }
    return query.result
  }
  
  public convenience init(game: Game)
  {
    self.init(game: game, name: "Goblin", attack: 1, defense: 1)
  }
  
  public override init(game: Game, name: String, attack: Int, defense: Int) {
    super.init(game: game, name: "Goblin", attack: attack, defense: defense)
  }
  
  override func query(_ query: Query, source: Creature, stat: Stats) {
    if source === self {
      switch stat {
      case .attack:
        query.result += _attack
      case .defense:
        query.result += _defense
      }
    } else if let _ = source as? Goblin,
      stat == .defense {
      query.result += 1
    }
  }
}

public class GoblinKing : Goblin
{
  public init(game: Game)
  {
    super.init(game: game, name: "Goblin King", attack: 3, defense: 3)
  }
  
  override func query(_ query: Query, source: Creature, stat: Stats) {
    if source !== self,
      let _ = source as? Goblin,
      stat == .attack {
      query.result += 3
    } else {
      super.query(query, source: source, stat: stat)
    }
  }
}

public class Game
{
  public var creatures = [Creature]()
  
  public init(){}
}
