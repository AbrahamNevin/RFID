import Foundation
import Combine

enum AtelierEvent {
    case rfidScan(RFIDEvent)
    case inventoryDiscrepancy(String)
    case aiInsight(String)
    case systemAlert(String)
}

final class AtelierEventBus {
    static let shared = AtelierEventBus()
    
    private let subject = PassthroughSubject<AtelierEvent, Never>()
    
    var publisher: AnyPublisher<AtelierEvent, Never> {
        subject.eraseToAnyPublisher()
    }
    
    func publish(_ event: AtelierEvent) {
        subject.send(event)
    }
}
