## Encoding and Decoding Custom Types

원본 링크: [애플 개발자 웹사이트](https://developer.apple.com/documentation/foundation/archives_and_serialization/encoding_and_decoding_custom_types) & 프로젝트: [쇼핑 앱 프로젝트 저장소](https://github.com/code-squad/swift-storeapp)

코드스쿼드의 프로젝트 진행하던 중 Swift 객체에 대한 JSON Encoding/Decoding 방식에 대해 학습해야 할 필요가 생겨서 해당 문서를 정리해둔다. 본 문서는 JSON 같은 external representations를 어떻게 encoding/decoding할 수 있는 방식으로 바꾸냐에 대한 논의가 담겨있다.

### Encode and Decode Automatically

Swift에는 [`Codable`](https://developer.apple.com/documentation/swift/codable)이라는 타입이 있는데, encoding과 decoding을 지원하려면 해당 타입의 프로토콜을 이용해야 한다. 사실 타입을 ```Codable```하게 만드는 것은 `String`, `Int`, `Double`과 같은 기본 타입을 사용하거나 `Date`, `Data`, `URL`과 같은 iOS Foundation 자체에서 지원하는 타입을 활용하면 된다. 어느 속성이든 모두 `codable`하다는 것은 그 자체만으로도 `codable`이라는 프로토콜을 따르게 된다(conforms)고 보면 된다.

`Landmark  `예시를 살펴보도록 하자.

```swift
struct Landmark: Codable {
    var name: String
    var foundingYear: Int
    
  	// Landmark에 Codable 타입을 붙여주는 순간, init(from:)과 encode(to:)를 모두 지원하게 된다.
}
```

이렇게 타입에 `Codable` 을 붙여주게 되면 built-in data formats을 자유롭게 serializae하거나 받을 수 있게 된다. 위에서 정의한 Landmark 구조체는 [`PropertyListEncoder`](https://developer.apple.com/documentation/foundation/propertylistencoder)나  [`JSONEncoder`](https://developer.apple.com/documentation/foundation/jsonencoder) 클래스를 활용하면 된다.

```swift
let settingsURL: URL = ... // location of plist file
var settings: MySettings?

if let data = try? Data(contentsOf: settingsURL) {
  let decoder = PropertyListDecoder()
  settings = try? decoder.decode(MySettings.self, from: data)
} //이렇게 PropertyListDecoder 객체를 만들고 decode 메소드를 사용하면 된다.
```

```swift
struct Coordinate: Codable {
    var latitude: Double
    var longitude: Double
}

struct Landmark: Codable {
    // Double, String, Int 모두 Codable한 상태로 변환된다
    var name: String
    var foundingYear: Int
    
    // Custom Type을 적용해도 큰 문제 없이 해결된다
    var location: Coordinate
}
```

Array, Dictionary, Optional과 같은 빌트인 타입도 내부에 codable types를 포함하고 있으면 자연스럽게 `Codable`에 종속된다. 위의 코드에서 보듯이 `Coordinate`라는 Custom type을 추가해도 conform은 유지된다.

```swift
struct Landmark: Codable {
    var name: String
    var foundingYear: Int
    var location: Coordinate
    
    // Landmark는 아래의 속성을 추가하더라도 계속 Codable한 상태를 유지하게 된다
    var vantagePoints: [Coordinate]
    var metadata: [String: String]
    var website: URL?
}
```

Codable은 Encodable과 Decodable을 포함하는 개념이므로, 별개의 개념으로 선언해주는 것도 가능하다.

```swift
struct Landmark: Encodable {
    var name: String
    var foundingYear: Int
}
```

```swift
struct Landmark: Decodable {
    var name: String
    var foundingYear: Int
}
```

```swift
struct Landmark: Codable {
    var name: String
    var foundingYear: Int
    var location: Coordinate
    var vantagePoints: [Coordinate]
    
    enum CodingKeys: String, CodingKey {
        case name = "title"
        case foundingYear = "founding_date"
        
        case location
        case vantagePoints
    }
}
```

```swift
struct Coordinate {
    var latitude: Double
    var longitude: Double
    var elevation: Double

    enum CodingKeys: String, CodingKey {
        case latitude
        case longitude
        case additionalInfo
    }
    
    enum AdditionalInfoKeys: String, CodingKey {
        case elevation
    }
}
```

```swift
extension Coordinate: Decodable {
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        latitude = try values.decode(Double.self, forKey: .latitude)
        longitude = try values.decode(Double.self, forKey: .longitude)
        
        let additionalInfo = try values.nestedContainer(keyedBy: AdditionalInfoKeys.self, forKey: .additionalInfo)
        elevation = try additionalInfo.decode(Double.self, forKey: .elevation)
    }
}
```

```swift
extension Coordinate: Encodable {
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(latitude, forKey: .latitude)
        try container.encode(longitude, forKey: .longitude)
        
        var additionalInfo = container.nestedContainer(keyedBy: AdditionalInfoKeys.self, forKey: .additionalInfo)
        try additionalInfo.encode(elevation, forKey: .elevation)
    }
}
```

