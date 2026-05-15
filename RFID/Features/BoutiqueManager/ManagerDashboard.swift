import SwiftUI

struct BoutiqueManagerDashboard: View {
    @EnvironmentObject var appState: AppState
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: AtelierTheme.spacingL) {
                LuxuryHeader(title: "Maison 01 Command Center", subtitle: "Boutique Management")
                
                // Quick Actions
                StoreQuickActions()
                
                // Live Alerts
                AlertPanel()
                
                // Appointments
                UpcomingAppointmentsSection()
                
                // Inventory Overview
                StoreInventoryStatusCard()
            }
            .padding(.horizontal, AtelierTheme.spacingL)
            .padding(.bottom, 30)
        }
        .background(AtelierTheme.backgroundPrimary.ignoresSafeArea())
    }
}

// MARK: - Sub-Components

struct StoreQuickActions: View {
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: AtelierTheme.spacingM) {
                QuickActionBtn(title: "Launch Scan", icon: "antenna.radiowaves.left.and.right")
                QuickActionBtn(title: "VIP Visit", icon: "star.fill")
                QuickActionBtn(title: "Transfers", icon: "arrow.left.arrow.right")
                QuickActionBtn(title: "Event Mode", icon: "sparkles")
            }
            .padding(.horizontal, AtelierTheme.spacingL)
        }
        .padding(.horizontal, -AtelierTheme.spacingL)
    }
}

struct AlertPanel: View {
    var body: some View {
        GlassCard(glowColor: AtelierTheme.error.opacity(0.15)) {
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text("CRITICAL ALERT")
                        .font(AtelierTypography.secondaryText(12))
                        .foregroundColor(AtelierTheme.error)
                        .kerning(1)
                    Text("Unauthorized movement detected in Vault B.")
                        .font(AtelierTypography.bodyText(14))
                        .foregroundColor(AtelierTheme.textPrimary)
                }
                Spacer()
                Image(systemName: "exclamationmark.triangle.fill")
                    .foregroundColor(AtelierTheme.error)
                    .font(.title2)
            }
        }
    }
}

struct UpcomingAppointmentsSection: View {
    var body: some View {
        VStack(alignment: .leading, spacing: AtelierTheme.spacingM) {
            HStack {
                Text("TODAY'S APPOINTMENTS")
                    .font(AtelierTypography.secondaryText(14))
                    .foregroundColor(AtelierTheme.textSecondary)
                Spacer()
                Text("View All")
                    .font(AtelierTypography.secondaryText(12))
                    .foregroundColor(AtelierTheme.accentGold)
            }
            
            ForEach(MockDataStore.shared.appointments) { appointment in
                AppointmentCard(appointment: appointment)
            }
        }
    }
}

struct StoreInventoryStatusCard: View {
    var body: some View {
        GlassCard {
            VStack(alignment: .leading, spacing: AtelierTheme.spacingM) {
                Text("STORE INVENTORY OVERVIEW")
                    .font(AtelierTypography.secondaryText(14))
                    .foregroundColor(AtelierTheme.textSecondary)
                
                HStack(spacing: 40) {
                    InventoryStat(label: "In Stock", value: "1,240", color: AtelierTheme.success)
                    InventoryStat(label: "On Display", value: "342", color: AtelierTheme.accentGold)
                    InventoryStat(label: "In Service", value: "18", color: AtelierTheme.textSecondary)
                }
            }
        }
    }
}

struct QuickActionBtn: View {
    let title: String
    let icon: String
    
    var body: some View {
        VStack(spacing: 8) {
            Circle()
                .fill(AtelierTheme.backgroundDeep)
                .frame(width: 64, height: 64)
                .overlay(
                    Image(systemName: icon)
                        .foregroundColor(AtelierTheme.accentGold)
                        .font(.title3)
                )
            Text(title)
                .font(AtelierTypography.secondaryText(12))
                .foregroundColor(AtelierTheme.textPrimary)
        }
    }
}

struct AppointmentCard: View {
    let appointment: Appointment
    
    var body: some View {
        HStack(spacing: AtelierTheme.spacingM) {
            VStack {
                Text(appointment.time, format: .dateTime.hour().minute())
                    .font(AtelierTypography.dashboardTitle(16))
                    .foregroundColor(AtelierTheme.textPrimary)
            }
            .frame(width: 70)
            
            Rectangle()
                .fill(AtelierTheme.accentGold.opacity(0.3))
                .frame(width: 1)
            
            VStack(alignment: .leading, spacing: 2) {
                Text(appointment.clientName)
                    .font(AtelierTypography.dashboardTitle(16))
                    .foregroundColor(AtelierTheme.textPrimary)
                Text(appointment.type)
                    .font(AtelierTypography.secondaryText(12))
                    .foregroundColor(AtelierTheme.accentGold)
                Text("Associate: \(appointment.staffName)")
                    .font(AtelierTypography.secondaryText(11))
                    .foregroundColor(AtelierTheme.textSecondary)
            }
            
            Spacer()
            
            Image(systemName: "chevron.right")
                .foregroundColor(AtelierTheme.textSecondary.opacity(0.5))
        }
        .padding(AtelierTheme.spacingM)
        .background(AtelierTheme.backgroundDeep.opacity(0.4))
        .cornerRadius(16)
    }
}

struct InventoryStat: View {
    let label: String
    let value: String
    let color: Color
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(value)
                .font(AtelierTypography.dashboardTitle(20))
                .foregroundColor(AtelierTheme.textPrimary)
            HStack(spacing: 4) {
                Circle().fill(color).frame(width: 6, height: 6)
                Text(label)
                    .font(AtelierTypography.secondaryText(10))
                    .foregroundColor(AtelierTheme.textSecondary)
            }
        }
    }
}
