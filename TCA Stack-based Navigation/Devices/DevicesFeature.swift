import ComposableArchitecture

struct DevicesFeature: Reducer {
    struct Path: Reducer {
        enum State: Equatable {
            case addDeviceIntro(AddDeviceIntroFeature.State)
            case chooseDeviceType(ChooseDeviceTypeFeature.State)
            case onboardDeviceType(OnboardDeviceTypeFeature.State)
        }
        enum Action: Equatable {
            case addDeviceIntro(AddDeviceIntroFeature.Action)
            case chooseDeviceType(ChooseDeviceTypeFeature.Action)
            case onboardDeviceType(OnboardDeviceTypeFeature.Action)
        }
        var body: some ReducerOf<Self> {
            Scope(state: /State.addDeviceIntro, action: /Action.addDeviceIntro) {
                AddDeviceIntroFeature()
            }
            Scope(state: /State.chooseDeviceType, action: /Action.chooseDeviceType) {
                ChooseDeviceTypeFeature()
            }
            Scope(state: /State.onboardDeviceType, action: /Action.onboardDeviceType) {
                OnboardDeviceTypeFeature()
            }
        }
    }
    
    struct State: Equatable {
        var path = StackState<Path.State>()
        var devices: IdentifiedArrayOf<Device>
    }
    
    enum Action {
        case path(StackAction<Path.State, Path.Action>)
        case addDeviceButtonTapped
    }
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .addDeviceButtonTapped:
                state.path.append(.addDeviceIntro(AddDeviceIntroFeature.State()))
                return .none

            case .path(.element(id: _, action: .addDeviceIntro(.letsGoButtonTapped))):
                state.path.append(.chooseDeviceType(ChooseDeviceTypeFeature.State()))
                return .none

            case let .path(.element(id: _, action: .chooseDeviceType(.deviceTypeTapped(deviceType)))):
                state.path.append(.onboardDeviceType(OnboardDeviceTypeFeature.State(deviceType: deviceType)))
                return .none
                
            case let .path(.element(id: _, action: .onboardDeviceType(.delegate(action)))):
                switch action {
                case .onExit:
                    state.path.removeAll()
                    return .none
                }

            case .path:
                return .none
            }
        }
        .forEach(\.path, action: /Action.path) {
            Path()
        }
    }
}
