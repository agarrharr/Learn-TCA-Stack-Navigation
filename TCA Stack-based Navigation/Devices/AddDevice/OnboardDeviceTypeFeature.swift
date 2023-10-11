import ComposableArchitecture
import Foundation

struct OnboardDeviceTypeFeature: Reducer {
    struct FoundDevice: Equatable, Identifiable {
        let id: UUID
        let type: DeviceType
        let signalStrength: Double
    }
    
    struct State: Equatable {
        var deviceType: DeviceType
        var devices: IdentifiedArrayOf<FoundDevice> = []
    }
    
    enum Action: Equatable {
        case view(ViewAction)
        case `internal`(InternalAction)
        
        enum ViewAction: Equatable {
            case didAppear
        }
        enum InternalAction: Equatable {
            case foundDevices(IdentifiedArrayOf<FoundDevice>)
        }
    }
    
    @Dependency(\.mainQueue) var mainQueue
    @Dependency(\.uuid) var uuid
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case let .view(action):
                switch action {
                case .didAppear:
                    return .run { [deviceType = state.deviceType] send in
                        try await self.mainQueue.sleep(for: 1.0)
                        await send(.internal(.foundDevices([
                            FoundDevice(
                                id: self.uuid(),
                                type: deviceType,
                                signalStrength: 1.0
                            ),
                            FoundDevice(
                                id: self.uuid(),
                                type: deviceType,
                                signalStrength: 0.7
                            ),
                        ])))
                    }
                }

            case let .internal(action):
                switch action {
                case let .foundDevices(devices):
                    state.devices = devices
                    return .none
                }
            }
        }
    }
}
