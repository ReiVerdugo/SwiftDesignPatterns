class Bird
{
  var age = 0
  
  func fly() -> String
  {
    return (age < 10) ? "flying" : "too old"
  }
}

class Lizard
{
  var age = 0
  
  func crawl() -> String
  {
    return (age > 1) ? "crawling" : "too young"
  }
}

public class Dragon
{
  // todo: reuse bird/lizard functionality here
  private let bird = Bird()
  private let lizard = Lizard()
  
  public init(){}
  
  public var age = 0 {
    didSet {
      bird.age = age
      lizard.age = age
    }
  }
  public func fly() -> String {
    return bird.fly()
  }
  
  public func crawl() -> String {
    return lizard.crawl()
  }
}
