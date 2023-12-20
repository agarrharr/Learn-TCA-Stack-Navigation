import ComposableArchitecture

@Reducer
struct AddDeviceIntroFeature {
    @ObservableState
    struct State: Equatable {}
    
    enum Action: Equatable {
        case letsGoButtonTapped
    }
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            return .none
        }
    }
}
