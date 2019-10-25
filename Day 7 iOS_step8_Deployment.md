##Day 7 iOS_step8_Deployment.pdf

### 클로저에서의 강한 순환 참조

캡쳐(capture)란 클로저의 본문에서 인스턴스의 프로퍼티에 접근하거나 인스턴스의 메소드를 호출하는 것을 **캡쳐(capture)**라고 한다.

클래스처럼 클로저는 참조 타입이기 때문에 강한 순환 참조가 발생할 수 있다. 클래스 인스턴스의 프로퍼티에 클로저를 할당할 때 클로저에 참조를 할당하기 때문에 강한 순환 참조가 발생할 수 있고, 클로져의 본문이 인스턴스를 캡쳐(capture) 할 때 클로저가 self를 캡쳐하게 되면서 강한 순환 참조가 발생할 수 있다.

캡쳐(capture)란 클로저의 본문에서 인스턴스의 프로퍼티에 접근하거나 인스턴스의 메소드를 호출하는 것을 캡쳐(capture)라고 한다.

아래 코드는 **클로저에서 self 참조를 사용**할 때, 강한 순환 참조를 만드는 코드이다.

```
class HTMLElement {
    let name: String
    let text: String?
    
    lazy var asHTML: () -> String = {
        if let text = self.text {
            return "<\(self.name)>\(text)</\(self.name)>"
        } else {
            return "<\(self.name) />"
        }
    }
    
    init(name: String, text: String? = nil) {
        self.name = name
        self.text = text
    }
    
    deinit {
        print("\(name) is being deinitialized")
    }
}
```

아래 코드는 HTMLElement 클래스를 생성하고
새로운 인스턴스를 출력하는 코드이다.

```
var paragraph: HTMLElement? = HTMLElement(name: "p", text: "hello, world")
print(paragraph!.asHTML())
// Prints "<p>hello, world</p>"
```

위의 코드에서 HTMLElement 클래스는
HTMLElement 인스턴스와 asHTML 값에 대한 클로저 사이에
강한 순환 참조가 만들어진다.

인스턴스의 asHTML 프로퍼티는 클로저에 강한 참조를 가지고 있지만
클로저는 본문에서 self를 참조하기 때문에
HTMLElement 인스턴스에 강한 참조를 가지고 있다는 것을 뜻한다.

paragraph 변수에 nil을 설정하고
HTMLElement 인스턴스에 강한 참조를 깨트리려 해도
**서로 강한 참조이기 때문에 강한 순환 참조가 발생한다.**
**강한 순환 참조이기에 HTMLElement 인스턴스도 클로저도**
**메모리에서 해제 되지 않는다.**

------

### 클로저에서의 강한 순환 참조 해결법

클로저와 클래스 인스턴스 사이에서 강한 순환 참조 해결법은
**클로저의 선언부에서 캡쳐 목록(capture list)을 정의**하는 것으로 해결할 수 있다.
**캡쳐 목록은 클로저 본문에 하나 이상의 참조를 캡쳐할 때 사용하는 규칙을 정의한다.**
두 클래스 인스턴스 사이에서의 강한 순환 참조 때 처럼,
**강한 참조 대신 약한 참조 혹은 미소유 참조로 선언해서 정의**한다.
상황에 따라서 약한 참조와 미소유 참조 중 선택해서 사용한다.

**캡쳐 목륵의 각 항목은 클래스 인스턴스에 참조(self)하거나**
**어떤 값으로 초기화된 변수(delegate = self.delegate)에**
**weak나 unowned 키워드로 연결된다.**
이것들은 대괄호([ ]) 안에 작성되고 콤마로 구분한다.

클로저의 매개변수 목록과 반환 타입 앞에 캡쳐 목록을 위치시킨다.

```
lazy var someClosure: (Int, String) -> String = {
    [unowned self, weak delegate = self.delegate!] (index: Int, stringToProcess: String) -> String in
    // closure body goes here
}
```

클로저가 매개변수 목록이나 반환 타입을 지정하지 않는다면
컨텍스트에 의해 추록되기 때문에,
캡쳐 목록은 클로저의 시작 부분에 위치하며 뒤에 in 키워드를 붙여준다.

```
lazy var someClosure: () -> String = {
    [unowned self, weak delegate = self.delegate!] in
    // closure body goes here
}
```

