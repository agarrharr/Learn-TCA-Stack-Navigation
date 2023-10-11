import ComposableArchitecture

struct OnboardDeviceTypeFeature: Reducer {
    struct State: Equatable {
        let deviceType: DeviceType
    }
    
    enum Action: Equatable {
    }
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            return .none
        }
    }
}
