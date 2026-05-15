import Foundation
import Combine

class AnalyticsService: ObservableObject {
    @Published var globalNetRevenue: Double = 42800000.0
    @Published var inventoryAccuracy: Double = 0.9982
    @Published var globalShrinkRate: Double = 0.0014
    
    func refreshStats() {
        // Simulated refresh
        globalNetRevenue += Double.random(in: 1000...5000)
    }
}
