//: [Previous](@previous)
//: ### Raw Values
//: - Callout(Exercise):
//: What's the raw value for `SecretLetters.g`?
//:
enum SecretLetters: Int {
    case a, b = 6, c, d, e, f = 2, g
}
3
//: - Callout(Exercise):
//: Define an enum called `Rotation` with cases for `quarter`, `half`, `threeQuarter`, and `full` rotations. Each case should specify a raw value that represents the number of degrees for the rotation. For example, an eighth (1/8 * 360) turn would be 45 degrees.
//:
enum Rotation: Float{
    case quater = 90, half = 180, threeQuater = 270 , full = 360
    
}
//: [Next](@next)
