import ComposableArchitecture

struct AddDeviceIntroFeature: Reducer {
    struct State: Equatable {
        
    }
    
    enum Action: Equatable {
        case letsGoButtonTapped
    }
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            return .none
        }
    }
}
