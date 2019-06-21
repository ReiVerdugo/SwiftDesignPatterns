import Foundation

class SingleValue : Sequence
{
  var value = 0
  
  init() {}
  init(_ value: Int)
  {
    self.value = value
  }
  
  func makeIterator() -> IndexingIterator<Array<Int>>
  {
    return IndexingIterator(_elements: [value])
  }
}

class ManyValues : Sequence
{
  var values = [Int]()
  
  func makeIterator() -> IndexingIterator<Array<Int>>
  {
    return IndexingIterator(_elements: values)
  }
  
  func add(_ value: Int)
  {
    values.append(value)
  }
}

extension Sequence where Iterator.Element: Sequence, Iterator.Element.Iterator.Element == Int
{
  func sum() -> Int
  {
    var sum = 0
    for element in self {
      sum += element.reduce(0, +)
    }
    return sum
  }
}

