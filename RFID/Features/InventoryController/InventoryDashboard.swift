import SwiftUI

struct InventoryControllerDashboard: View {
    @StateObject var rfidService = RFIDService()
    @State private var scanAnimation = false
    
    var body: some View {
        VStack(spacing: 0) {
            // Header
            VStack(alignment: .leading, spacing: AtelierTheme.spacingXS) {
                LuxuryHeader(title: "Precision RFID Logistics", subtitle: "Inventory Intelligence")
            }
            .padding(.horizontal, AtelierTheme.spacingL)
            
            // Scan Control Card
            GlassCard(glowColor: rfidService.isScanning ? AtelierTheme.success.opacity(0.3) : AtelierTheme.accentGold.opacity(0.1)) {
                HStack {
                    VStack(alignment: .leading, spacing: 4) {
                        Text(rfidService.isScanning ? "SCANNING ACTIVE" : "SCANNER STANDBY")
                            .font(AtelierTypography.secondaryText(12))
                            .foregroundColor(rfidService.isScanning ? AtelierTheme.success : AtelierTheme.accentGold)
                            .kerning(1)
                        Text(rfidService.isScanning ? "\(rfidService.scanStream.count) tags detected in session" : "Ready for cycle count")
                            .font(AtelierTypography.bodyText(14))
                            .foregroundColor(AtelierTheme.textPrimary)
                    }
                    
                    Spacer()
                    
                    Button(action: {
                        rfidService.toggleScan()
                        withAnimation(rfidService.isScanning ? .linear(duration: 2).repeatForever(autoreverses: false) : .default) {
                            scanAnimation = rfidService.isScanning
                        }
                    }) {
                        ZStack {
                            Circle()
                                .stroke(rfidService.isScanning ? AtelierTheme.success : AtelierTheme.accentGold, lineWidth: 2)
                                .frame(width: 60, height: 60)
                            
                            if rfidService.isScanning {
                                Circle()
                                    .stroke(AtelierTheme.success, lineWidth: 2)
                                    .frame(width: 60, height: 60)
                                    .scaleEffect(scanAnimation ? 1.5 : 1.0)
                                    .opacity(scanAnimation ? 0 : 1)
                            }
                            
                            Image(systemName: rfidService.isScanning ? "stop.fill" : "play.fill")
                                .font(.title3)
                                .foregroundColor(rfidService.isScanning ? AtelierTheme.error : AtelierTheme.success)
                        }
                    }
                    .onChange(of: rfidService.isScanning) { newValue in
                        if newValue {
                            withAnimation(.linear(duration: 1.5).repeatForever(autoreverses: false)) {
                                scanAnimation = true
                            }
                        } else {
                            scanAnimation = false
                        }
                    }
                }
            }
            .padding(.horizontal, AtelierTheme.spacingL)
            .padding(.bottom, AtelierTheme.spacingM)
            
            // Live Stream
            VStack(alignment: .leading, spacing: AtelierTheme.spacingM) {
                Text("REAL-TIME RFID STREAM")
                    .font(AtelierTypography.secondaryText(12))
                    .foregroundColor(AtelierTheme.textSecondary)
                    .padding(.horizontal, AtelierTheme.spacingL)
                
                ScrollViewReader { proxy in
                    ScrollView {
                        LazyVStack(spacing: 8) {
                            ForEach(rfidService.scanStream) { event in
                                RFIDEventRow(event: event)
                                    .transition(.asymmetric(insertion: .move(edge: .top).combined(with: .opacity), removal: .opacity))
                            }
                        }
                        .padding(.horizontal, AtelierTheme.spacingL)
                    }
                }
            }
            
            Spacer()
        }
        .background(AtelierTheme.backgroundPrimary.ignoresSafeArea())
    }
}

struct RFIDEventRow: View {
    let event: RFIDEvent
    
    var body: some View {
        HStack(spacing: AtelierTheme.spacingM) {
            Circle()
                .fill(colorForType(event.eventType).opacity(0.2))
                .frame(width: 40, height: 40)
                .overlay(
                    Image(systemName: iconForType(event.eventType))
                        .foregroundColor(colorForType(event.eventType))
                        .font(.system(size: 14))
                )
            
            VStack(alignment: .leading, spacing: 2) {
                Text(event.productName)
                    .font(AtelierTypography.dashboardTitle(14))
                    .foregroundColor(AtelierTheme.textPrimary)
                Text(event.rfidTag)
                    .font(AtelierTypography.secondaryText(10))
                    .foregroundColor(AtelierTheme.textSecondary)
            }
            
            Spacer()
            
            VStack(alignment: .trailing, spacing: 2) {
                Text(event.eventType.rawValue.uppercased())
                    .font(AtelierTypography.secondaryText(10))
                    .foregroundColor(colorForType(event.eventType))
                Text(event.timestamp, format: .dateTime.hour().minute().second())
                    .font(AtelierTypography.secondaryText(10))
                    .foregroundColor(AtelierTheme.textSecondary)
            }
        }
        .padding(AtelierTheme.spacingM)
        .background(AtelierTheme.backgroundDeep.opacity(0.4))
        .cornerRadius(12)
    }
    
    func colorForType(_ type: RFIDEventType) -> Color {
        switch type {
        case .detected: return AtelierTheme.success
        case .moved: return AtelierTheme.accentGold
        case .missing, .unauthorized: return AtelierTheme.error
        case .duplicate: return .gray
        }
    }
    
    func iconForType(_ type: RFIDEventType) -> String {
        switch type {
        case .detected: return "checkmark.circle"
        case .moved: return "arrow.right.circle"
        case .missing: return "questionmark.circle"
        case .duplicate: return "square.on.square"
        case .unauthorized: return "lock.shield"
        }
    }
}
