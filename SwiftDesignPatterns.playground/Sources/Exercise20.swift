import Foundation

class CombinationLock
{
  var status = ""
  private let combination: [Int]
  var currentCombination: [Int] = []
  
  enum Status: String {
    case LOCKED
    case OPEN
    case ERROR
  }
  
  init(_ combination: [Int])
  {
    self.combination = combination
    status = Status.LOCKED.rawValue
  }
  
  private func isCorrectCombination() -> Bool {
    var index = 0
    while index < currentCombination.count {
      if currentCombination[index] != combination[index] {
        return false
      }
      index += 1
    }
    return true
  }
  
  func enterDigit(_ digit: Int)
  {
    currentCombination.append(digit)
    if currentCombination == combination {
      status = Status.OPEN.rawValue
      return
    } else if isCorrectCombination() {
      if status == Status.LOCKED.rawValue {
        status = ""
      }
      status += "\(digit)"
    } else {
      status = Status.ERROR.rawValue
    }
  }
}
