import Foundation

extension String {
  
  public subscript(x: Int) -> Character {
    return self[index(startIndex, offsetBy: x)]
  }
  
  var isNumber: Bool {
    get {
      return !self.isEmpty
        && self.rangeOfCharacter(from: CharacterSet.decimalDigits.inverted) == nil
    }
  }
  
  var isLetter: Bool {
    get {
      return !self.isEmpty
        && self.rangeOfCharacter(from: CharacterSet.letters) != nil
    }
  }
}

class ExpressionProcessor
{
  var variables = [Character:Int]()
  
  func calculate(_ expression: String) -> Int
  {
    return 0
  }
}

public struct Token: CustomStringConvertible {
  
  enum TokenType {
    case integer
    case plus
    case minus
    case variable
  }
  
  var tokenType: TokenType
  var text: String
  
  init(tokenType: TokenType, text: String) {
    self.tokenType = tokenType
    self.text = text
  }
  
  public var description: String {
    return text
  }
}

public class Lexer {
  public init() {}
  
  public func lex(_ input: String) -> [Token] {
    var result: [Token] = []
    
    var i = 0
    while i < input.count {
      switch input[i] {
      case "+":
        result.append(Token(tokenType: .plus, text: "+"))
      case "-":
        result.append(Token(tokenType: .minus, text: "-"))
      default:
        var s = String(input[i])
        // Found integer
        if s.isNumber {
          var reachedEnd = false
          for j in (i+1)..<input.count {
            if String(input[j]).isNumber {
              s.append(input[j])
              i += 1
              
            } else {
              result.append(Token(tokenType: .integer, text: s))
              reachedEnd = true
              break
            }
          }
          if !reachedEnd {
            result.append(Token(tokenType: .integer, text: s))
          }
        // Found variable
        } else if s.isLetter {
          var reachedEnd = false
          for j in (i+1)..<input.count {
            if String(input[j]).isLetter {
              s.append(input[j])
              i += 1
              
            } else {
              result.append(Token(tokenType: .variable, text: s))
              reachedEnd = true
              break
            }
          }
          if !reachedEnd {
             result.append(Token(tokenType: .variable, text: s))
          }
        }
      }
      i += 1
    }
    
    return result
  }
}

public protocol Element {
  var value: Int { get }
}

class Integer: Element {
  var value: Int
  init(_ value: Int) {
    self.value = value
  }
}

class BinaryOperation: Element {
  enum OpType {
    case addition
    case subtraction
  }
  
  var opType = OpType.addition
  var left: Element = Integer(0)
  var right: Element = Integer(0)
  
  init(){}
  init(opType: OpType, left: Element, right: Element) {
    self.opType = opType
    self.left = left
    self.right = right
  }
  
  var value: Int {
    switch opType {
    case .addition:
      print("Adding \(left.value) + \(right.value)")
      return left.value + right.value
    case .subtraction:
      print("Subtracting \(left.value) - \(right.value)")
      return left.value - right.value
    }
  }
}

public class Parser {
  private var variables: [Character:Int] = [:]
  
  public init (_ variables: [Character: Int]) {
    self.variables = variables
  }
  public func parse(_ tokens: [Token]) -> Element {
    let result = BinaryOperation()
    var haveLHS = false
    
    var i = 0
    while i < tokens.count {
      let token = tokens[i]
      switch token.tokenType {
      case .integer, .variable:
        let integer: Integer
        if token.tokenType == .variable {
          if token.text.count == 1 {
            let character = token.text[0]
            let valueOfVariable = variables[character] ?? 0
            integer = Integer(valueOfVariable)
          } else {
            integer = Integer(0)
          }
        } else {
          integer = Integer(Int(token.text)!)
        }
        
        if !haveLHS {
          print("Adding left element \(integer.value)")
          result.left = integer
          haveLHS = true

        } else {
          if i + 1 == tokens.count {
            print("Adding right element \(integer.value)")
            result.right = integer
            return result
            
          } else {
            // Process subexpression
            let subexpression = tokens[i..<tokens.count]
            let element = parse(Array(subexpression))
            print("Adding right element \(element.value)")
            result.right = element
            return result
          }
          
        }
      case .plus:
        result.opType = .addition
        
      case .minus:
        result.opType = .subtraction
      }
      i += 1
    }
    return result
  }
}
