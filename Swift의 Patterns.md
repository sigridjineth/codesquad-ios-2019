## Swift의 Patterns

Swift에는 두가지 패턴이 있는데, 런타임 시 어떤 종류의 값과도 일치하는 패턴과 어떤 종류의 값과도 일치하지 않는 패턴이 있다.

첫 번째 패턴의 경우, 단순 상수, 변수 및 옵셔널 바인딩(Optional Binding)에서 값을 소멸시키는 데 사용된다. 여기에는 wildcard 패턴, identifier 패턴 및 이를 포함하는 값 바인딩 또는 튜플 패턴이 포함된다. 이러한 패턴에 대한 타입 어노테이션을 지정하여 특정 유형의 값과만 일치하도록 제한을 걸 수 있다.

두번째 패턴은 전체 패턴 매칭(full pattern matching)에 사용된다. 여기서 일치시키려는 값은 런타임에 **없을 수도 있다.** 이 패턴에는 열거 케이스 패턴, Optional패턴, 표현패턴 및 타입 캐스팅 패턴이 포함된다. 이 패턴에는 switch문, do-catch, if case, while, guard, for-in문이 있다.

#### Wildcard Pattern

와일드 카드 패턴은 모든 값을 일치시키고 무시하며 **밑줄(_)**로 구성된다. 일치되는 값을 신경쓰지 않으면 와일드 카드 패턴을 사용하면 된다.

```
for _ in 1...3 {    // Do something three times.}
```

```
for i in 0..<arr.count {    // Do something three times.}
```

현재 값을 무시하는 반복을 하고 싶다면 `_`를 사용하여 현재값을 무시할 수 있다.

#### Identifier Pattern

Identifier 패턴은 모든 값과 일치하며 일치된 값을 상수 또는 변수 이름에 바인딩 합니다. 

```
let someValue = 42
```

위의 상수, `let`을 선언해서 someValue는 Int타입의 값 42와 일치한다. 일치가 성공하면 값 42는 someValue라는 상수 이름에 바인딩(할당)된다. 변수 또는 상수 선언의 왼쪽에 있는 패턴이 Identifier패턴인 경우, Identifier패턴은 암시적으로(implicitly) 값 바인딩 패턴의 하위 패턴이다.

#### Value-Binding Pattern

값 바인딩 패턴은 일치하는 값을 상수 또는 변수 이름에 바인딩할 수 있다. 일치하는 값을 상수 이름에 바인딩하는 값 바인딩 패턴은 `let` 키워드로 시작한다. 변수 이름에 바인딩하는 변수는 `var` 키워드로 시작하는데, 값 바인딩 패턴내의 Identifier 패턴은 새 명명된 상수 또는 변수를 일치하는 값에 바인딩합니다. 

```swift
let point = (3, 2)
switch point {
// Bind x and y to the elements of point.case 
let (x, y):
	print("The point is at (\(x), \(y)).")}
// Prints "The point is at (3, 2)."
```

튜플의 요소를 분해하고, 각 요소의 값을 해당 Identifier패턴에 바인딩한다.



### Tuple Pattern

튜플패턴은 괄호로 묶인 0개 이상의 패턴을 쉼표로 구분한 목록이며, 해당 튜플 타입의 값과도 일치한다.

타입 어노테이션을 사용하여 특정 타입의 튜플 타입과 일치하도록 튜플패턴을 제한할 수 있다.

```let (x, y) : (Int, Int) = (1, 2)``` 의 경우, 상수 선언의 튜플 패턴 (x, y) : (Int, Int)은 두 요소가 모두 Int타입인 튜플 타입이다.

튜플패턴이 for-in문이나, 상수 또는 변수 선언의 패턴으로 사용될 때, 와일드카드 패턴, Identifier패턴, Optional패턴(밑에서 설명함) 또는 이를 포함하는 다른 튜플 패턴만 포함 할 수 있습니다.

예를들어, 튜플패턴 (x, 0)의 0이 표현패턴(expression pattern, 밑에서 설명할거에요!)이므로 

(튜플패턴은 **어떤 종류의 값과도 일치하는 패턴**이었고,  표현패턴은 **어떤 종류의 값과도 일치하지 않는 패턴**이기때문에)



```
let points = [(0, 0), (1, 0), (1, 1), (2, 0), (2, 1)]// This code isn't valid.for (x, 0) in points {    /* ... */}
```



위 코드는 에러를 발생시키는 것이죠.



그리고 우리 **Tuple**글에서 봤죠?





```
let a = 2        // a: Int = 2let (a) = 2      // a: Int = 2let (a): Int = 2 // a: Int = 2
```

괄호 하나는 아무 소용이 없다구요 ㅎㅎ 위 코드는 전부 똑같은 결과를 내게 됩니다. 



이제부터는 위에서 말한 두번째 패턴. 즉, 어떤 종류의 값과도 일치하지 않는 패턴들에는 뭐가 있는지 볼거에요. 





### Enumeration Case Pattern



열거형 패턴은 기존 열거형의 대소문자와 일치합니다. 

