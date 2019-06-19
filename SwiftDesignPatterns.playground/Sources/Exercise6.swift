protocol Renderer {
  var whatToRenderAs: String { get }
}

class Shape: CustomStringConvertible
{
  var name = ""
  let renderer: Renderer
  init(_ renderer: Renderer) {
    self.renderer = renderer
  }
  
  var description: String {
    return "Drawing \(name) as \(renderer.whatToRenderAs)"
  }
}

class Triangle : Shape
{
  override init(_ renderer: Renderer)
  {
    super.init(renderer)
    name = "Triangle"
  }
}

class Square: Shape
{
  override init(_ renderer: Renderer)
  {
    super.init(renderer)
    name = "Square"
  }
}

class VectorRenderer : Renderer
{
  let whatToRenderAs = "lines"
}

class RasterRenderer : Renderer
{
  let whatToRenderAs = "pixels"
}
