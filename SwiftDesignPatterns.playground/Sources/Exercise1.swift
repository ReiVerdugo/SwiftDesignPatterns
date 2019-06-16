// Exercise 1: Builder Coding Exercise
import Foundation

public class CodeBuilder : CustomStringConvertible
{
  var rootName = ""
  var fields: [String: String] = [:]
  
  public init(_ rootName: String)
  {
    self.rootName = "class \(rootName)"
  }
  
  public func addField(called name: String, ofType type: String) -> CodeBuilder
  {
    fields[name] = type
    return self
  }
  
  public var description: String
  {
    var classDescription = "\(rootName)\n{\n"
    for (name, type) in fields {
      classDescription += "  var \(name): \(type)\n"
    }
    classDescription += "}"
    return classDescription
  }
}
