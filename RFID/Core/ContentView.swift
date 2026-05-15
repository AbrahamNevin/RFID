import SwiftUI

struct ContentView: View {
    @EnvironmentObject var appState: AppState
    
    var body: some View {
        ZStack {
            if appState.showOnboarding {
                OnboardingView()
                    .transition(.opacity)
            } else {
                RoleRootView(role: appState.selectedRole)
                    .transition(.asymmetric(insertion: .move(edge: .trailing), removal: .move(edge: .leading)))
            }
        }
        .animation(.spring(response: 0.6, dampingFraction: 0.8), value: appState.showOnboarding)
    }
}

struct RoleRootView: View {
    let role: UserRole?
    @EnvironmentObject var appState: AppState
    @State private var showProfile = false
    
    var body: some View {
        NavigationView {
            ZStack {
                switch role {
                case .corporateAdmin:
                    CorporateAdminDashboard()
                case .boutiqueManager:
                    BoutiqueManagerDashboard()
                case .salesAssociate:
                    SalesAssociateDashboard()
                case .inventoryController:
                    InventoryControllerDashboard()
                case .afterSalesSpecialist:
                    AfterSalesDashboard()
                case .none:
                    Text("No Role Selected")
                }
            }
            .navigationBarItems(
                leading: Button(action: { appState.resetToOnboarding() }) {
                    HStack(spacing: 4) {
                        Image(systemName: "chevron.left")
                        Text("Roles")
                    }
                    .foregroundColor(AtelierTheme.accentGold)
                },
                trailing: Button(action: { showProfile = true }) {
                    Image(systemName: "person.circle.fill")
                        .font(.title3)
                        .foregroundColor(AtelierTheme.accentGold)
                }
            )
            .navigationBarTitleDisplayMode(.inline)
            .sheet(isPresented: $showProfile) {
                ProfileView()
            }
        }
    }
}