Enumeration case 패턴은 switch문  case레이블과 if, while, guard 및 for-in문의 조건에 표시됩니다. 

일치하는 값을 일치시킬 때, associated value가 있는경우, 해당하는 각 값에 대해 하나의 요소가 포함 된 튜플 패턴을 지정해야합니다.

뭔소리인지 1도 모르겠네요. 이거는 Enumeration 글에서 설명하도록 할게요! 꼭!!Apple문서에서도 Enumeration글에서 설명해서 ㅎㅎ..

이 내용이 Enumeration중간에 있어서 갑자기 설명하면 이해가 잘 안되실거에요!!

처음부터 보는게 나을 것 같아요 XD..







### Optional Pattern



Optional패턴! 즉 옵셔널 패턴?은 Identifier과 그 뒤에 바로 물음표(?)로 구성되며, 열거형 패턴과 동일한 위치에 나타납니다.



```
let someOptional: Int? = 42// Match using an optional pattern.
if case let x? = someOptional {
    print(x)
}
```

옵셔널 패턴은 for-in구문에서 옵셔널 값의 배열을 반복할 수 있는 편리한 방법을 제공합니다. 이 경우 nil이 아닌 요소에 대해서만 루프 본문을 실행합니다. 

```
let arrayOfOptionalInts: [Int?] = [nil, 2, 3, nil, 5]// Match only non-nil values.for case let number? in arrayOfOptionalInts {    print("Found a \(number)")}// Found a 2// Found a 3// Found a 5
```

for문에 저렇게 case let을 넣을 수 있다는 것은 처음알았네요 ㅎㅎ..

지금 몇개 다른걸 해봤는데, 



```
var arr = [1,2,3,4,5]
for index in arr{
    index = 1//error! cannot assign to value: 'index' is a 'let' constant
}
```

 for-in루프안에서 index를 변경하려고 하면 늘 오류가 났었어요. 

근데!!!



```
var arr = [1,2,3,4,5]for var index in arr{    index = 1}for case var index in arr{    index = 1}
```

 for-in루프안에서 var index 나, 저기 위에 처럼 case를 사용해서 case var를 사용하면 가능하다는 사실!!!! let으로 선언하면 당연히 안되겠죠? 

아무튼 ㅎㅎ...옵셔널 패턴과는 조금 상관없지만, 알아두시면 좋을 것 같아요!!



### Type-Casting Patterns



우리 타입 캐스팅!!!! 얼마전에 배웠죠!!

**<Type Casting>**읽고오시는 것을 추천드릴게요.

읽고오셔다면, 타입캐스팅 패턴이 뭔지 알아봅시다.



타입 캐스팅패턴에는 두가지 타입캐스팅 패턴이 있어요.

바로 is패턴과 as패턴이죠.

우리 다 배운거에요!!!

is 패턴은 switch문 case레이블에서만 나타납니다.

is 및 as패턴은 다음 형식을 갖습니다. 





- ```
  is type
  ```



- ```
  pattern as type
  ```



is패턴은 런타임시 해당 값의 타입이 is패턴의 오른쪽에 지정된 타입 또는 해당 타입의 서브클래스와 동일한 경우 값과 일치하게 됩니다. 

is패턴은 둘 다 타입 캐스트를 수행하지만, 리턴된 타입은 버리는 점에서, is연산자와 같이 동작합니다.



as패턴은 런타임시 해당 값의 타입이 as패턴의 오른쪽에 지정된 타입 또는 해당 타입의 서브클래스와 동일한 경우 값과 일치합니다.

일치가 성공하면 일치 된 값의 유형이 as 패턴의 오른쪽에 지정된 패턴으로 **변환**됩니다.



### Expression Pattern





표현패턴은 표현식의 값을 나타냅니다. **표현패턴은 switch문 case레이블에서만 나타납니다.** 



표현패턴으로 나타내진 표현식은 Swift  표준 라이브러리의 ~= 연산자를 사용하여 입력표현식의 값과 비교됩니다.

~=연산자가 true를 반환하면 일치가 성공합니다. ~=연산자는 == 연산자를 사용하여 같은 타입의 두 값을 비교합니다.

또한 다음 예제와 같이 값이 범위에 포함되는지 여부를 확인하여 값 범위와 값을 일치시킬 수 도 있습니다 .





```
let point = (1, 2)switch point {case (0, 0):    print("(0, 0)은 원점입니다. ")case (-2...2, -2...2):    print("(\(point.0), \(point.1))은 원점과 가깝습니다.")default:    print("점은 (\(point.0), \(point.1)) 입니다.")}// Prints "(1, 2)는 원점과 가깝습니다."
```

저기~~위에서 tuple 패턴에서, 잠깐 표현패턴이 나왔었죠?

표현패턴은 위에서 말했듯이 "값"을 나타내요.

위 예제를 보면, case에서, x나 y같이 변수로 나타내는 것이 아닌, 정말 0,0 이런식으로 "값"을 줬죠?

이게 바로 표현패턴을 사용한거에요.

값뿐만이 아니라, "범위"를 줄 수 도 있네요 ㅎㅎ



