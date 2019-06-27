import Foundation

public class Sentence : CustomStringConvertible
{
  var text: String
  var tokens: Set<WordToken> = []
  public init(_ plainText: String)
  {
    text = plainText
  }
  
  public subscript(index: Int) -> WordToken
  {
    let wordToken = WordToken(index: index)
    tokens.insert(wordToken)
    return wordToken
  }
  
  public var description: String
  {
    var buffer = ""
    let words = text.components(separatedBy: " ")
    for (index, word) in words.enumerated() {
      for token in tokens {
        if token.index == index && token.capitalize {
          buffer += word.uppercased()
        } else {
          buffer += word
        }
      }
      buffer += " "
    }
    return String(buffer.dropLast())
  }
  
  public class WordToken: Hashable
  {
    public static func == (lhs: Sentence.WordToken, rhs: Sentence.WordToken) -> Bool {
      return lhs.index == rhs.index
    }
    
    public var capitalize: Bool = false
    let index: Int
    
    public func hash(into hasher: inout Hasher) {
      hasher.combine(index)
    }
    
    public init(index: Int) {
      self.index = index
    }
  }
}
