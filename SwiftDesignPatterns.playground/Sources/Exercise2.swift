import Foundation

public class Person
{
  var id: Int
  var name: String
  
  init(called name: String, withId id: Int)
  {
    self.name = name
    self.id = id
  }
}

class PersonFactory
{
  var id: Int = 0
  public func createPerson(name: String) -> Person
  {
    let person = Person(called: name, withId: id)
    id += 1
    return person
  }
}
