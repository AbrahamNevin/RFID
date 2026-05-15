import SwiftUI
import Combine

final class DependencyContainer: ObservableObject {
    static let shared = DependencyContainer()
    
    // Services
    let rfidService: RFIDService
    let aiService: AIService
    let analyticsService: AnalyticsService
    
    init() {
        // Initialize services with dependencies
        self.rfidService = RFIDService()
        self.aiService = AIService()
        self.analyticsService = AnalyticsService()
    }
}
