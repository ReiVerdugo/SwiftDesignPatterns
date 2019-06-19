class SingletonTester
{
  static func isSingleton(factory: () -> AnyObject) -> Bool
  {
    let firstObject = factory()
    let secondObject = factory()
    return firstObject === secondObject
  }
}
