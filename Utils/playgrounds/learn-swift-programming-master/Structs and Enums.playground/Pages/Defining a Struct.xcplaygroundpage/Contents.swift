//: ## Defining a Struct
//: To define a struct in Swift, the following syntax can be used:
//:
//:     struct NameOfStruct {
//:         // variables declarations (known as properties)...
//:     }
struct Student {
    let name: String
    var age: Int
    var school: String
}

struct GeoLocation {
    var latitude: Double = 0.0
    var longitude: Double = 0.0
}

struct Point2D {
    var x: Int = 0
    var y: Int = 0
}
//: [Next](@next)

var ayush = Student(name: "Ayush Saraswat", age: 19, school: "Udacity")


ayush.age = 20
// Simply fill in the empty \()s with ayush's information. Do not modify the sentence
print("\(ayush.name) is \(ayush.age) years old and attends \(ayush.school).")


struct Product{
    let name: String
    var price: Double
    
    mutating func discount(){
        price -= price*0.1
    }
    
    var formattedPrice:String {
        return "$\(price)"
    }
}

var prod1 = Product(name: "Test Product", price: 180)

print(prod1)
prod1.discount()
print(prod1.price)
print(prod1.formattedPrice)
