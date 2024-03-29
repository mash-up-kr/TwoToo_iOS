# TwoToo_iOS

## 📒 Document

[유저 스토리](https://github.com/mash-up-kr/TwoToo_iOS/tree/master/Document/User%20Story)

[유저 플로우](https://github.com/mash-up-kr/TwoToo_iOS/tree/master/Document/Chart%20%26%20Diagram/User%20Flow)

[상태 다이어그램](https://github.com/mash-up-kr/TwoToo_iOS/tree/master/Document/Chart%20%26%20Diagram/State%20Diagram)


## ⚙️ Project Setting

템플릿 다운로드 가이드
```
cd ./Templates
make
```

## 🏛️ Structure

```mermaid
graph 
    direction TB
    subgraph Core
        direction TB
        CoreKit
        DesignSystem
        Network
        Util
        Local
        Worker
        Web
    end
    subgraph Scene
        direction TB
        SceneKit
        SplashScene
        LoginScene
        NicknameRegistScene
        InvitationSendScene
        InvitationWaitScene
        MainScene
        HomeScene
        ChallengeEssentialInfoInputScene
        ChallengeAdditionalInfoInputScene
        ChallengeRecommendScene
        ChallengeConfirmScene
        FlowerSelectScene
        ChallengeCreateFinishScene
        ChallengeCertificateScene
        ChallengeHistoryScene
        ChallengeHistoryDetailScene
        NudgeSendScene
        PraiseSendScene
        HistoryScene
        MyInfoScene

        subgraph ChallengeCreateScene_Package
            ChallengeEssentialInfoInputScene
            ChallengeAdditionalInfoInputScene
            ChallengeRecommendScene
        end

    end
    subgraph Main
        direction TB
        TwoToo
    end

    Util -.-> Local
    Util -.-> Network
    Util & Local & Network --> Worker
    Worker & DesignSystem & Web --> CoreKit
    SplashScene & LoginScene & InvitationSendScene & InvitationWaitScene & NicknameRegistScene & MainScene -.-> SceneKit
    HomeScene & HistoryScene & MyInfoScene -.-> MainScene
    ChallengeRecommendScene & ChallengeAdditionalInfoInputScene -.-> ChallengeEssentialInfoInputScene
    ChallengeCreateFinishScene -.-> FlowerSelectScene
    ChallengeHistoryDetailScene -.-> ChallengeHistoryScene
    ChallengeCertificateScene -.-> ChallengeHistoryScene
    ChallengeEssentialInfoInputScene & ChallengeHistoryScene & NudgeSendScene & PraiseSendScene -.-> HomeScene
    ChallengeHistoryScene -.-> HistoryScene
    ChallengeConfirmScene -.-> ChallengeAdditionalInfoInputScene
    FlowerSelectScene -.-> ChallengeConfirmScene
    CoreKit -.-> ChallengeCreateFinishScene & ChallengeRecommendScene & MyInfoScene & PraiseSendScene & ChallengeCertificateScene & ChallengeHistoryDetailScene & NudgeSendScene & SplashScene & LoginScene & InvitationSendScene & InvitationWaitScene & NicknameRegistScene
    SceneKit -.-> TwoToo
```

## 📊 Branch Rule

![Twotoo_branch](https://github.com/mash-up-kr/TwoToo_iOS/assets/39177603/b49ef81d-2980-4a11-b261-2f6b15e24dca)


