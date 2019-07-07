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
    let lexer = Lexer()
    let tokens = lexer.lex(expression)
    
    let parser = Parser(variables)
    
    let result = parser.parse(tokens)
    return result.value
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

struct Integer: Element {
  var value: Int
  init(_ value: Int) {
    self.value = value
  }
}

struct BinaryOperation: Element {
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
      return left.value + right.value
    case .subtraction:
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
    var result = BinaryOperation()
    var haveLHS = false
    var haveOperator = false
    var i = 0
    while i < tokens.count {
      let token = tokens[i]
      switch token.tokenType {
      case .integer, .variable:
        let integer: Integer
        if token.tokenType == .variable {
          guard token.text.count == 1,
            let character = token.text.first,
            let valueOfVariable = variables[character] else {
              return Integer(0)
          }
          integer = Integer(valueOfVariable)
        } else {
          integer = Integer(Int(token.text)!)
        }
        
        if !haveLHS {
          result.left = integer
          haveLHS = true

        } else {
          result.right = integer
        }
      case .plus:
        if haveOperator {
          result.left = result
        }
        result.opType = .addition
        haveOperator = true
        
      case .minus:
        if haveOperator {
          result.left = result
        }
        result.opType = .subtraction
        haveOperator = true
      }
      i += 1
    }
    return result
  }
}
