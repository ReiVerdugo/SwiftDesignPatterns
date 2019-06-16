import UIKit

let point = Point(x: 5, y: 7)
let point2 = point.deepCopy()

point2.x = 6
print(point)
print (point2)
