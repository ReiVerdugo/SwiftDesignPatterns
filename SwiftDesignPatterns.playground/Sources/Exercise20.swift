import Foundation

public class CombinationLock
{
  var status = ""
  var failed = false
  private let combination: [Int]
  var digitsEntered = 0
  
  enum Status: String {
    case LOCKED
    case OPEN
    case ERROR
  }
  
  public init(_ combination: [Int])
  {
    self.combination = combination
    status = Status.LOCKED.rawValue
  }
  
  public func enterDigit(_ digit: Int)
  {
    if status == Status.LOCKED.rawValue {
      status = ""
    }
    status += "\(digit)"
    
    if combination[digitsEntered] != digit {
      failed = true
    }
    digitsEntered += 1
    if digitsEntered == combination.count {
      status = failed ? Status.ERROR.rawValue : Status.OPEN.rawValue
    }
    print(status)
  }
}
