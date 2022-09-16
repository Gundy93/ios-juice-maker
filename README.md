# 쥬스 메이커

## 📖 목차
1. [소개](#🌱-소개)
2. [타임라인](#📆-타임라인)
3. [시각화된 프로젝트 구조](#👀-시각화된-프로젝트-구조)
4. [트리 다이어그램](#🌳-트리-다이어그램)
5. [실행 화면](#💻-실행-화면)
6. [트러블 슈팅](#❓-트러블-슈팅)
7. [참고 링크](#🔗-참고-링크)

## 🌱 소개

`Gundy`와 `준호`의 iOS 쥬스 메이커 프로젝트입니다.

## 📆 타임라인

<details>
<summary>STEP 1</summary>

220830
- 열거형 `Fruit`
    - 과일을 나타내는 열거형 `Fruit` 추가
- 클래스 `FruitStore`
    - 과일을 저장하는 `inventory` 프로퍼티 추가
    - 수량을 받아 모든 과일을 동일한 수량으로 초기화하는 이니셜라이저 추가
    - `inventory` 프로퍼티에 과일 수량을 추가하는 `add` 메서드 추가
    - `inventory` 프로퍼티에 과일 수량을 감소시키는 `subtract` 메서드 추가
    - 쥬스를 만들 과일 수량이 충분한지 확인하는 `canSubtract` 메서드 추가
    - `Dictionary`를 받아 원하는 과일만 선택적으로 초기화하는 이니셜라이저 추가
    - `add`, `subtract` 메서드에 오류 처리 구문 추가
    - `canSubtract` 메서드 삭제
    - `[Juice.Material]` 배열을 받아 각 과일별 재고가 충분한지 확인하는 `checkStockOfFruits` 메서드 추가
    - `inventory` 프로퍼티의 값을 변경하는 `changeStock` 메서드 추가
    - `add`, `subtract` 메서드에서 `changeStock` 호출해 값을 변경하는 것으로 수정
- 열거형 `Juice`
    - 쥬스를 나타내는 열거형 `Juice` 추가
    - 쥬스의 재료가 될 과일과 수량을 담을 중첩 구조체 `Material` 추가
    - 쥬스 case별로 `Material` 값으로 반환하는 `recipe` 연산 프로퍼티 추가
- 구조체 `JuiceMaker`
    - 과일을 받을 `fruitStore` 프로퍼티 추가
    - `fruitStore` 프로퍼티의 `canSubtract` 메서드와 `subtract` 메서드를 호출해 쥬스를 만드는 `makeJuice` 메서드 추가
    - `FruitStore`의 인스턴스를 받아 `fruitStore` 프로퍼티를 초기화하는 이니셜라이저 생성
    - `makeJuice` 메서드에 오류처리 구문 추가
    - `makeJuice` 메서드에서 호출할 재고 확인 메서드를 `checkStockOfFruits` 메서드로 변경
    - `makeJuice` 메서드에서 호출할 과일 수량 변경 메서드를 `changeStock` 메서드로 변경
- 에러타입 `FruitStoreError`
    - 에러 프로토콜을 준수하는 열거형 `FruitStoreError` 추가
    - 에러가 던져진 이유를 설명하는 `failureReason` 연산 프로퍼티 추가
    - 재고가 부족한 경우인 `outOfStock` 케이스 추가
</details>
<details>
<summary>STEP 1 1차 Feedback 반영</summary>

220901
- 네이밍
    - `add` 메서드 `increaseStock`으로 네이밍 변경
    - `subtract` 메서드 `decreaseStock`으로 네이밍 변경
    - `changeStock(of fruit: Fruit, amount: Int)` 메서드 `changeStock(of fruit: Fruit, by amount: Int)`로 아규먼트 레이블 변경
    - `checkStockOfFruits` 메서드 `checkStockOfIngredients`로 네이밍 변경
    - `makeJuice` 메서드 `make(_ juice: Juice)`로 네이밍 변경
    - 에러타입 `FruitStoreError`의 `wrongAmount` 케이스 `invalidAmount`로 네이밍 변경
    - 열거형 `Juice`의 모든 케이스 뒤에 Juice 붙이는 것으로 네이밍 변경
    - 열거형 `Juice` 내부의 중첩타입 `Material` 구조체 `Ingredient`로 네이밍 변경
- 메서드
    - 현재 재고를 가져오는 `getCurrentStock` 메서드 추가
    - 재고가 충분한 지 확인하는 `checkInventoryHasStock` 메서드 추가
    - `checkStockOfIngredients` 메서드 내부의 재고 확인 기능을 `checkInventoryHasStock` 메서드 호출로 변경
- 은닉화
    - `inventory` 프로퍼티를 `private(set)` 에서 `private`로 변경
</details>
<details>
<summary>STEP 1 2차 Feedback 반영</summary>

220902
- 창고 내부 과일 목록에 있는지 확인해 Bool값을 반환하는 `isInventoryFruitsListHas` 메서드 추가
- `increase` 메서드 내부 재고 확인 기능 `isInventoryFruitsListHas` 메서드 호출로 변경
- 에러타입 `FruitStoreError`의 `notInFruitList` 케이스 `notInInventoryFruitList`로 네이밍 변경
- 에러타입 `FruitStoreError`의 `failureReason` 프로퍼티의 switch 구문 내부 `notInInventoryFruitList` 케이스 반환 문자열 변경
- `checkInventoryHasStock` 메서드 은닉화
- `isInventoryFruitsListHas` 메서드 은닉화
</details>
<details>
<summary>STEP 2</summary>

220905
- 뷰 컨트롤러 `StockEditViewController`
    - 재고를 수정하는 `StockEditViewController` 추가
    - 버튼이 눌려졌을 때 화면을 dismiss하는 `touchUpDismissButton` 메서드 추가
- 클래스 `FruitStore`
    - 기존 `getCurrentStock` 메서드 `currentStock`으로 네이밍 변경
- 뷰 컨트롤러 `ViewController`
    - 쥬스 완성시 얼럿 메시지를 표시하는 `showOkayAlert` 메서드 추가
    - 재고 부족시 얼럿 메시지를 표시하는 `showStockEditAlert` 메서드 추가
    - 각 주문 버튼 터치시 쥬스를 만드는 `touchUpJuiceOrderButton` 메서드 추가
    - 재고 추가 화면 관련 전환하는 `presentStockEditView` 메서드 추가
- 에러타입 `FruitStoreError`
    - `unexpectedError` 케이스 추가
    - `failureReason` 프로퍼티에 `unexpectedError` 케이스 추가
- 열거형 `Juice`
    - 쥬스별 이름을 반환하는 `name` 프로퍼티 추가
- 구조체 `JuiceMaker`
    - `make` 메서드에 `Result`타입 반환으로 수정
    
220906
- 뷰 컨트롤러 `ViewController`
    - 화면의 재고 레이블 데이터를 변경하는 updateFruitStockLabel` 메서드 추가
    - `FruitStore` 타입의 `fruitStore` 프로퍼티 추가
    - `JuiceMaker` 타입의 `juiceMaker` 프로퍼티 추가
</details>
<details>
<summary>STEP 2 Feedback 반영</summary>
    
220907
- 뷰 컨트롤러 `ViewController`
    - 버튼에서 주문하는 주스가 무엇인지 반환하는 `juice` 메서드 추가
    - `touchUpJuiceOrderButton` 메서드에서 `juice` 메서드 호출하는 것으로 변경
    - 기존 매직 리터럴을 `AlertText`의 프로퍼티로 대체
    - 메시지와 가변 매개변수로 얼럿을 띄우는 `showAlert` 메서드 추가
    - `showOkayAlert` 메서드와 `showStockEditAlert` 메서드에서 `showAlert` 메서드 호출하는 것으로 변경
    - `juiceMaker` 프로퍼티의 `make` 메서드 호출 시 반환이 failure일 때, 오류에 맞는 얼럿 메서드 호출하는 것으로 수정
- 에러타입 `FruitStoreError`
    - `failureReason` 프로퍼티 `localizedDescription`으로 네이밍 변경
    - `notInInventoryFruitList` 케이스일 때 재고의 nil을 표현하기 위한 `notExist` 프로퍼티 추가
- 열거형 `AlertText`
    - 얼럿 관련 메서드에서 사용하던 기존 매직 리터럴을 담을 `AlertText` 열거형 추가
- 구조체 `JuiceMaker`
    - `make` 메서드에서 catch하지 않는 `invalidAmount` 에러 캐치구문 삭제
</details>
<details>
<summary>STEP 3</summary>
    
220912
- 뷰 컨트롤러 `StockEditViewController`
    - 네비게이션 바 추가하여 타이틀 `재고 수정`으로 변경
    - 과일의 현재 재고로 레이블을 업데이트 하는 `updateFruitStockLabel` 메서드 추가
    - `FruitStoreDelegate?` 타입의 `delegate` 프로퍼티 추가
    - 스텝퍼를 이용해 재고 레이블을 수정하는 `touchUpStepper` 메서드 추가
    - 스텝퍼를 통해 입력되는 값을 이용해 재고 수량을 변경하는 `changeStock` 메서드 추가
    - `updateFruitStockLabel` 메서드에 재고가 nil일시 연관된 스텝퍼를 비활성화하는 기능 추가
- 뷰 컨트롤러 `ViewController`
    - `FruitStoreDelegate` 프로토콜 채택
    - `presentStockEditView` 메서드에서 present하는 컨트롤러를 `stockEditViewController`의 네비게션 컨트롤러로 변경
    - `presentStockEditView` 메서드에서         `stockEditViewController`의 `delegate` 프로퍼티를 self로 설정
    - 재고가 nil인 과일의 쥬스 주문 버튼을 눌렀을 때 재고 목록에 과일을 추가할 수 있는 `showAddFruitsAlert` 메서드 추가
    - 작은 화면일 때 쥬스 주문 버튼의 타이틀 레이블 폰트 사이즈를 딱 맞게 줄여주는 `fitText` 메서드 추가
- 프로토콜 `FruitStoreDelegate`
    - `FruitStore` 타입의 `fruitStore` 프로퍼티를 갖는 `FruitStoreDelegate` 프로토콜 추가
- 클래스 `FruitStore`
    - 쥬스의 재료중 재고가 nil인 과일을 추가하는 `addFruit` 메서드 추가
</details>
<details>
<summary>STEP 3 Feedback 1차 반영</summary>
    
220914
- 열거형 `Fruit`
    - `Int` 타입의 원시값 추가
- 뷰 컨트롤러 `StockEditViewController`
    - 과일 재고 레이블의 태그를 각 과일의 원시값으로 설정
    - 과일 재고 스텝퍼의 태그를 각 과일의 원시값을 음수로 변경하여 설정
    - 메서드의 레이블을 변경하는 `updateFruitStockLabel` 메서드 추가
    - 스텝퍼의 상태 변경을 하는 `updateFruitStockStepper` 메서드 추가
    - `updateFruitStock` 메서드에서 `updateFruitStockLabel` 메서드와 `updateFruitStockStepper` 메서드를 호출하는 것으로 변경
- 뷰 컨트롤러 `ViewController`
    - `fitText` 메서드 `adjustFontSizeOfButtonsToFitWidth`로 네이밍 변경
- 열거형 `Fruit`
    - `addFruit` 메서드 `addNewFruitsOf(_ fruitList: [Fruit])`로 네이밍 변경
</details>

<details>
<summary>STEP 3 Feedback 2차 반영</summary>
    
220916
- 열거형 `Juice`
    - `Int` 타입 원시값 추가
- 뷰 컨트롤러 `ViewController`
    - 쥬스 주문 버튼을 담을 배열 `juiceOrderButtons` 프로퍼티 추가
    - 과일 재고 레이블을 담을 배열 `fruitStockLabels` 프로퍼티 추가
    - `juice` 메서드 switch 구문을 `juiceOrderButtons`의 인덱스와 과일의 원시값을 활용하는 방법으로 변경
    - `updateFruitStockLabel` 메서드의 반복되는 if-else 구문을 `fruitStockLabels`와 쥬스의 원시값을 통한 for-in 구문으로 변경
    - `presentStockEditView` 메서드에서 `stockEditViewController.delegate`에 할당하는 대상이 `self.fruitStore`로 변경
- 뷰 컨트롤러 `StockEditViewController`
    - 과일 재고 레이블을 담을 배열 `fruitStockLabels` 프로퍼티 추가
    - 과일 재고 스텝퍼를 담을 배열 `fruitStockStepper` 프로퍼티 추가
    - 스텝퍼에서 수정하는 과일이 무엇인지 반환하는 `fruit(of stepper: UIStepper) 메서드 추가
    - `touchUpStepper` 메서드의 switch case 기능을 `fruit` 메서드 호출로 변경
    - `viewWithTag`로 레이블과 스테퍼를 특정하던 기능을 `fruitStockLabels`, `fruitStockSteppers` 배열 및 인덱스를 활용한 방법으로 변경
- 프로토콜 `FruitStoreDelegate`
    - `currentStock(of fruit: Fruit) throws -> Int` 메서드 추가
    - `changeStock(of fruit: Fruit, by amount: Int)` 메서드 추가
    - `fruitStore` 프로퍼티 삭제
- 클래스 `FruitStore`
    - `FruitStoreDelegate` 프로토콜 채택
</details>

## 👀 시각화된 프로젝트 구조
![](https://i.imgur.com/1Exb3Cg.png)

## 🌳 트리 다이어그램
```
JuiceMaker.xcodeproj
└── JuiceMaker
    ├── Controller
    |   └── AppDelegate.swift
    │   └── SceneDelegate.swift
    │   └── ViewController.swift
    │   └── StockEditViewController.swift
    ├── Model
    │   └── AlertText.swift
    │   └── Fruit.swift
    │   └── FruitStore.swift
    │   └── FruitStoreError.swift
    │   └── FruitStoreDelegate.swift
    │   └── Juice.swift
    │   └── JuiceMaker.swift
    └── View
        └── Main.storyboard
        └── Assets.xcassets
        └── LaunchScreen.storyboard
```

## 💻 실행 화면

![](https://i.imgur.com/RhlUyym.gif)


## ❓ 트러블 슈팅

<details>
<summary>딕셔너리의 값</summary>

클래스 FruitStore 내부의 프로퍼티 inventory를 딕셔너리로 결정하였기 때문에, 과일의 현재 수량에 접근하려고 하면 항상 옵셔널인 것이 문제였습니다. increasStock, decreaseStock 등의 메서드에서 이 값에 접근할 때 닐 병합 연산자를 사용할지 고민을 하였는데, 닐 병합연산자를 사용한다면 nil일 때 해당 과일의 잔여 수량을 0으로 설정해야해서 이 부분이 자연스럽지 않았습니다. 옵셔널 바인딩을 통해 인벤토리에 해당 과일 키가 있는지 구분하여 추가하는 방식으로 고민해본 결과 0 등의 매직 넘버를 사용하지 않고 해결할 수 있었습니다.
</details>
<details>
<summary>조건 확인</summary>

두 과일을 사용하는 딸기바나나, 망고키위 주스의 경우 한 과일이 재고가 충분하더라도 다른 과일이 불충분하면 만들 수 없어야 했습니다. 한 과일의 재료가 충분한지 확인하고 수량을 변경시켰었는데, 이 때 다른 과일이 부족한 경우가 발생했습니다. 이 문제를 해결하기 위해 클래스 FruitStore 내부에 checkStockOfIngredients 메서드를 생성해 실행한 결과 재료가 되는 과일 배열이 모두 충분할 때 쥬스를 만들게 했습니다.

</details>
<details>
<summary>이니셜라이저</summary>
 
클래스 FruitStore는 각 과일의 초기 재고가 10개로 요구되어 있어 모든 과일을 같은 수량으로 초기화하는 이니셜라이저를 만들었습니다. 하지만 꼭 모든 과일을 원하지 않을 수도 있고, 과일 별로 수량을 맞추지 않을 수도 있다고 생각했습니다. 과일 종류와 수량을 원하는 값으로도 초기화 할 수 있도록 이니셜라이저를 하나 더 추가하였습니다.
</details>
<details>
<summary>오류 처리</summary>
    
 쥬스메이커 인스턴스가 쥬스를 만들 때 canSubtract 메서드로 확인해서 오류를 미연에 방지하기 때문에 보통의 경우 오류가 없을 것이라고 생각했지만, 쥬스메이커를 거치지않고 인스턴스 fruitStore의 add, subtract 메서드에 직접 접근하는 경우가 있을 수 있다고 생각해 add, subtract 메서드에만 오류 처리를 하였습니다. 하지만 쥬스를 만드는 make 메서드도 오류를 캐치해야한다고 생각했습니다. 지금의 checkStockOfIngredients 메서드를 만들고, make 메서드 내부에서 try 키워드가 두번 사용되지 않도록 과일 재고 수량을 변경하는 기능을 changStock 메서드로 분리해 increasStock(기존 add), decreaseStock(기존 subtract), make 메서드에서 호출하게 했습니다.   
</details>
<details>
<summary>기능 분리</summary>
    
getCurrentStock 메서드는 과일 재고량을 가져오면서 창고 과일 목록에 해당 과일이 없으면 오류를 던집니다. increaseStock 메서드에서는 목록에 과일이 있는지 확인하는 기능만 필요해서 getCurrentStock 메서드를 사용하는 건 적절하지 않았습니다. 목록에 과일이 있는지 판단해서 Bool 타입으로 반환해주는 isInventoryFruitsListHas 메서드를 추가 한 뒤, increaseStock 메서드에서 호출하도록 수정했습니다.
</details>
<details>
<summary>Delegate</summary>
    
StockEditViewController에서 ViewController에 있는 fruitStore의 재고 확인(currentStock), 수정(changeStock) 메서드를 호출해야 했습니다. 알림을 보내주는 NotificationCenter보다 Delegate 패턴이 이 경우에 더 적절하다고 생각했습니다. currentStock, changeStock 메서드를 요구하는 FruitStoreDelegate 프로토콜을 추가했습니다. FruitStore에서 FruitStoreDelegate를 채택했습니다. StockEditViewController에 FruitStoreDelegate 타입의 delegate 프로퍼티를 추가했습니다.
</details>
<details>
<summary>UIView 접근방법</summary>

ViewController의 updateFruitStockLabel 메서드와 StockEditViewController의 updateFruitStockLabel, updateFruitStockStepper 메서드는 Label의 text / Stepper의 value를 재고에 맞게 업데이트합니다. 처음에는 모든 Label과 Stepper를 @IBOutlet 변수를 사용해서 접근했습니다. 코드 중복을 없애려고 tag를 사용해 접근하는 방법을 고민해보았습니다. 최종적으로는 UILabel/UIStepper을 담은 배열을 @IBOutlet 변수로 선언해서 열거형 Fruit의 rawValue로 접근하도록 했습니다.
</details>
        
## 🔗 참고 링크

- Swift API Design Guidelines
    - [naming](https://www.swift.org/documentation/api-design-guidelines/#naming)
- Swift Language Guide
    - [Initialization](https://docs.swift.org/swift-book/LanguageGuide/Initialization.html)
    - [Access Control](https://docs.swift.org/swift-book/LanguageGuide/AccessControl.html)
    - [Nested Types](https://docs.swift.org/swift-book/LanguageGuide/NestedTypes.html)
    - [Type Casting](https://docs.swift.org/swift-book/LanguageGuide/TypeCasting.html)
    - [Error Handling](https://docs.swift.org/swift-book/LanguageGuide/ErrorHandling.html)
    - [Protocols](https://docs.swift.org/swift-book/LanguageGuide/Protocols.html)

---

[🔝 맨 위로 이동하기](#쥬스-메이커)
