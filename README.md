# 📚 Mongle

![](./docs/asset/monglelogo.png)

## Team Mongle-iOS 👨🏻‍💻🧑🏻‍💻👩🏻‍💻

<img src="./docs/asset/mongles.png" width = 300>

- 김윤재 [qodhrkawk](https://github.com/qodhrkawk)
- 이예슬 [seu11ee](https://github.com/seu11ee)
- 이주혁 [Juhyeoklee](https://github.com/Juhyeoklee)

## 앱 아이콘

<img src="./docs/asset/mongle_symbol.png" width = 200>


## Work-Flow

## 기능

### 탭바 커스텀

<p align=>

</p>

<img src="./docs/asset/yjtab.png" width = 300><img src="./docs/asset/yjtab2.png" width = 300>

## 실행 화면 캡쳐

### 스플래시
<img src="./docs/asset/loginAnim.gif" width = 400>


### 1-1. 로그인
<img src="./docs/asset/login1.png" width = 400><img src="./docs/asset/login2.png" width = 400>
<img src="./docs/asset/login3.png" width = 400>

### 1-2. 회원가입
<img src="./docs/asset/signup1.png" width = 400><img src="./docs/asset/signup2.png" width = 400>
<img src="./docs/asset/signup3.png" width = 400><img src="./docs/asset/signup4.png" width = 400>



### 메인 화면

<img src="./docs/asset/jhmain1.png" width = 300><img src="./docs/asset/jhmain2.png" width = 300>

### 검색

<img src="./docs/asset/yssearch.png" width = 300>

### 큐레이터 리스트

<img src="./docs/asset/yscur.png" width = 300>



## 기능 소개
|담당자|화면|기능 설명| 우선순위| 구현 여부 | 
|:---:|:---:|:-------:|:---:|:---:|
|이주혁|메인 화면 | 메인 화면 구조 만들기 |0순위| O | 
| |  | 스와이프를 이용한 커스텀 탭바 전환 |3순위| O | 
| |  | 테마, 문장, 큐레이터 실시간으로 보여주기 |0순위| O | 
| | 테마 보기 | 테마 상세 정보 화면 |0순위| O | 
| | 문장 보기 | 문장 상세 정보 화면 |0순위| O | 
| |    | 문장 수정 화면 |0순위| O | 
| |  설정  | 회원 프로필 수정 |3순위| O | 
| |    | 앱 정보 화면 |3순위| O | 
| |    | 개발자 정보 화면 |3순위| O | 
| |    | 토스트 팝업 화면 |1순위| O | 
||||||
|이예슬|검색 | 테마 / 문장 /큐레이터 검색 기능 |0순위| O | 
| |  | 최근 키워드 / 추천 키워드 기능 |1순위| O | 
| |  | 검색 결과 창 스와이프로 이동 |3순위| O | 
| | 큐레이터 | 큐레이터 리스트 구현 |0순위| O | 
| |    | 큐레이터 서재 구현 |1순위| O | 
| |    | 추천 큐레이터 제시 |3순위| O | 
| |  내 서재  | 테마 - 생성/저장 테마 탭 구현 |0순위| O | 
| |    |문장 - 생성/저장한 문장 탭 구현 |0순위| O | 
| |    |구독한 큐레이터 탭 구현 |0순위| O | 
| |    |스와이프를 통한 탭바 전환 |2순위| O | 
||||||
|김윤재|스플래시 | 앱 실행 시 애니메이션 실행|1순위| O | 
||회원가입|정상적인 회원 가입 기능|1순위| O| 
||로그인|로그인 기능|1순위| O| 
||하단 탭바|하단 커스턴 탭바 + 플로팅 버튼|0순위| O| 
||테마 만들기|테마 사진 선택|0순위| O| 
|| |잘못된 입력시 피드백 메시지 + 토스트|3순위| O| 
|| | 최종 제출 전 팝업|3순위| O| 
||문장 쓰기| 글자 수 제한 실시간 피드백|0순위| O| 
|| | 책 검색 : Open API 사용|0순위| O| 
|| | 문장을 추가할 테마 선택 기능|0순위| O| 











## 어려웠던 점과 이를 통해 배운 점
### 1. 어려운 상단 탭바 구조
문제점 : 


배운 점 :

### 2. SnapKit 을 통한 Auto Layout

#### 문제점
SnapKit과 Then을 통해 수월하게 auto layout을 잡을 수 있었으나, 상수 값으로 layout을 잡을 떄 기기가 달라지면 비율이
꺠지거나 위치가 너무 치우치는 상황이 발생했음. 

#### 배운 점

해당 문제를 해결하기 위해 다음과 같은 상수를 사용했음.

     let deviceBound = UIScreen.main.bounds.height/812.0

SnapKit을 이용해 코드로 잡아준 Layout은 주로 기기의 height 차이에 의해 발생하는데, 이를 해결하기 위해 위의 상수를
layout constant에 곱해주어 다른 기기에서 알맞게 작용하게 적용했음.











## 📝 [Coding Convention Rule](./docs/CodingConventionRule.md)

## 🤝 [Team Rule](./docs/TeamRule.md)

## Dependencies

```
pod 'Alamofire', '~> 4.8.2'
pod 'Kingfisher', '~> 5.0'
pod 'SnapKit', '~> 5.0.0'
pod 'Then'`
pod 'Hero'
pod 'lottie-ios'
pod 'Gifu'


```
