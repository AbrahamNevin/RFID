import SwiftUI

struct ProfileView: View {
    @EnvironmentObject var appState: AppState
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        ZStack {
            AtelierTheme.backgroundPrimary.ignoresSafeArea()
            
            VStack(spacing: AtelierTheme.spacingXL) {
                // Profile Header
                VStack(spacing: AtelierTheme.spacingM) {
                    ZStack {
                        Circle()
                            .fill(AtelierTheme.accentGold.opacity(0.1))
                            .frame(width: 100, height: 100)
                        
                        Image(systemName: "person.fill")
                            .font(.system(size: 40))
                            .foregroundColor(AtelierTheme.accentGold)
                    }
                    
                    VStack(spacing: 4) {
                        Text("Jean-Paul Atelier")
                            .font(AtelierTypography.dashboardTitle(24))
                            .foregroundColor(AtelierTheme.textPrimary)
                        
                        Text(appState.selectedRole?.rawValue ?? "Luxury Professional")
                            .font(AtelierTypography.secondaryText(14))
                            .foregroundColor(AtelierTheme.accentGold)
                            .kerning(1)
                    }
                }
                .padding(.top, 40)
                
                // Info Cards
                VStack(spacing: AtelierTheme.spacingM) {
                    ProfileInfoRow(label: "Location", value: appState.currentStore)
                    ProfileInfoRow(label: "Employee ID", value: "AT-94251")
                    ProfileInfoRow(label: "Session", value: "Secure Mock Session")
                }
                .padding(.horizontal, AtelierTheme.spacingL)
                
                Spacer()
                
                // Logout Button
                Button(action: {
                    dismiss()
                    appState.resetToOnboarding()
                }) {
                    HStack {
                        Image(systemName: "rectangle.portrait.and.arrow.right")
                        Text("Sign Out and Switch Role")
                    }
                    .font(AtelierTypography.dashboardTitle(18))
                    .foregroundColor(AtelierTheme.error)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(AtelierTheme.error.opacity(0.1))
                    .cornerRadius(12)
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(AtelierTheme.error.opacity(0.3), lineWidth: 1)
                    )
                }
                .padding(.horizontal, AtelierTheme.spacingL)
                .padding(.bottom, 40)
            }
        }
    }
}

struct ProfileInfoRow: View {
    let label: String
    let value: String
    
    var body: some View {
        HStack {
            Text(label)
                .font(AtelierTypography.secondaryText(14))
                .foregroundColor(AtelierTheme.textSecondary)
            Spacer()
            Text(value)
                .font(AtelierTypography.bodyText(14))
                .foregroundColor(AtelierTheme.textPrimary)
        }
        .padding()
        .background(AtelierTheme.backgroundDeep.opacity(0.4))
        .cornerRadius(12)
    }
}
