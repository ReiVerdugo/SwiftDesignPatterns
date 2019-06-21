import Foundation

class Generator
{
  func generate(_ count: Int) -> [Int]
  {
    var result = [Int]()
    for _ in 1...count
    {
      result.append(Int.random(in: 1..<10))
    }
    return result
  }
}

class Splitter
{
  func split(_ array: [[Int]]) -> [[Int]]
  {
    var result = [[Int]]()
    
    let rowCount = array.count
    let colCount = array[0].count
    
    // get the rows
    for r in 0..<rowCount
    {
      var theRow = [Int]()
      for c in 0..<colCount
      {
        theRow.append(array[r][c])
      }
      result.append(theRow)
    }
    
    // get the columns
    for c in 0..<colCount
    {
      var theCol = [Int]()
      for r in 0..<rowCount
      {
        theCol.append(array[r][c])
      }
      result.append(theCol)
    }
    
    // get the diagonals
    var diag1 = [Int]()
    var diag2 = [Int]()
    for c in 0..<colCount
    {
      for r in 0..<rowCount
      {
        if c == r
        {
          diag1.append(array[r][c])
        }
        let r2 = rowCount - r - 1
        if c == r2
        {
          diag2.append(array[r][c])
        }
      }
    }
    
    result.append(diag1)
    result.append(diag2)
    
    return result
  }
}

class Verifier
{
  func verify(_ arrays: [[Int]]) -> Bool
  {
    let first = arrays[0].reduce(0, +)
    for arr in 1..<arrays.count
    {
      if (arrays[arr].reduce(0, +)) != first
      {
        return false
      }
    }
    return true
  }
}

public class MagicSquareGenerator
{
  public init() {}
  public func generate(_ size: Int) -> [[Int]]
  {
    var isNotMagic = true
    let generator = Generator()
    let splitter = Splitter()
    let verifier = Verifier()
    var square: [[Int]] = []
    while isNotMagic {
      for _ in 0..<size {
        square.append(generator.generate(size))
      }
      print(square)
      let splits = splitter.split(square)
      isNotMagic = !verifier.verify(splits)
      print("*******")
      square = []
    }
    return square
  }
}
