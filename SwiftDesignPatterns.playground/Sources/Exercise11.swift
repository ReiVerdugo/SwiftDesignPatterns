class Persona
{
  var age: Int = 0
  
  func drink() -> String
  {
    return "drinking"
  }
  
  func drive() -> String
  {
    return "driving"
  }
  
  func drinkAndDrive() -> String
  {
    return "driving while drunk"
  }
}

class ResponsiblePerson
{
  private let person: Persona
  var age: Int {
    get {
      return person.age
    }
    set (value) {
      person.age = value
    }
  }
  init(person: Persona)
  {
    self.person = person
  }
  
  func drink() -> String
  {
    if person.age < 18 {
      return "too young"
    }
    return person.drink()
  }
  
  func drive() -> String
  {
    if person.age < 16 {
      return "too young"
    }
    return person.drive()
  }
  
  func drinkAndDrive() -> String
  {
    return "dead"
  }
}
