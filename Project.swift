import ProjectDescription

let settings: Settings = .settings(configurations: [
    .debug(name: "Debug", xcconfig: .relativeToRoot("PicFeed/Config/Secret.xcconfig")),
    .release(name: "Release", xcconfig: .relativeToRoot("PicFeed/Config/Secret.xcconfig"))
])

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
                    "SERVER_HOST": .string("$(SERVER_HOST)"),
                    "API_KEY" : .string("$(API_KEY)")
                ]
            ),
            sources: ["PicFeed/Sources/**"],
            resources: ["PicFeed/Resources/**"],
            dependencies: [],
            settings: settings
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
