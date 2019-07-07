public class Node<T>
{
  let value: T
  var left: Node<T>? = nil
  var right: Node<T>? = nil
  var parent: Node<T>? = nil
  
  public init(_ value: T)
  {
    self.value = value
  }
  
  public init(_ value: T, _ left: Node<T>, _ right: Node<T>)
  {
    self.value = value
    self.left = left
    self.right = right
    
    right.parent = self
    left.parent = self
  }
  
  private func preOrder(current: Node<T>, values: inout [T]) {
    values.append(current.value)
    if let currentLeft = current.left {
      preOrder(current: currentLeft, values: &values)
    }
    if let currentRight = current.right {
      preOrder(current: currentRight, values: &values)
    }
  }
  
  public var preOrder: [T]
  {
    var values: [T] = []
    preOrder(current: self, values: &values)
    return values
  }
}
