## 코드스쿼드 iOS 강의

### 스위프트란?

* 멀티 패러다임 언어: Lisp, Julia, Clojure 계열의 함수형 언어와 Objective-C 등 객체지향 언어 두 개의 패러다임을 차용한 다중 패러다임 언어임

  * 객체지향 패러다임: 객체지향은 컴퓨터 프로그램을 여러 개의 독립된 단위인 객체의 모임으로 파악한다. 객체지향 언어는 명령형 패러다임을 사용하는데, 프로퍼티나 변수 등에 해당하는 메모리 값의 상태 변화가 존재하기 때문이다.
    * 클래스: 같은 종류의 집단에 속하는 속성과 행위를 정의한 것으로서, 사용자가 정의하는 데이터 타입이며 독립적으로 디자인되어야 한다. 실제 메모리에 객체를 할당해 인스턴스를 만들기 위한 설계코드로서, 클래스에 정의된 모양대로 객체가 생성되고 객체 간의 메시지를 통해 프로그래밍의 각 명령이 실행된다.
    * 객체: 클래스의 인스턴스로서, 실제로 메모리에 할당되어 동작한다. 고유의 속성이 있으며 클래스에서 정의된 행위를 할 수 있다.
    * 메서드 또는 메시지: 객체가 클래스에 정의된 행위를 실제로 하는 함수이다. 메서드, 메시지를 통해 객체에 명령을 전달할 수 있다.
  * 함수형 패러다임: 프로그램이 상태변화 없이 데이터 처리를 수학적 계산으로 취급하려는 패러다임이다. 대규모 병렬처리가 가능하다는 특징이 있으며, 순수하게 함수에 전달된 인자 값만 결과에 영향을 주므로 순수하게 함수로만 작동한다. 상태 값을 갖지 않는다. 프로그램이 동작하는 흐름에서 상태가 변하지 않으면 함수 호출이 서로 간의 간섭이 이루어지지 않고 배타적으로 이루어지므로 병렬처리 시 부작용이 거의 없다. 또한 필요한 만큼 함수를 나누어 처리할 수 있도록 스케일업이 가능하므로 대규모 병렬처리에 강점이 있다.
    * 함수: 일급 객체로서, 다양한 종류의 함수를 호출하고/전달하고/반환하는 동작 만으로도 프로그램을 구현하 수 있다.

* 특징은 안정성(Safe), 신속성(Fast), 더 나은 표현성(Expressive)가 있는데, 수 많은 프로그래밍 언어 각각의 장단점을 참고해 C 언어와 동등한 성능을 일정하게 유지하면서 프로그래머가 저지를 수 있는 실수를 엄격한 문법을 적용해 미연에 방지한다.

* Static Typing + Duck-type System

  * 정적 언어는 변수 또는 함수의 타입을 미리 지정해야 하고, 동적 언어는 사전에 지정하지 않고도 사용할 수 있는데. 가장 큰 차이점은 타입 정보를 지정해야 한다는 점이다.
  * 객체가 객체에게 메시지를 보낸다 > 메시지를 받은 객체가 해당 메소드가 구현되어 있는 곳으로 찾아가서 메소드를 실행한다. 중요한 것은 이 과정이 '런타임'에 일어난다는 것이다. > 매번 실행할 때마다 위 과정을 반복하는데 이것을 런타임에서 하면 성능이 저하될것이다.
  * 컴파일타임에 해당 메소드의 실제 코드위치를 미리 알면 메소드가 어딨는지 찾을 필요도 없고 바로 그 주소로 점프해서 실행하면되겠네? 이럴 경우 **컴파일러의 최적화가 가능**하다고 한다. => **정적(static) 디스패치**
  * 실행 시점에 객체 타입에 따라 동적으로 호출될 대상 메소드를 결정하는 방식을 동적 디스패치(dynamic dispatch)라고 한다. 반면 컴파일 시점에 알려진 변수 타입에 따라 정해진 메소드를 호출하는 방식은 정적 디스패치(static dispatch)라고 한다.

* Type Inference

  * 타입추론은 변수나 상수를 생성 시 데이터 타입을 생략하면, 스위프트 컴파일러가 변수의 값을 확인하고 값에 맞는 타입을 추론하여 타입을 자동으로 지정한다. 어, JavaScript랑 좀 비슷하네...

  ```swift
  var age: Int = 30;
  var age = 30; // 변수값 30을 보고 Int 타입이라고 추론함
  
  var name: String = "Jaeyoung";
  var name = "Jaeyoung"; // 변수값 보고 String 타입으로 추론함
  ```

* Safety
  * Type Safety: string 타입에는 string만 저장됨

### 개발 환경

* Swift: 터미널 및 콘솔 환경에서 REPL을 지원하고, 리눅스 외 Xcode 통합 개발환경을 권장함