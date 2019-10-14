//: Playground - noun: a place where people can play

import Cocoa

//------------ 변수와 상수
var str = "Hello, playground"
let apple = ""
var 🐶🐄 = "dogcow"

let intValue : Int = 1024
let floatValue : Float = 2.14
let doubleValue : Double = 3.141592
let defaultValue = 3.141592
let boolValue = false

//------------ 튜플
let http404Error = (404, "Not Found")
let (statusCode, statusMessage) = http404Error
print("The status code is \(statusCode)")
// Prints "The status code is 404"
print("The status message is \(statusMessage)")
// Prints "The status message is Not Found"
print("The status code is \(http404Error.0)")
// Prints "The status code is 404"
print("The status message is \(http404Error.1)")
// Prints "The status message is Not Found"

let http200Status = (statusCode: 200, description: "OK")
typealias PersonTuple = (name : String, age : Int)
let eric : PersonTuple = ("eric", 150)



//------------ 열거
// Normal Enum
enum CompassPoint {
    case north
    case south
    case east
    case west
}

// Raw-value Enum
enum ASCIIControlCharacter: Character {
    case tab = "\t"
    case lineFeed = "\n"
    case carriageReturn = "\r"
}

// Associated value Enum
enum Barcode {
    case upc(Int, Int, Int, Int)
    case qrCode(String)
}

var productBarcode = Barcode.upc(8, 85909, 51226, 3)
productBarcode = .qrCode("ABCDEFGHIJKLMNOP")

switch productBarcode {
case .upc(let numberSystem, let manufacturer, let product, let check):
    print("UPC: \(numberSystem), \(manufacturer), \(product), \(check).")
case .qrCode(let productCode):
    print("QR code: \(productCode).")
}



//------------ 배열
var ageArray = [10, 20, 30, 40, 50]
print(ageArray[0])

var floatArray : Array<Float> = [1.1, 2.2, 3.3]
var empryArray = Array<String>()
empryArray.append("one")


//------------ 사전
var gradeDic : Dictionary<String, Int> = ["a" : 90, "b" : 80, "c" : 70, "d" : 60]
print(gradeDic["a"] ?? 0)


//------------ 집합
var aSet: Set<Int> = [11, 12, 13]
aSet.contains(12)



//------------ 옵셔널
var optionalValue : Int? = nil
optionalValue = 10

let possibleNumber = "123"
let convertedNumber = Int(possibleNumber)

var serverResponseCode: Int? = 404
serverResponseCode = nil
if convertedNumber != nil {
    print("convertedNumber has an integer value of \(convertedNumber!).")
}

//Optional Binding
if let actualNumber = Int(possibleNumber) {
    print("\"\(possibleNumber)\" has an integer value of \(actualNumber)")
} else {
    print("\"\(possibleNumber)\" could not be converted to an integer")
}

//Implicitly Unwrapped Optionals
let possibleString: String? = "An optional string."
let forcedString: String = possibleString! // requires an exclamation mark

let assumedString: String! = "An implicitly unwrapped optional string."
let implicitString: String = assumedString // no need for an exclamation mark



//------------ 연산자 operators
var intValue1 = 5
var intValue2 = 10
var result = intValue1 + intValue2
result = intValue1 * intValue2
result = intValue1 % intValue2

intValue1 += 5; intValue2 -= 2
intValue2 /= 2; intValue2 %= 2

result = +intValue
var minusResult = -intValue

var flag = true
print(flag)
print(!flag)

flag = 1 == 1
flag = 1 != 2
flag = 2 > 1
flag = 1.5 >= 1
flag = 1 < 3
flag = 1.5 < 2
flag = 2 > 1 && 3.14 < 4

let doBlindDateFlag = (result>=80) ? true : false

result = optionalValue ?? intValue
result = (optionalValue != nil) ? optionalValue! : intValue

let closedRange = 1...5
let halfRange = 1..<5



//------------ 흐름 제어 Flow Control
//if 구문
var temperature = 10
if temperature < 15 {
    print("아우 추워. 겉옷을 챙기세요")
}

