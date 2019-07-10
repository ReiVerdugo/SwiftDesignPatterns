import Foundation

class Participant
{
  private let mediator: Mediator
  var value = 0
  
  init(_ mediator: Mediator)
  {
    self.mediator = mediator
    mediator.participants.append(self)
  }
  
  func say(_ n: Int)
  {
    mediator.broadcast(sender: self, value: n)
  }
  
  func receive(value: Int) {
    self.value = value
  }
}

class Mediator
{
  var participants: [Participant] = []
  
  func broadcast(sender: Participant, value: Int) {
    for participant in participants {
      if participant !== sender {
        participant.receive(value: value)
      }
    }
  }
}
