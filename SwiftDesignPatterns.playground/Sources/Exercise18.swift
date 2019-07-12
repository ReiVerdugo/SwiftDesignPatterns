protocol Log
{
  var recordLimit: Int { get }
  var recordCount: Int { get set }
  func logInfo(_ message: String)
}

enum LogError : Error
{
  case recordNotUpdated
  case logSpaceExceeded
}

class Account
{
  private var log: Log
  
  init(_ log: Log)
  {
    self.log = log
  }
  
  func someOperation() throws
  {
    let c = log.recordCount
    log.logInfo("Performing an operation")
    if (c+1) != log.recordCount
    {
      throw LogError.recordNotUpdated
    }
    if log.recordCount >= log.recordLimit
    {
      throw LogError.logSpaceExceeded
    }
  }
}

class NullLog : Log
{
  let recordLimit = Int.max
  var recordCount = 0
  func logInfo(_ message: String) {
    recordCount += 1
  }
}
