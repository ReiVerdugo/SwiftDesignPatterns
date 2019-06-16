protocol Copying {
  func deepCopy() -> Self
}

public class Point: Copying, CustomStringConvertible
{
  public var x = 0
  public var y = 0
  
  init() {}
  
  public init(x: Int, y: Int)
  {
    self.x = x
    self.y = y
  }
  
  public func deepCopy() -> Self {
    return deepCopyImpl()
  }
  
  private func deepCopyImpl<T>() -> T {
    return Point(x: x, y: y) as! T
  }
  
  public var description: String {
    return "x: \(x), y: \(y)"
  }
}

class Line: Copying
{
  var start = Point()
  var end = Point()
  
  public init(start: Point, end: Point)
  {
    self.start = start
    self.end = end
  }
  
  public func deepCopy() -> Self
  {
    return deepCopyImpl()
  }
  
  private func deepCopyImpl<T>() -> T {
    let startCopy = start.deepCopy()
    let endCopy = end.deepCopy()
    return Line(start: startCopy, end: endCopy) as! T
  }
}

