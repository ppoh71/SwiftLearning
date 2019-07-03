//: ## Strings
//: You've seen strings passed in to print statements
print("Hello, world!")

//: You've seen strings defined as variables and as constants
var myFavoriteAnimal = "nudibranch"
let encouragement = "You can do it!"
//: [Next](@next)


func remove(input: String, first: Int, last: Int) -> String {
    // we require a variable to manipulate strings
    var newString = input
    // modify newString and return the result
    
    if(first+last<input.count){
        var i = 0
        while i<first{
            newString.removeFirst()
            i += 1
        }
        
        var k = 0
        while k<last{
            newString.removeLast()
            k += 1
        }
    }
    
    return newString
    
}

remove(input: "This is a long sting or longer", first: 3, last: 0)