그럼 위에서 말한 ~=는 뭐죠..?;;;

처음보는 연산자인데 말이죠. 

간단하게 말해서 ~=연산자는 범위를 체크해주는? 간편한 연산자에요.

[**여기**](https://stackoverflow.com/a/46504728/7658180)의 예제를 참고하자면, 



```
let n: Int = 100
```



우리는 어떤 숫자를 가지고 있고, 이 숫자가 10이상인지 100이하인지 확인하고 싶어요.

그럼 어떻게 확인할까요?



```
if n>=10 && n<=100{    print("10이상, 100이하입니다!")
}
```

네! 이런방법이 있을 수 있겠죠 ㅎㅎ

그치만 ~=연산자를 사용하면 더 간단해진답니다. 



```
if 10...100 ~= n{    print("10이상, 100이하입니다!")}
```

바로 이렇게요!!

깔끔해졌죠?

이 ~=연산자를 "오버로딩" 할 수 도 있답니다. 

저기 위의 Point예제를 사용할거에요.



```
let point = (1, 2)
func ~= (pattern: String, value: Int) -> Bool {    return pattern == "\(value)"}
switch point {case ("0", "0"):    print("(0, 0)은 원점입니다.")default:    print("점은 (\(point.0), \(point.1)) 입니다.")}// Prints "점은 (1, 2) 입니다."
```

자..이상한 점이 한둘이 아니네요. 하나씩 살펴봅시다. 

일단 point라는 상수를 tuple로 만들어주었는데, 안의 값은 Int네요.

일단 ~=를 오버로딩한 함수는 조금만 이따가 보기로 하고, 

switch문으로 가봅시다.

그런데...

```
switch point {case ("0", "0"):    print("(0, 0)은 원점입니다.")default:    print("점은 (\(point.0), \(point.1)) 입니다.")}// Prints "점은 (1, 2) 입니다."
```

분명히 point는 (Int,Int)였는데..........String으로 case를 만들다니...이게 무슨...

일단 point라는 튜플이 switch문 안으로 들어와서 저 case를 한번 검사할거에요. 

그럼 결국 Int와 String을 비교한다는 소리네요.

그것을 가능하게 해주는 것이 바로 위에서 오버로딩한 ~=겠죠? 봅시다.

(~=는 원래 Equatable 프로토콜에 정의되어있는 메소드입니다. Equatable을 더 자세히 알고싶으시다면, **<**[ **Equatable** ](http://zeddios.tistory.com/227)[**>**](http://zeddios.tistory.com/227)를 참고해주세요 XD)



보기전에 ㅎㅎㅎㅎ

~=를 좀 더 알고 봅시다.

![img](https://t1.daumcdn.net/cfile/tistory/99BFAB3359FBDD690B)

**"두개의 파라미터가 같은 값으로 일치하는지 여부를 나타내는 Bool값을 반환합니다"**



오..근데 **Generic** Operator라는 말이 보이네요.

그렇다는말은..?뭔가 예상이 가지 않나요?..

```
func ~=<T>(a: T, b: T) -> Bool where T : Equatable
```



바로 이것이 ~=의 원형이라는 것..Generic메소드였네요 ㅎㅎ

그렇다는 소리는, 두 파라미터(a, b)가 Equatable을 준수하기만 한다면,

두 값이 일치하는지 확인할 수 있겠네요.



그럼 왜 ==를 안썼냐;; ==도 Generic연산자인데

네! 대부분의 경우 값이 같은지 안같은지 여부를 판단할 때는 ==연산자를 사용하죠.

하지만 ~=는 패턴매칭 연산자로서, **주로 case문 패턴매칭을 가능**하게 해준답니다.

그것이 유일한 차이점이라고 할 수 있겠네요 ㅎㅎ



자. 아까 우리가 오버로딩한 ~=연산자에요. 

```
func ~= (pattern: String, value: Int) -> Bool {    return pattern == "\(value)"}
```

간단해요. 왼쪽은 Equatable을 준수하는 String, 오른쪽은 Equatable을 준수하는 Int.

그 둘을 비교하네요!! 물론 value인 Int를 String으로 바꿔서요.

만약 같다면 true를 리턴할테고, 다르다면 false를 리턴하겠죠?

```
switch point {case ("0", "0"):    print("(0, 0)은 원점입니다.")default:    print("점은 (\(point.0), \(point.1)) 입니다.")}
```

``

그럼 이렇게만 해줘도 ~=가 알아서 불리냐?...

이 switch문안에서는 어디에도 ~=가 보이지 않는데 말이에요.

네! 불립니다. ~=연산자는 패턴매칭을 위해 case문에서 내부적으로 사용됩니다. case문에서 Equatable값과 일치할 때 이 연산자(~=)는 뒤에서 호출됩니다. (this operator is called **behind the scenes**.)

이얄ㅋ





자. 이렇게 Swift의 패턴들을 알아보았습니다ㅎㅎ

제가 무심코 사용하던 것들이 "패턴"이었다는 것에 다시한번 놀라네요.

도움이 되었길 바래요 :) 안녕!!





https://zeddios.tistory.com/274