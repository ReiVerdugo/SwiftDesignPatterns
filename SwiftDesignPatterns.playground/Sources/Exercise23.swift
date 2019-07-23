protocol ExpressionVisitor
{
  func accept(_ value: Value)
  func accept(_ addition: AdditionExpression)
  func accept(_ multiplication: MultiplicationExpression)
}

protocol Expression
{
  func visit(_ ev: ExpressionVisitor)
}

class Value : Expression
{
  let value: Int
  init(_ value: Int)
  {
    self.value = value
  }
  func visit(_ ev: ExpressionVisitor)
  {
    ev.accept(self)
  }
}

class AdditionExpression : Expression
{
  let lhs, rhs: Expression
  init(_ lhs: Expression, _ rhs: Expression)
  {
    self.lhs = lhs
    self.rhs = rhs
  }
  func visit(_ ev: ExpressionVisitor)
  {
    ev.accept(self)
  }
}

class MultiplicationExpression : Expression
{
  let lhs, rhs: Expression
  init(_ lhs: Expression, _ rhs: Expression)
  {
    self.lhs = lhs
    self.rhs = rhs
  }
  func visit(_ ev: ExpressionVisitor)
  {
    ev.accept(self)
  }
}

class ExpressionPrinter :
  ExpressionVisitor, CustomStringConvertible
{
  var buffer = ""
  
  func accept(_ value: Value) {
    buffer += "\(value.value)"
  }
  
  func accept(_ addition: AdditionExpression) {
    buffer += "("
    addition.lhs.visit(self)
    buffer += "+"
    addition.rhs.visit(self)
    buffer += ")"
  }
  
  func accept(_ multiplication: MultiplicationExpression) {
    multiplication.lhs.visit(self)
    buffer += "*"
    multiplication.rhs.visit(self)
  }
  
  var description: String
  {
    return buffer
  }
}
