import SwiftUI
import Combine

final class AppState: ObservableObject {
    // MARK: - Navigation State
    @Published var selectedRole: UserRole? = nil
    @Published var showOnboarding: Bool = true
    
    // MARK: - Session State
    @Published var isAuthenticated: Bool = true // Bypassed for demo
    @Published var currentStore: String = "Maison 01 - Global Flagship"
    
    // MARK: - Global Alert State
    @Published var activeAlert: AtelierAlert? = nil
    
    func selectRole(_ role: UserRole) {
        withAnimation(.spring(response: 0.6, dampingFraction: 0.8)) {
            selectedRole = role
            showOnboarding = false
        }
    }
    
    func resetToOnboarding() {
        withAnimation(.spring(response: 0.6, dampingFraction: 0.8)) {
            selectedRole = nil
            showOnboarding = true
        }
    }
}

struct AtelierAlert: Identifiable {
    let id = UUID()
    let title: String
    let message: String
    let type: AlertType
    
    enum AlertType {
        case info, success, warning, error
    }
}