temperature = 40
if temperature > 30 {
    print("더운 날씨에요. 티셔츠만 입어도 될꺼에요")
}
else if temperature > 20 {
    print("날씨가 활동하기 좋겠어요")
}
else {
    print("쌀쌀할 수 있어요")
}

//switch 구문
let someCharacter: Character = "z"
switch someCharacter {
case "a":
    print("The first letter of the alphabet")
case "z":
    print("The last letter of the alphabet")
default:
    print("Some other character")
}

let approximateCount = 62
let countedThings = "moons orbiting Saturn"
var naturalCount: String
switch approximateCount {
case 0:
    naturalCount = "no"
case 1..<5:
    naturalCount = "a few"
case 5..<12:
    naturalCount = "several"
case 12..<100:
    naturalCount = "dozens of"
case 100..<1000:
    naturalCount = "hundreds of"
default:
    naturalCount = "many"
}
print("There are \(naturalCount) \(countedThings).")

let somePoint = (1, 1)
switch somePoint {
case (0, 0):
    print("(0, 0) is at the origin")
case (_, 0):
    print("(\(somePoint.0), 0) is on the x-axis")
case (0, _):
    print("(0, \(somePoint.1)) is on the y-axis")
case (-2...2, -2...2):
    print("(\(somePoint.0), \(somePoint.1)) is inside the box")
default:
    print("(\(somePoint.0), \(somePoint.1)) is outside of the box")
}

//for 구문
for index in 1...5 {
    print("\(index) 곱하기 5 는 \(index * 5)")
}

for index in stride(from: 5, through: 1, by: -1) {
    print("\(index) 곱하기 5 는 \(index * 5)")
}

let base = 3
let power = 10
var answer = 1
for _ in 1...power {
    answer *= base
}
print("\(base) to the power of \(power) is \(answer)")

let names = ["Honux", "JK", "Crong", "Anonymous"]
for name in names {
    print("Hello, master \(name)!")
}


//while 구문
let finalSquare = 25
var board = [Int](repeating: 0, count: finalSquare + 1)

board[03] = +08; board[06] = +11; board[09] = +09; board[10] = +02
board[14] = -10; board[19] = -11; board[22] = -02; board[24] = -08

var square = 0
var diceRoll = 0
while square < finalSquare {
    // roll the dice
    diceRoll += 1
    if diceRoll == 7 { diceRoll = 1 }
    // move by the rolled amount
    square += diceRoll
    if square < board.count {
        // if we're still on the board, move up or down for a snake or a ladder
        square += board[square]
    }
}
//print("Game over!")



//------------ closure
func squared(n : Int) -> Int { return n * n }
let closure1 : (Int) -> Int = { n in return n * n }
let closure2 = { (n:Int) -> Int in return n * n }

var initValue = 10
let increment = {
    (n:Int) in
    initValue = initValue + n
}
increment(5)
print(initValue)   //15

let c10 = increment
initValue = 100
c10(10)
print(initValue)   //110

//capture list
var captureValue = 10
let incrementBy = {
    [captureValue] (n:Int) in
    print(captureValue + n)
}
captureValue = 100
incrementBy(5) //15
print(captureValue)   //여전히 100

//High-order Function
func makeIncrementer(forIncrement amount: Int) -> () -> Int {
    var runningTotal = 0
    func incrementer() -> Int {
        runningTotal += amount
        return runningTotal
    }
    return incrementer
}

let incrementByTen = makeIncrementer(forIncrement: 10)

print(incrementByTen()) //10
print(incrementByTen()) //20

let incrementBy7 = makeIncrementer(forIncrement: 7)
print(incrementBy7()) //7
print(incrementByTen()) //30

//High-order Function
let nameArray = ["Chris", "Alex", "Ewa", "Barry", "Daniella"]
let reversedNames1 = nameArray.sorted(by: {
    (s1: String, s2: String) -> Bool in
    return s1 > s2
})
print(reversedNames1)
let reversedNames2 = nameArray.sorted { s1, s2 in s1 > s2 }
print(reversedNames2)

