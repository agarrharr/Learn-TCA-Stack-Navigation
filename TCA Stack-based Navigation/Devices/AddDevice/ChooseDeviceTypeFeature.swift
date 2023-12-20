import ComposableArchitecture

@Reducer
struct ChooseDeviceTypeFeature {
    @ObservableState
    struct State: Equatable { }
    
    enum Action: Equatable {
        case deviceTypeTapped(DeviceType)
    }
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            return .none
        }
    }
}
