//: [Previous](@previous)
//: ## Dictionaries
//: Initializer syntax
var groupsDict = [String:String]()
//: Dictionary literal
var animalGroupsDict = ["whales": "pod", "geese": "flock", "lions": "pride"]
//: Another example
var lifeSpanDict = ["African Grey Parrot": 50...70, "Tiger Salamander": 12...15, "Bottlenose Dolphin": 20...30]
var averageLifeSpanDict = [String: Range<Int>]()
//: ## Retrieving Values
var phoneNumbers = ["Jenny": "867-5309", "Mateo": "510-7752", "Mike": "330-8004", "Alicia": "489-4608", "Daniel": "455-2626", "Josie": "769-3339"]
phoneNumbers["Alicia"]
//: [Next](@next)



func frequency(numbers: [Int]) -> [Int: Int] {
    var dict = [Int:Int]()
    
    for i in numbers{
        if let dictKey = dict[i] {
            dict[i] = dictKey + 1
        } else{
            dict[i] = 1
        }
    }
    
    return dict
}

let input = [1, 3, 1, 1, 2, 7, 3, 5, 8, 5, 4, 9]

print(frequency(numbers: input))

var studioAlbums = ["Led Zeppelin":1969, "Led Zeppelin II":1969, "Led Zeppelin III":1970,
                    "Led Zeppelin IV":1971, "House of the Holy":1973, "Physical Graffiti":1975,
                    "Presence":1976, "In Through the Out Door":1979, "Coda":1982]
studioAlbums.count