let numbers = [1, 2, 3, 4, 5, 10, 11, 12]
let strings = numbers.map( { element in String(element) } )
print(strings)

let numberArray = [2, 8, 1, 3, 5]
let resultArray = numberArray.map(squared) // 결과 값은 [4, 64, 1, 9, 25]
let result1 = numberArray.map({ (n : Int) -> Int in return n*n })
let result2 = numberArray.map({ (n : Int) -> Int in n*n })
let result3 = numberArray.map({ n in return n*n })
let result4 = numberArray.map({ n in n*n })
let result5 = numberArray.map({ $0 * $0 })
let result6 = numberArray.map() { $0 * $0 }
let result7 = numberArray.map { $0 * $0 }

//map.reduce.filter
let filtered = numbers.filter({ $0 > 10 })
print(filtered) // [11, 12]

let reduced = numbers.reduce(0, { $0 + $1 })
print(reduced) // 48

let nilNumbers : [Int?] = [1, 2, nil, 4, 5]
let mapNumber = nilNumbers.map({ $0 })
print(mapNumber)

let mapNumberOnly = nilNumbers.compactMap({ $0 })
print(mapNumberOnly) //[1, 2, 4, 5]



//------------ Struct
struct Resolution {
    var width = 0
    var height = 0
}

let someResolution = Resolution()
someResolution.width

let vga = Resolution(width: 640, height: 480)

//Milk
enum MilkType {
    case Blueberry
    case Banana
    case EnergyChoco
    case Unknown
}

public struct Milk {
    let brand : String
    let amount : Int
    let title : String
    let type : MilkType
}

let berryMilk1 = Milk(brand: "서울우유", amount: 150,
                      title: "블루베리우유", type: .Blueberry)
let bananaMilk1 = Milk(brand: "서울우유", amount: 150,
                       title: "바나나우유", type: .Banana)
let chocoMilk1 = Milk(brand: "서울우유", amount: 150,
                      title: "에너지초코우유", type: .EnergyChoco)
print(chocoMilk1)


//------------ Strings

let myString = "This is a String"
let campString = "techcamp-"+"2007"


let pathString = "Library/Caches/Images/dataCache.temp"
let pathComponents = pathString.components(separatedBy: "/")
let fileName = pathString.components(separatedBy: "/").last

let fileContents = try? String.init(contentsOfFile: pathString)


let name = "Marie Curie"
let firstSpace = name.index(of: " ") ?? name.endIndex
let firstName = name[..<firstSpace]
// firstName == "Marie"

let sanjose = "San Jose\u{301}"
let notfound = sanjose.range(of: "Jose")
//not found
let found = sanjose.range(of: "José")
//4..<9

let cafe = "Cafe\u{301} du 🌍"
print(cafe)
// Prints "Café du 🌍”
print(cafe.count)
// Prints "9"
print(Array(cafe))
// Prints "["C", "a", "f", "é", " ", "d", "u", " ", "🌍"]"

print(cafe.unicodeScalars.count)
// Prints "10"
print(Array(cafe.unicodeScalars))
// Prints "["C", "a", "f", "e", "\u{0301}", " ", "d", "u", " ", "\u{0001F30D}"]"
print(cafe.unicodeScalars.map { $0.value })
// Prints "[67, 97, 102, 101, 769, 32, 100, 117, 32, 127757]"

print(cafe.utf8.count)
// Prints "14"
print(Array(cafe.utf8))
// Prints "[67, 97, 102, 101, 204, 129, 32, 100, 117, 32, 240, 159, 140, 141]"

//------------ Class
class WoowaMilk {
    var brand : String
    var amount : Int
    var title : String
    var type : MilkType
    
    init() {
        brand = ""
        amount = 0
        title = ""
        type = .Unknown
    }
}
class ChocoMilk : WoowaMilk {
    override init() {
        super.init()
        type = .EnergyChoco
    }
}

