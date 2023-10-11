import Foundation

struct Device: Equatable, Identifiable {
    let id: UUID
    let name: String
    let type: DeviceType
}

enum DeviceType: CustomStringConvertible {
    case v1
    case v2
    case pro
    
    var description: String {
        switch self {
        case .v1:
            "V1"
        case .v2:
            "V2"
        case .pro:
            "Pro"
        }
    }
}