클로저와 인스턴스의 캡쳐가 항상 서로를 참조할 때, 클로저에서 캡쳐를 미소유(unowned) 참조로 정의하고
항상 같은 시점에 메모리에서 해제 된다. 

그와 반대로, 캡쳐된 참조가 나중에 nil이 될 수 있다면, 클로저에서 캡쳐를 약한(weak) 참조로 정의한다. 약한 참조는 항상 옵셔널 타입이고 참조하는 인스턴스가 메모리에서 해제될 때 nil이 된다. 캡쳐된 참조가 nil이 되지 않으면, 항상 약한 참조보다는 미소유 참조로 캡쳐하는게 좋다.

이전에 클로저에서 강한 순환 참조가 발생하는 코드에서 캡쳐 리스트를 통해 해결한다면 미소유 참조로 해야 적절하며
적용한 코드는 아래와 같다.

```
class HTMLElement {
    let name: String
    let text: String?
    
    lazy var asHTML: () -> String = {
        [unowned self] in
        if let text = self.text {
            return "<\(self.name)>\(text)</\(self.name)>"
        } else {
            return "<\(self.name) />"
        }
    }
    
    init(name: String, text: String? = nil) {
        self.name = name
        self.text = text
    }
    
    deinit {
        print("\(name) is being deinitialized")
    }
}
```

이번에는 **강한 참조대신 미소유 참조를 뜻하는 [unowned self]로 캡쳐**한다.

아래 코드는 이전처럼 HTMLElement 클래스를 생성하고
새로운 인스턴스를 출력하는 코드이다.

```
var paragraph: HTMLElement? = HTMLElement(name: "p", text: "hello, world")
print(paragraph!.asHTML())
// Prints "<p>hello, world</p>"
```

이번에는 아까와 달리
**클로저에 의한 self의 캡쳐를 미소유 참조로 해서,**
**캡쳐된 HTMLElement 인스턴스를 강하게 유지하고 있지 않다.**

paragraph 변수의 강한 참조를 nil로 설정하면
HTMLElement 인스턴스는 메모리에서 해제되고,
메모리에서 해제 되었다는 메시지를 볼 수 있다.

### Optional

Swift가 갖는 Optional이라는 개념은 변수의 값이 nil일 수 있다는 것을 표현하는 건데요, 반대로 Optional이 아니라면(non-optional) 해당 값은 nil이 될 수 없음을 의미한다. Swift에서는 Optional은 말 그대로 옵션(선택적) 이며 기본값은 non-Optional 이다. Objective-C에는 아직 `nil`타입이 존재하며 하나의 프로젝트에서 obj-c와 swift를 혼용해서 사용할 수 있다. 따라서 obj-c와의 상호운용성을 위해 사용한다.

### Optional 변수의 이용

Optional변수는 `nil`을 가질 수 있는 특별한 변수다. Optional 변수를 이용해서 작업할 때 Optional을 해제하는 과정이 추가적으로 필요하다.

```swift
var number1:Int? = 20
var number2:Int = 100

number1 + number2
```

## Optional

Swift가 갖는 Optional이라는 개념은 변수의 값이 `nil`일 수 있다는 것을 표현하는 건데요, 반대로 Optional이 아니라면(non-optional) 해당 값은 `nil`이 될 수 없음을 의미합니다. Objective-C를 사용해왔다면 Optional이라는 표현이 너무나도 당연해보일 수 있지만, Swift에서는 Optional은 말 그대로 `옵션(선택적)` 이며 기본값은 non-Optional 입니다.

number1은 Optional로 nil값을 가질 `가능성`이 있기 때문에 컴파일 단계에서 에러를 발생시킵니다. 연산을 수행하기 위해서는 `unwrapping` 또는 `binding` 과정이 필요하다.

### Optional Unwrapping (옵셔널 해제)

Optional Unwrapping이란 Optional 변수에서 Optional 껍데기를 벗겨내는 작업입니다.

```swift
var number1:Int? = 20
var number2:Int = 100

if number1 {
    let sum = number1! + number1!
}
//if 로 optional 변수의 값이 nil이 아닌지 판별 후 ! unwrapping 키워드를 통해 강제로 값을 꺼내옵니다.
```



### 클로저에서의 강한 순환 참조