class BananaMilk : WoowaMilk {
    override init() {
        super.init()
        type = .Banana
    }
}
let bananaMilk2 = BananaMilk()
let chocoMilk2 = ChocoMilk()


//value vs reference
let origin = CGPoint(x: 0, y: 0)
var other = origin
other.x += 10

var myMilk = ChocoMilk()
myMilk.amount = 300
var yourMilk = myMilk
yourMilk.amount = 100
print(myMilk.amount)

var another = origin
another.y += 5

func swapPoint(pointA : inout CGPoint, pointB : inout CGPoint) {
    let temp = pointA
    pointA = pointB
    pointB = temp
}

swapPoint(pointA: &other, pointB: &another)
print(other, another)


// Polymorphism
class Animal {
    func speak() {
        print("animal speak...")
    }
}

var animal = Animal()
animal.speak()

class Dog : Animal {
    override func speak() {
        print("dog - bow-wow")
    }
}

class Cat : Animal {
    override func speak() {
        print("cat - meow")
    }
}

var dog = Dog()
dog.speak()

var cat = Cat()
cat.speak()

var animalArray : [Animal] = [animal, dog, cat]
for x in animalArray {
    x.speak()
}

//------------ Type-cast
class MediaItem {
    var name: String
    init(name: String) {
        self.name = name
    }
}

class Movie: MediaItem {
    var director: String
    init(name: String, director: String) {
        self.director = director
        super.init(name: name)
    }
}

class Song: MediaItem {
    var artist: String
    init(name: String, artist: String) {
        self.artist = artist
        super.init(name: name)
    }
}

let library = [
    Movie(name: "Casablanca", director: "Michael Curtiz"),
    Song(name: "Blue Suede Shoes", artist: "Elvis Presley"),
    Movie(name: "Citizen Kane", director: "Orson Welles"),
    Song(name: "The One And Only", artist: "Chesney Hawkes"),
    Song(name: "Never Gonna Give You Up", artist: "Rick Astley")
]

var movieCount = 0
var songCount = 0

for item in library {
    if item is Movie {
        movieCount += 1
    } else if item is Song {
        songCount += 1
    }
}

print("Media library contains \(movieCount) movies and \(songCount) songs")
// Prints "Media library contains 2 movies and 3 songs"

for item in library {
    if let movie = item as? Movie {
        print("Movie: \(movie.name), dir. \(movie.director)")
    } else if let song = item as? Song {
        print("Song: \(song.name), by \(song.artist)")
    }
}

let someObjects: [AnyObject] = [
    Movie(name: "2001: A Space Odyssey", director: "Stanley Kubrick"),
    Movie(name: "Moon", director: "Duncan Jones"),
    Movie(name: "Alien", director: "Ridley Scott")
]

for object in someObjects {
    let movie = object as! Movie
    print("Movie: \(movie.name), dir. \(movie.director)")
}


//------------ Subscription
struct TimesTable {
    let multiplier: Int
    subscript(index: Int) -> Int {
        return multiplier * index
    }
}
let threeTimesTable = TimesTable(multiplier: 3)
print("six times three is \(threeTimesTable[6])")


//------------ Protocol
class WorkManager : CustomStringConvertible {
    var nativeArray = [10,12,24]
    var stringArray = ["Ebcd", "Bcd", "Acc", "Dedd"]
    
    var description : String {
        return "nativeArray = \(nativeArray)"
    }
}

var instance = WorkManager()
print(instance)


//------------ Generics
struct IntStack {
    var items = [Int]()
    mutating func push(_ item: Int) {
        items.append(item)
    }
    mutating func pop() -> Int {
        return items.removeLast()
    }
}

struct Stack<Element> {
    var items = [Element]()
    mutating func push(_ item: Element) {
        items.append(item)
    }
    mutating func pop() -> Element {
        return items.removeLast()
    }
}

var stackOfStrings = Stack<String>()
stackOfStrings.push("uno")
stackOfStrings.push("dos")
stackOfStrings.push("tres")
stackOfStrings.push("cuatro")
print(stackOfStrings)
