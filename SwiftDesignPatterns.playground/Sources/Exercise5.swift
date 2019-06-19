class Square
{
  var side = 0
  
  init(side: Int)
  {
    self.side = side
  }
}

protocol Rectangle
{
  var width: Int { get }
  var height: Int { get }
}

extension Rectangle
{
  var area: Int
  {
    return self.width * self.height
  }
}

class SquareToRectangleAdapter : Rectangle
{
  let width: Int
  let height: Int
  
  init(_ square: Square)
  {
    width = square.side
    height = square.side
  }
}
