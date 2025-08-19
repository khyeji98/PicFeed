import SwiftUI

@main
struct PicFeedApp: App {
    private let networkClient = URLSessionClient()
    
    var body: some Scene {
        WindowGroup {
            AnalyzeView(viewModel: AnalyzeViewModel(networkClient: networkClient))
        }
    }
}