**클래스처럼 클로저는 참조 타입이기 때문에 강한 순환 참조가 발생**할 수 있다.
클래스 인스턴스의 프로퍼티에 클로저를 할당 할 때
**클로저에 참조를 할당하기 때문에 강한 순환 참조가 발생**할 수 있고,
클로져의 본문이 **인스턴스를 캡쳐(capture)**할 때
**클로저가 self를 캡쳐하게 되면서 강한 순환 참조가 발생**할 수 있다.

**캡쳐(capture)**란 클로저의 본문에서 인스턴스의 프로퍼티에 접근하거나
인스턴스의 메소드를 호출하는 것을 **캡쳐(capture)**라고 한다.

아래 코드는 **클로저에서 self 참조를 사용**할 때,
강한 순환 참조를 만드는 코드이다.

```
class HTMLElement {
    let name: String
    let text: String?
    
    lazy var asHTML: () -> String = {
        if let text = self.text {
            return "<\(self.name)>\(text)</\(self.name)>"
        } else {
            return "<\(self.name) />"
        }
    }
    
    init(name: String, text: String? = nil) {
        self.name = name
        self.text = text
    }
    
    deinit {
        print("\(name) is being deinitialized")
    }
}
```

아래 코드는 HTMLElement 클래스를 생성하고
새로운 인스턴스를 출력하는 코드이다.

```
var paragraph: HTMLElement? = HTMLElement(name: "p", text: "hello, world")
print(paragraph!.asHTML())
// Prints "<p>hello, world</p>"
```

위의 코드에서 HTMLElement 클래스는
HTMLElement 인스턴스와 asHTML 값에 대한 클로저 사이에
강한 순환 참조가 만들어진다.

인스턴스의 asHTML 프로퍼티는 클로저에 강한 참조를 가지고 있지만
클로저는 본문에서 self를 참조하기 때문에
HTMLElement 인스턴스에 강한 참조를 가지고 있다는 것을 뜻한다.

paragraph 변수에 nil을 설정하고
HTMLElement 인스턴스에 강한 참조를 깨트리려 해도
**서로 강한 참조이기 때문에 강한 순환 참조가 발생한다.**
**강한 순환 참조이기에 HTMLElement 인스턴스도 클로저도**
**메모리에서 해제 되지 않는다.**

------

### 클로저에서의 강한 순환 참조 해결법

클로저와 클래스 인스턴스 사이에서 강한 순환 참조 해결법은
**클로저의 선언부에서 캡쳐 목록(capture list)을 정의**하는 것으로 해결할 수 있다.
**캡쳐 목록은 클로저 본문에 하나 이상의 참조를 캡쳐할 때 사용하는 규칙을 정의한다.**
두 클래스 인스턴스 사이에서의 강한 순환 참조 때 처럼,
**강한 참조 대신 약한 참조 혹은 미소유 참조로 선언해서 정의**한다.
상황에 따라서 약한 참조와 미소유 참조 중 선택해서 사용한다.

**캡쳐 목륵의 각 항목은 클래스 인스턴스에 참조(self)하거나**
**어떤 값으로 초기화된 변수(delegate = self.delegate)에**
**weak나 unowned 키워드로 연결된다.**
이것들은 대괄호([ ]) 안에 작성되고 콤마로 구분한다.

클로저의 매개변수 목록과 반환 타입 앞에 캡쳐 목록을 위치시킨다.

```
lazy var someClosure: (Int, String) -> String = {
    [unowned self, weak delegate = self.delegate!] (index: Int, stringToProcess: String) -> String in
    // closure body goes here
}
```

클로저가 매개변수 목록이나 반환 타입을 지정하지 않는다면
컨텍스트에 의해 추록되기 때문에,
캡쳐 목록은 클로저의 시작 부분에 위치하며 뒤에 in 키워드를 붙여준다.

```
lazy var someClosure: () -> String = {
    [unowned self, weak delegate = self.delegate!] in
    // closure body goes here
}
```

클로저와 인스턴스의 캡쳐가 **항상 서로를 참조할 때,**
**클로저에서 캡쳐를 미소유(unowned) 참조로 정의하고**
**항상 같은 시점에 메모리에서 해제 된다.**

