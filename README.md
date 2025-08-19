🚧 현재 기능은 지속적으로 업데이트 중입니다.

# 사진 분석 서비스 앱

직접 찍은 사진을 AI Agent를 통해 분석하는 기능을 제공하는 iOS 앱입니다.

## ✨ 주요 기능

- 카메라/라이브러리에서 사진 선택 -> AI 분석 -> 결과 표시

## 🧱 기술 스택

- 아키텍처 : MVVM, Feature-by-Feature 분리
- 모듈 분리 및 프로젝트 관리 : Tuist

## 🏗 아키텍처 개요

```
Features
  └─ View ─ ViewModel

Shared
  └─ Networking
  └─ UI (Common UI)

App
  └─ PicFeedApp(main root)
```
