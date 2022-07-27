# AsyncAwait

## Swift Concurrency

https://docs.swift.org/swift-book/LanguageGuide/Concurrency.html
swift 5.7부터 사용 가능, URLSession.shared.data(from:) 메소드 15.0부터 지원.

<img width="1282" alt="스크린샷 2022-07-27 오후 4 34 11" src="https://user-images.githubusercontent.com/62687919/181188866-6d46acc1-bf4b-4d04-83f1-3fbfafd8d0a1.png">

```swift
let dataArray: [Data] = []
let data = try await URLSession.shared.data(from: url).0
dataArray.append(data)
```
1. 데이터를 요청한다.
2. 작업중이던 3번 쓰레드의 제어권을 놓아준다. Suspend된다.
3. 데이터를 가져오면 이를 작업할 쓰레드를 시스템에 요청한다.
4. 5번 쓰레드가 나머지 작업을 처리한다.

### Actor
경쟁상태를 알아서 처리해주는 스위프트의 타입 (class와 매우 유사)

```swift
actor ViewModelState {
    var updateDoodles: ((Data) -> ())?
    func setUpdateDoodles(_ updateDoodles: ((Data) -> ())?) {
        self.updateDoodles = updateDoodles
    }
    
    var doodleImages: [Data] = [] {
        willSet(value) {
            updateDoodles?(value.last!)
        }
    }
    func appendImageData(_ data: Data) {
        doodleImages.append(data)
    }
}
```

## 전체 구조입니다.
<img width="1241" alt="스크린샷 2022-07-27 오후 4 41 59" src="https://user-images.githubusercontent.com/62687919/181190474-841189b2-ff89-413d-894c-02a2a0c50ee1.png">

- MVVM을 사용하였습니다.
