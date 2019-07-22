import Foundation

protocol DiscriminantStrategy
{
  func calculateDiscriminant(_ a: Double, _ b: Double, _ c: Double) -> Double
}

class OrdinaryDiscriminantStrategy : DiscriminantStrategy
{
  func calculateDiscriminant(_ a: Double, _ b: Double, _ c: Double) -> Double {
    return b*b - 4*a*c
  }
}

class RealDiscriminantStrategy : DiscriminantStrategy
{
  func calculateDiscriminant(_ a: Double, _ b: Double, _ c: Double) -> Double {
    let discriminant = b*b - 4*a*c
    return discriminant >= 0 ? discriminant : Double.nan
  }
}

class QuadraticEquationSolver
{
  private let strategy: DiscriminantStrategy
  
  init(_ strategy: DiscriminantStrategy)
  {
    self.strategy = strategy
  }
  
  func solve(_ a: Double, _ b: Double, _ c: Double) -> (Double, Double)
  {
    let firstResult = (-b + pow(strategy.calculateDiscriminant(a, b, c), 0.5))/2*a
    let secondResult = (-b - pow(strategy.calculateDiscriminant(a, b, c), 0.5))/2*a
    return (firstResult, secondResult)
  }
}
