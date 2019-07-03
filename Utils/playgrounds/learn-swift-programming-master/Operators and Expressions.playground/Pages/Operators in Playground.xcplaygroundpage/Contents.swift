//: ## Operators
var gamePoints = 1000
var numberOfLives = 3
var numberOfDeaths = 0

let pointsPerLife = 100
let pointsPerDeath = 300

// Note: I made randomBonus always return 20.

var totalPoints = gamePoints + (numberOfLives * pointsPerLife) - (numberOfDeaths * pointsPerDeath) + randomBonus(from: 0, to: 100)

numberOfLives -= 1
numberOfDeaths += 1

var lifeBonus = numberOfLives * pointsPerLife
var deathBonus = numberOfDeaths * pointsPerDeath
var newTotalPoints = gamePoints + lifeBonus - deathBonus + randomBonus(from: 0, to: 100)
//: [Next](@next)


let vowelBonus = 10
let constantBonus = 5
let lengthBonus = 2

var constants = 12
var vowels = 4
var length = 16

var score = 0

score = (vowels*vowelBonus) + (constants*constantBonus) + (length*lengthBonus)
