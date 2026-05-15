import SwiftUI
import Combine

final class AppRouter: ObservableObject {
    @Published var path = NavigationPath()
    
    enum Route: Hashable {
        case onboarding
        case dashboard(UserRole)
    }
    
    func navigate(to route: Route) {
        path.append(route)
    }
    
    func pop() {
        path.removeLast()
    }
    
    func popToRoot() {
        path.removeLast(path.count)
    }
}
