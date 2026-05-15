import SwiftUI
import Combine

@main
struct RFIDApp: App {
    @StateObject private var appState = AppState()
    @StateObject private var container = DependencyContainer.shared
    @StateObject private var router = AppRouter()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(appState)
                .environmentObject(container)
                .environmentObject(router)
                .preferredColorScheme(.dark)
        }
    }
}
