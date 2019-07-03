//: [Previous](@previous)
//: ## Exercise: The Club
//: Uncomment the following sets of constants to check your if statements. When you have the correct output, paste your code into the text box in the lesson to see a sample solution.
/*
 var name = "Ayush"
 var age = 19
 var onGuestList = true
 var knowsTheOwner = true
*/
/*
 var name = "Gabrielle"
 var age = 29
 var onGuestList = true
 var knowsTheOwner = true
*/

var name = "Chris"
var age = 12
var onGuestList = true
var knowsTheOwner = true
//: Your code goes here


if( (onGuestList && age>=21) || age>21 || knowsTheOwner){
    print("Welcome to the club, \(name)")
} else{
    print("Sorry, you better go home, \(name)")
}


//: [Next](@next)

var k = 20
while k<100{
    print(k)
    k += 1
}
