# 🌤 SkyDetector

> 현재 위치 기반의 실시간 날씨 및 3시간 단위 기상예보 어플리케이션 개발 어플리케이션 프로젝트
<br>

기간 : 2021.05.15 ~ 06.26 <br>
개발환경 : Xcode 12.5, GitHub <br>
사용 언어 및 기술 : Swift(5.4.2), Storyboard, Codable, Data Task, URLSession, NotificationCenter, GCD, CoreLocation<br>
 
------------------------------------------------------------------------

<br>
 
## 📋 프로젝트 상세내용
 
### 📍 주제
```
  * 현재 위치를 기반으로 실제 날씨와 일기예보 정보제공 어플리케이션
```

 
### ⭐ 개발목적
```
 
  * openAPI 사용하여 JSON 파싱 구현

    - 앱 개발의 핵심이 되는 JSON encode, decode 사용

  * 사용자 위치 기반 기능 구현

    - 사용자의 위치에 따른 앱 구성
 
```

 
### 💻 구현목표
```

  * 실시간 날씨 및 3시간 단위 일기예보
  
  * 날씨에 따른 아이콘 출력
  
  * Codable 프로토콜을 이용한 JSON decode 기능 사용
  
    - openAPI key를 사용하여 실제 날씨 데이터를 실시간으로 사용가능하게 구현

  * CoreLocation을 이용한 위치데이터 사용
    
    - 사용자로부터 위치를 전송받아 지역 날씨 데이터 요청
  
```
<br>
 
## 📱 기능 동작

<img width="49%" src="https://github.com/naldal/readmegifs/blob/master/sg.gif?raw=true"/>
