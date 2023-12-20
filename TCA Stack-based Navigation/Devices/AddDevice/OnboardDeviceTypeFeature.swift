import ComposableArchitecture
import Foundation

@Reducer
struct OnboardDeviceTypeFeature {
    struct FoundDevice: Equatable, Identifiable {
        let id: UUID
        let type: DeviceType
        let signalStrength: Double
    }
    
    @ObservableState
    struct State: Equatable {
        var deviceType: DeviceType
        var devices: IdentifiedArrayOf<FoundDevice>

        init(
            deviceType: DeviceType,
            devices: IdentifiedArrayOf<FoundDevice> = []
        ) {
            self.deviceType = deviceType
            self.devices = devices
        }
    }
    
    enum Action: Equatable {
        case view(ViewAction)
        case `internal`(InternalAction)
        case delegate(DelegateAction)
        
        enum ViewAction: Equatable {
            case didAppear
            case exitButtonTapped
        }
        enum InternalAction: Equatable {
            case foundDevices(IdentifiedArrayOf<FoundDevice>)
        }
        enum DelegateAction: Equatable {
            case onExit
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
                    
                case .exitButtonTapped:
                    return .send(.delegate(.onExit))
                }

            case let .internal(action):
                switch action {
                case let .foundDevices(devices):
                    state.devices = devices
                    return .none
                }
                
            case .delegate:
                return .none
            }
        }
    }
}