그와 반대로, **캡쳐된 참조가 나중에 nil이 될 수 있다면,**
**클로저에서 캡쳐를 약한(weak) 참조로 정의한다.**
약한 참조는 항상 옵셔널 타입이고
**참조하는 인스턴스가 메모리에서 해제될 때 nil이 된다.**

> **캡쳐된 참조가 nil이 되지 않으면,**
> **항상 약한 참조보다는 미소유 참조로 캡쳐하는게 좋다.**



이전에 클로저에서 강한 순환 참조가 발생하는 코드에서
캡쳐 리스트를 통해 해결한다면 미소유 참조로 해야 적절하며
적용한 코드는 아래와 같다.

```
class HTMLElement {
    let name: String
    let text: String?
    
    lazy var asHTML: () -> String = {
        [unowned self] in
        if let text = self.text {
            return "<\(self.name)>\(text)</\(self.name)>"
        } else {
            return "<\(self.name) />"
        }
    }
    
    init(name: String, text: String? = nil) {
        self.name = name
        self.text = text
    }
    
    deinit {
        print("\(name) is being deinitialized")
    }
}
```

이번에는 **강한 참조대신 미소유 참조를 뜻하는 [unowned self]로 캡쳐**한다.

아래 코드는 이전처럼 HTMLElement 클래스를 생성하고
새로운 인스턴스를 출력하는 코드이다.

```
var paragraph: HTMLElement? = HTMLElement(name: "p", text: "hello, world")
print(paragraph!.asHTML())
// Prints "<p>hello, world</p>"
```

이번에는 아까와 달리
**클로저에 의한 self의 캡쳐를 미소유 참조로 해서,**
**캡쳐된 HTMLElement 인스턴스를 강하게 유지하고 있지 않다.**

paragraph 변수의 강한 참조를 nil로 설정하면
HTMLElement 인스턴스는 메모리에서 해제되고,
메모리에서 해제 되었다는 메시지를 볼 수 있다.



### 약한 참조 (weak reference)

**약한 참조(weak reference)**는 참조하는 인스턴스를 강하게 유지 하지 않는 참조이며 다른 인스턴스의 생명주기가 짧을 때 사용한다. 참조하고 있는 인스턴스를 강하게 유지하지 않기 때문에, 약한 참조로 참조하고 있는 동안에 인스턴스가 메모리 해제되는 것이 가능하다. 

참조하는 인스턴스가 메모리에서 해제되면, ARC는 자동으로 약한 참조를 nil로 설정한다. 약한 참조는 언제든지 nil로 값이 변경될 수 있기 때문에 상수보다는 옵셔널 타입의 변수로 선언되어야 한다.

```swift
class Person {
	let name: String

	init(name: String) { self.name = name }
	var apartment: Apartment?

	deinit { println("\(name) is being deinitialized") }
}
 
class Apartment {
	let number: Int

	init(number: Int) { self.number = number }
	weak var tenant: Person?

	deinit { println("Apartment #\(number) is being deinitialized") }
}
```



### 미소유 참조 (unowned reference)

**미소유 참조(unowned reference)**도 인스턴스가 참조하는 것을 강하게 유지하지 않는다.

하지만 **약한 참조**와는 달리 **미소유 참조**는 다른 인스턴스와 같은 생명주기를 가지거나 더 긴 생명주기를 가질 때 사용한다. 미소유 참조의 사용법은 프로퍼티나 변수 선언 앞에 **unowned** 키워드를 사용하면 된다. 미소유 참조는 항상 값을 가지고 있는 것으로 간주하기 때문에 ARC는 미소유 참조의 값을 nil로 설정하지 않는다.

미소유 참조는 옵셔널이 아닌 타입의 상수로 선언되어야 한다. 참조가 항상 메모리가 해제되지 않는 인스턴스를
참조하는게 확실할 때 미소유 참조를 사용한다. 미소유 참조를 사용하는 코드는 아래와 같다.



```swift
class Customer {
	let name: String
	var card: CreditCard?

	init(name: String) {
		self.name = name
	}

	deinit { println("\(name) is being deinitialized") }
}
 
class CreditCard {
	let number: UInt64
	unowned let customer: Customer

	init(number: UInt64, customer: Customer) {
		self.number = number
		self.customer = customer
	}
	
	deinit { println("Card #\(number) is being deinitialized") }
}
```

### Reference

http://jhyejun.com/blog/how-to-use-weak-and-unowned