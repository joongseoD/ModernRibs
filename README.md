### 1부. 코드 레벨 아키텍처: 재사용 가능한 코드를 만드는 스킬

객체를 작게 만들고, 작은 객체를 조합해서 복잡한 기능으로 합치는 것이 아키텍처의 시작입니다. Massive View Controller, Massive View Model, Massive Interactor는 아키텍처만의 문제가 아니라 개발자의 [composition](https://en.wikipedia.org/wiki/Object_composition) 활용 능력에 따라 달라질 수 있습니다. Composition이 강력한 아키텍처 프레임워크 RIBs를 기반으로 미니 슈퍼앱을 만들어봅니다.

관련1: [스위프트로 다시보는 객체지향 프로그래밍: 피해야할 코딩 습관](https://soojin.ro/blog/solid-principles-in-swift)
<br>
관련2: [개발자와 라면 조리법](https://soojin.ro/blog/programmer-and-ramyun)
<br>
관련3: [google/promises를 활용한 스위프트 비동기 프로그래밍과 에러 핸들링](https://soojin.ro/blog/using-google-promises-swift)

### 2부. 모듈 레벨 아키텍처: 유지 보수와 개발 속도를 고려하는 모듈화

'느슨하게 결합된 모듈 구조'는 '확장성 있는 아키텍처'와 같은 말이나 다름없습니다. 200명의 iOS 앱 개발자가 기여하는 슈퍼앱 그랩, 약 75명이 기여하는 [에어비엔비](https://medium.com/airbnb-engineering/designing-for-productivity-in-a-large-scale-ios-application-9376a430a0bf) 같은 회사의 개발자들이 생산성을 지킬 수 있는 방법입니다. 왜 모듈화를 하면 빌드 시간이 줄어들어서 생산성이 오르는지 원리를 알아보고, 실습을 통해 미니 슈퍼앱에 적용해봅니다.

관련1: [모바일 앱의 느슨한 결합](https://soojin.ro/blog/loose-coupling)
<br>
관련2: [Sourcery 개발자로부터 배우는 모바일 아키텍처와 개발자 경험](https://soojin.ro/blog/pragmatic-programmer)

### 3부. 자동화 테스팅

현업 개발자들이 테스트를 처음 시작하기 어려운 이유는 레거시 코드가 테스트 불가능한 구조로 짜여져 있기 때문입니다. 하지만 실습에서 짜는 코드는 99% 테스트 가능한 코드입니다. 테스트 가능한 코드의 특징을 한번이라도 익히고 직접 테스트를 작성해보면 레거시 코드에 조금씩 도입하기도 쉽습니다. 유닛테스트, 스냅샷테스트, UI테스트, 통합테스트를 작성해봅니다.

관련1: [테스트와 좋은 설계의 관계, 그리고 나쁜 설계의 영향](https://soojin.ro/blog/tests-and-design)
<br>
관련2: [테스트 코드 작성하면 좋은 점](https://soojin.ro/blog/writing-test-code)
<br>
관련3: [uber/RIBs 유닛 테스트 짜기](https://soojin.ro/blog/unit-testing-ribs)
<br>
관련4: [XCTest 소요시간 단축하기](https://soojin.ro/blog/application-library-test)

### 4부. 확장성 있는 인프라: 코드만으로 해결할 수 없는 문제들

확장성 있는 아키텍처를 만들고 유지하려면 코드 뿐 아니라 개발 프로세스도 뒷받침해줘야 합니다. 피쳐플래그와 품질 모니터링을 도입해서 얻을 수 있는 것들과 제가 경험해본 좋은 개발 문화 사례를 공유합니다.

관련1: [앱 안정성을 향한 끊임없는 여정](https://soojin.ro/blog/journey-to-app-stability)
<br>
관련2: [팀워크](https://soojin.ro/blog/teamwork)
<br>
관련3: [개인과 팀이 성장하는 모바일 개발 환경](https://soojin.ro/blog/mobile-platform)
