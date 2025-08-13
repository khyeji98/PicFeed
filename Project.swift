import ProjectDescription

let project = Project(
    name: "PicFeed",
    targets: [
        .target(
            name: "PicFeed",
            destinations: .iOS,
            product: .app,
            bundleId: "dev.tuist.PicFeed",
            infoPlist: .extendingDefault(
                with: [
                    "UILaunchScreen": [
                        "UIColorName": "",
                        "UIImageName": "",
                    ],
                ]
            ),
            sources: ["PicFeed/Sources/**"],
            resources: ["PicFeed/Resources/**"],
            dependencies: []
        ),
        .target(
            name: "PicFeedTests",
            destinations: .iOS,
            product: .unitTests,
            bundleId: "dev.tuist.PicFeedTests",
            infoPlist: .default,
            sources: ["PicFeed/Tests/**"],
            resources: [],
            dependencies: [.target(name: "PicFeed")]
        ),
    ]
)
