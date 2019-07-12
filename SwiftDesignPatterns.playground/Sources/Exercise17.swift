import Foundation
import XCTest

class Token
{
  var value = 0
  init(_ value: Int)
  {
    self.value = value
  }
  // todo: any extra members you need
  
  // please keep this operator! it will be
  // used for testing!
  static func ==(_ lhs: Token, _ rhs: Token) -> Bool
  {
    return lhs.value == rhs.value
  }
  
  static func copyFromToken(_ token: Token) -> Token {
    return Token(token.value)
  }
}

class Memento
{
  var tokens = [Token]()
}

class TokenMachine
{
  var tokens = [Token]()
  
  func addToken(_ value: Int) -> Memento
  {
    let token = Token(value)
    return addToken(token)
  }
  
  func addToken(_ token: Token) -> Memento
  {
    tokens.append(token)
    let memento = Memento()
    
    memento.tokens = tokens.map { Token.copyFromToken($0) }
    return memento
  }
  
  func revert(to m: Memento)
  {
    tokens = m.tokens.map { Token.copyFromToken($0) }
  }
}
