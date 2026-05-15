import SwiftUI

struct AfterSalesDashboard: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: AtelierTheme.spacingL) {
                LuxuryHeader(title: "Heritage & Care", subtitle: "After-Sales Specialist")
                
                // Repair Stats
                HStack(spacing: AtelierTheme.spacingM) {
                    KPIWidget(title: "Active Repairs", value: "24", trend: nil, icon: "wrench.and.screwdriver")
                    KPIWidget(title: "Ready for QA", value: "6", trend: nil, icon: "checkmark.seal")
                }
                
                // Repair Tickets
                VStack(alignment: .leading, spacing: AtelierTheme.spacingM) {
                    HStack {
                        Text("SERVICE LIFECYCLE")
                            .font(AtelierTypography.secondaryText(14))
                            .foregroundColor(AtelierTheme.textSecondary)
                        Spacer()
                        Text("Filter")
                            .font(AtelierTypography.secondaryText(12))
                            .foregroundColor(AtelierTheme.accentGold)
                    }
                    
                    ForEach(MockDataStore.shared.repairs) { repair in
                        RepairTicketCard(repair: repair)
                    }
                }
                
                // Authentication Tools
                GlassCard {
                    VStack(alignment: .leading, spacing: AtelierTheme.spacingM) {
                        HStack {
                            Image(systemName: "checkmark.shield.fill")
                                .foregroundColor(AtelierTheme.success)
                            Text("AUTHENTICATION WORKFLOW")
                                .font(AtelierTypography.secondaryText(14))
                                .foregroundColor(AtelierTheme.textPrimary)
                        }
                        
                        Text("Scan product RFID tag to verify heritage and ownership certificate.")
                            .font(AtelierTypography.bodyText(14))
                            .foregroundColor(AtelierTheme.textSecondary)
                        
                        Button(action: {}) {
                            HStack {
                                Image(systemName: "qrcode.viewfinder")
                                Text("Verify Authenticity")
                            }
                            .font(AtelierTypography.dashboardTitle(16))
                            .foregroundColor(AtelierTheme.backgroundPrimary)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(AtelierTheme.accentGold)
                            .cornerRadius(12)
                        }
                    }
                }
            }
            .padding(.horizontal, AtelierTheme.spacingL)
            .padding(.bottom, 30)
        }
        .background(AtelierTheme.backgroundPrimary.ignoresSafeArea())
    }
}

struct RepairTicketCard: View {
    let repair: RepairTicket
    
    var body: some View {
        GlassCard {
            VStack(alignment: .leading, spacing: 12) {
                HStack {
                    Text(repair.productName)
                        .font(AtelierTypography.dashboardTitle(18))
                        .foregroundColor(AtelierTheme.textPrimary)
                    Spacer()
                    Text(repair.status)
                        .font(AtelierTypography.secondaryText(10))
                        .foregroundColor(AtelierTheme.accentGold)
                        .padding(.horizontal, 8)
                        .padding(.vertical, 4)
                        .background(Capsule().fill(AtelierTheme.accentGold.opacity(0.1)))
                }
                
                HStack {
                    VStack(alignment: .leading, spacing: 4) {
                        Text("CLIENT")
                            .font(AtelierTypography.secondaryText(10))
                            .foregroundColor(AtelierTheme.textSecondary)
                        Text(repair.clientName)
                            .font(AtelierTypography.secondaryText(14))
                            .foregroundColor(AtelierTheme.textPrimary)
                    }
                    
                    Spacer()
                    
                    VStack(alignment: .trailing, spacing: 4) {
                        Text("ESTIMATED")
                            .font(AtelierTypography.secondaryText(10))
                            .foregroundColor(AtelierTheme.textSecondary)
                        Text(repair.estimatedCompletion, format: .dateTime.month().day())
                            .font(AtelierTypography.secondaryText(14))
                            .foregroundColor(AtelierTheme.textPrimary)
                    }
                }
                
                // Progress Bar
                ProgressView(value: 0.6)
                    .tint(AtelierTheme.accentGold)
                    .background(AtelierTheme.accentGold.opacity(0.1))
                    .padding(.top, 4)
            }
        }
    }
}
