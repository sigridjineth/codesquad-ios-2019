## 스위프트에서의 중첩 타입, 확장, 패턴 매칭, 그리고 열거형  (2019.10.25 금)

* [코드스쿼드 iOS 카드게임 과제](https://github.com/code-squad/swift-cardgame)를 수행하면서 학습한 내용 정리하기

### 열거형을 보고 느낀 점

처음에 열거형을 보았을 때 C언어의 ```switch``` 명령문을 떠올렸는데, 아직 잘 모르겠지만 폭 넓은 활용범위를 지니고 있다고 한다. 사실 C언어에서는 열거형에 정수만 지정할 수 있었지만, 스위프트는 정수/문자열/실수 등과 연결할 수 있다. 우선 기본적인 열거형의 정의부터 살펴보면,

```swift
enum Movement: Int { #이런 시긍로
    case Left = 0
    case Right = 1
    case Top = 2
    case Bottom = 3
}

let rightMovement = Movement(rawValue: 1) #이렇게 값으로 방향을 별도 지정해줄 수도 있음

enum House: String {
  case Seoul = "Bangbae-dong"
  case Tokyo = "Sinjuku Street"
  case Boston = "Boston University"
}
```

상하좌우 움직임을 정의해보았고, 패턴 매칭을 활용하여 ```Movement```의 값을 찾거나 케이스 별로 특정한 동작을 하도록 지시할 수 있다.

```swift
let aMovement = Movement.Left

switch aMovement {
    case .Left: print("left")
    default: ()
}

if case .Left = aMovement { print("left") }

if aMovement == .Left { print("left") }
```

```String``` 이나 ```Int``` 의 경우에는 값의 표기를 생략하더라도 컴파일러가 알아서 채워넣게 된다.

```swift
// Mercury = 1, Venus = 2, ... Neptune = 8
enum Planet: Int {
    case Mercury = 1, Venus, Earth, Mars, Jupiter, Saturn, Uranus, Neptune
}

// North = "North", ... West = "West"
enum CompassPoint: String {
    case North, South, East, West
}

let bestHouse = House.Stark 
print(bestHouse.rawValue) #이런 식으로 rawValue 프로퍼티를 쓰면 연결된 값을 사용할 수 있음.
```

### 중첩타입이 모임?

열거형은 특정 클래스 및 구조체의 기능을 지원하고자 만드는데, 기능 클래스와 구조체를 더 복잡한 타입의 컨텍스트에서 사용할 수 있도록 ***노가다로*** 정의해준 다는 특징이 있다. 중첩 타입은 중첩을 지원하는 열거형, 클래스/구조체를 내장 타입으로 사용할 수 있도록 정의해준다.

##### 내포된 열거형 (nested enum, enum in enum)

```swift
enum Character {
    enum Weapon {
        case Bow
        case Sword
        case Lance
        case Dagger
    }
    enum Helmet {
        case Wooden
        case Iron
        case Diamond
    }
    case Thief
    case Warrior
    case Knight
}

let character = Character.Thief
let weapon = Character.Weapon.Bow
let helmet = Character.Helmet.Iron
```

##### 구조체나 클래스 내부에 열거형을 포함할 수 있음

```swift
struct TopTierUniversities {
    enum Korea {
        case SNU
        case Yonsei
        case KoreaUniv
    }
    enum UnitedStates {
        case Harvard
        case Stanford
        case Yale
        case Princeton
    }
    let sky: Korea
    let ivyleague: UnitedStates
}

let targetschool = TopTierUniversities(sky: SNU, ivyleague: .Yale)
```

### 연관값 (Associated Values)

열거형의 케이스에 추가적인 정보를 덧붙이는 독특한 방법. 주식 거래 시스템을 만들 때 매매/매도 방식이 있는데 이 때 value 그 자체 - 그러니까 얼마를 사고 팔 것인가의 정보를 추가할 필요성이 있음.

```swift
enum Trade {
    case Buy
    case Sell
}

func trade(tradeType: Trade, stock: String, amount: Int) {}
```

```swift
enum Trade {
    case Buy(stock: String, amount: Int)
    case Sell(stock: String, amount: Int)
}
func trade(type: Trade) {}
```

### 패턴 매칭

기존의 Objective-C에서는 swift문의 핵심 기능이 패턴 매칭이었고 해당 기능은 매우 강력했다고 알려진다.

```swift
enum Direction {
  case North, South, East, West
}

// 단순한 열거형의 값들 중에서 쉽게 선택할 수 있습니다.
extension Direction: CustomStringConvertible {
  var description: String {
    switch self {
    case North: return "￪"
    case South: return "￬"
    case East: return "￫"
    case West: return "￩"
    }
  }
}
//switch문으로서, 스위프트의 패턴매칭의 가장 간단하면서도 많이 활용되는 형태임
```

```swift
enum Media {
  case Book(title: String, author: String, year: Int)
  case Movie(title: String, director: String, year: Int)
  case WebSite(url: NSURL, title: String)
}

extension Media {
  var mediaTitle: String {
    switch self {
    case .Book(title: let aTitle, author: _, year: _):
      return aTitle
    case let .Movie(title: aTitle, director: _, year: _): //이런 식으로 let을 앞에 써줘도 됨
      return aTitle
    case .WebSite(url: _, title: let aTitle):
      return aTitle
    }
  }
}

let book = Media.Book(title: "20,000 leagues under the sea", author: "Jules Verne", year: 1870)
book.mediaTitle
```

예를 들어, ```case Media.Book(title: let aTitle)```으로 주어진다면 '만약 주어진 값이 ```Media.Book```이면 변수 ```aTitle```와 연관값을 바인딩하라' 는 뜻이 된다. 즉, `Media` 인스턴스가 이 중 한 가지 `Case`에 매칭된다면 새로운 변수 `let aTitle`이 생성되고 연관 값 `Title`이 이 변수에 바인딩된다. 매칭된 경우 새로운 `let`상수를 생성한다.

#### 상수 값의 사용

```swift
extension Media {
  func checkAuthor(author: String) -> Bool {
    switch self {
    case .Book(title: _, author: author, year: _): return true
    case .Movie(title: _, director: author, year: _): return true
    default: return false
    }
  }
}
book.checkAuthor("Jules Verne")
```

이런 식으로 상수 값도 바인딩해서 이 변수가 다른 상수와 같은 지 검사하면서 상수로 직접 패턴매칭할 수도 있다.

```swift
let trade = Trade.Buy(stock: "APPL", amount: 500)
if case let Trade.Buy(stock, amount) = trade {
    print("buy \(amount) of \(stock)")
}
```

### 중첩 타입의 사용

```swift
struct BlackjackCard {
    
    // nested Suit enumeration
    enum Suit: Character {
        case Spades = "♠", Hearts = "♡", Diamonds = "♢", Clubs = "♣"
    }
    
    // nested Rank enumeration
    enum Rank: Int {
        case Two = 2, Three, Four, Five, Six, Seven, Eight, Nine, Ten
        case Jack, Queen, King, Ace
        struct Values {
            let first: Int, second: Int?
        }
        var values: Values {
            switch self {
            case .Ace:
                return Values(first: 1, second: 11)
            case .Jack, .Queen, .King:
                return Values(first: 10, second: nil)
            default:
                return Values(first: self.toRaw(), second: nil)
                }
        }
    }
    
    // BlackjackCard properties and methods
    let rank: Rank, suit: Suit
    var description: String {
        var output = "suit is \(suit.toRaw()),"
            output += " value is \(rank.values.first)"
            if let second = rank.values.second {
                output += " or \(second)"
            }
            return output
    }
}
```

1. BlackjackCard라는 구조체는 블랙잭 게임에서 사용하는 게임 카드로 만들어 정의한다. BalckjackCard 구조체는 Suit와 Rank라는 두가지 열거형 타입을 포함한다.
2. 블랙잭은 일에서 십일까지 값인 에이스카드를 가진다. 이러한 특징은 Values라는 구조체를 표현하는데 Rank 열거형 안에 중첩되어 있다.
3. Rank 열거형은 Values라는 중첩된 구조체를 정의하며, 이 구조체는 대부분의 카드는 한 개의 값을 가지지만 에이스 카드는 두개의 값을 가진다는 사실을 캡슐화 한다. Values 구조체는 Int 타입의 `first`와 `Int?`나 `옵셔널 Int` 타입의 `second`를 사용한다. (없을 경우 `nil`로 표기)

4. Rank는 계산 속성으로 values를 정의하며 Values 구조체의 인스턴스를 반환한다. 계산 속성은 카드의 순위를 고려하고 새로운 Values 인스턴스를 순위를 기반으로 적합한 값으로 초기화한다.

5. description이라는 계산 속성은 저장된 rank와 suit의 값을 사용하여 이름 설명과 카드의 값을 만든다.

```swift
let heartsSymbol = BlackjackCard.Suit.Hearts.toRaw()
// heartsSymbol is "♡"

let theAceOfSpades = BlackjackCard(rank: .Ace, suit: .Spades)
print("theAceOfSpades: \(theAceOfSpades.description)")
// prints "theAceOfSpades: suit is ♠, value is 1 or 11"
```

다음과 같이 출력할 수 있다. 정의 컨텍스트 밖에서 중첩타입을 사용하고자 한다면, 자신의 중첩 타입 이름 앞에 접두사를 붙인다. BlackjackCard 구조체는 사용자 이니셜라이저를 가지지 않으며, 암시적인 멤버 이니셜라이저를 가진다. 이니셜라이저는 theAceOfSpades 상수를 초기화하도록 사용할 수 있다.

## Reference

* http://minsone.github.io/mac/ios/swift-nested-types-summary
* http://outofbedlam.github.io/swift/2016/04/05/EnumBestPractice/