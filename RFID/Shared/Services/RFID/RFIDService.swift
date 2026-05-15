import Foundation
import Combine

class RFIDService: ObservableObject {
    @Published var scanStream: [RFIDEvent] = []
    @Published var isScanning: Bool = false
    
    private var timer: AnyCancellable?
    private let mockData = MockDataStore.shared
    
    func startScanning() {
        isScanning = true
        timer = Timer.publish(every: 1.5, on: .main, in: .common)
            .autoconnect()
            .sink { [weak self] _ in
                self?.generateMockEvent()
            }
    }
    
    func stopScanning() {
        isScanning = false
        timer?.cancel()
    }
    
    private func generateMockEvent() {
        let randomProduct = mockData.products.randomElement()!
        let eventTypes: [RFIDEventType] = [.detected, .detected, .detected, .moved, .missing, .unauthorized]
        let eventType = eventTypes.randomElement()!
        
        let event = RFIDEvent(
            timestamp: Date(),
            rfidTag: randomProduct.rfidTag,
            location: randomProduct.location,
            eventType: eventType,
            productName: randomProduct.name
        )
        
        DispatchQueue.main.async {
            self.scanStream.insert(event, at: 0)
            if self.scanStream.count > 50 {
                self.scanStream.removeLast()
            }
        }
    }
    
    func toggleScan() {
        if isScanning {
            stopScanning()
        } else {
            startScanning()
        }
    }
}
