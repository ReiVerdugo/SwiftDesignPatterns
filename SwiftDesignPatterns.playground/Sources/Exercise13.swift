class Command
{
  enum Action
  {
    case deposit
    case withdraw
  }
  
  var action: Action
  var amount: Int
  var success = false
  
  init(_ action: Action, _ amount: Int)
  {
    self.action = action
    self.amount = amount
  }
}

class Account
{
  var balance = 0
  
  func deposit(amount: Int) {
    balance += amount
  }
  
  func withdraw(amount: Int) -> Bool {
    if balance - amount >= 0 {
      balance -= amount
      return true
    }
    return false
  }
  
  func process(_ c: Command)
  {
    switch c.action {
    case .deposit:
      deposit(amount: c.amount)
      c.success = true
    case .withdraw:
      c.success = withdraw(amount: c.amount)
    }
  }
}
