## CodingConventionRule Rule

### 파일명

#### 스토리보드이름

- Zeplin 이름 기반으로 만들기

#### ViewController

- 스토리보드 이름 기반으로 만들기

#### Cell 이름

- CollectionViewCell 이름 : CVC
- TableViewCell 이름 : TVC

### 코드레이아웃

#### 뷰컨트롤러 코드 순서

이거는 MARK 주석으로 만들어 분류해주면 좋을듯

- IBOutlet 변수
- 자기가 만드는 변수
- 라이프사이클 메소드 (viewDidLoad, viewWillAppear)
- 자기가 만드는 메소드
- @objc 메소드
- IBAction 메소드
- Extension
  - 프로토콜 하나당 하나씩 만들기
  - Extension 안에는 프로토콜에 해당하는 메소드만 구현해 놓기

#### 최대 줄길이

- 99 줄

#### 줄바꿈

- 최대 길이를 초과하는 경우 다음과 같이
- 함수 정의

```swift
func animationController(
  forPresented presented: UIViewController,
  presenting: UIViewController,
  source: UIViewController
) -> UIViewControllerAnimatedTransitioning? {
  // doSomething()
}
```

- 함수 호출

```swift
let actionSheet = UIActionSheet(
  title: "정말 계정을 삭제하실 건가요?",
  delegate: self,
  cancelButtonTitle: "취소",
  destructiveButtonTitle: "삭제해주세요"
)
```

- 클로저 2개 이상 존재하는 경우 무조건 내려쓰기

```swift
UIView.animate(
  withDuration: 0.25,
  animations: {
    // doSomething()
  },
  completion: { finished in
    // doSomething()
  }
)
```

- guard let 구문 다음과 같이 사용

```swift
guard let _  else {
	return
}
```

#### 클로져

```swift
Alamofire.request(APIConstants.loginURL,
                          method: .post,
                          parameters: body,
                          encoding: JSONEncoding.default,
                          headers: header)
            .responseData { response in
                switch response.result {
                case .success:
                    guard let statusCode = response.response?.statusCode else {
                        return
                    }
                    guard let value = response.result.value else {
                        return
                    }
                    completion(self.isCorrectUser(statusCode: statusCode, data: value))
                case .failure(let err):
                    print(err.localizedDescription)
                    completion(.networkFail)
                }
        }
```

- 후행 클로져 의 경우 '파라미터 in' 까지 하고 다음 줄 넘어가서 하기

### 네이밍

#### 클래스

```swift
class Mongle{
}
앞에글자 대문자(UpperCamelCase)
```

#### 함수

```swift
func mongleMongle(){
}
앞에글자 소문자(LowerCamelCase)
```

#### 변수

```swift
var mogleMongle
앞에글자 소문자(LowerCamelCase)
```

#### 열거형

```swift
enum Result {
  case .success
  case .failure
}
enum의 각 case에는 lowerCamelCase를 사용합니다.
```

| UpperCamalCase | lowerCamelCase |
| -------------- | -------------- |
| 클래스         | 함수           |
| 구조체         | 메서드         |
| 익스텐션       | 인스턴스       |
| 프로토콜       |                |
| 열거형         |                |

### 그 외 정할 것들

- API URL

```swift
static let userProfile = BaseURL + **/user/profile**
```

- Cell Identifier

```swift
static let identifier = ""

무슨Cell.identifier <- 이런식으루
```

- UserDefault

```swift
enum UserDefaultKeys: String {
    case token="token"
    case autologinCheck="isAutoLoginChecked"
}

UserDefaultKeys.token.rawValue <- 사용할땐 이런식으루
```
