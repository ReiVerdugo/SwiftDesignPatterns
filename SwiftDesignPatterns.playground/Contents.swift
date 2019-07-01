import UIKit

//let point = Point(x: 5, y: 7)
//let point2 = point.deepCopy()
//
//point2.x = 6
//print(point)
//print (point2)

//let dragon = Dragon()
//dragon.age = 11
//print(dragon.fly())

//let square = MagicSquareGenerator().generate(3)

//let s = Sentence("alpha beta gamma")
//s[1].capitalize = true
//print(s)

let game = Game()
let goblin = Goblin(game: game)
game.creatures.append(goblin)

let goblin2 = Goblin(game: game)
game.creatures.append(goblin2)

print(goblin.attack)
print(goblin.defense)

let goblin3 = GoblinKing(game: game)
game.creatures.append(goblin3)
print(goblin3.attack)
print(goblin3.defense)
