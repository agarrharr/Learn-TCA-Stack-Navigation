import ComposableArchitecture
import SwiftUI

struct Device: Equatable, Identifiable {
  let id: UUID
  var name: String
}

struct DevicesFeature: Reducer {
    struct Path: Reducer {
        enum State: Equatable {
            case addDevice(AddDeviceFeature.State)
        }
        enum Action: Equatable {
            case addDevice(AddDeviceFeature.Action)
        }
        var body: some ReducerOf<Self> {
            Scope(state: /State.addDevice, action: /Action.addDevice) {
                AddDeviceFeature()
            }
        }
    }
    
    struct State: Equatable {
        var path = StackState<Path.State>()
        var devices: IdentifiedArrayOf<Device>
    }
    
    enum Action {
        case path(StackAction<Path.State, Path.Action>)
        case addDeviceAdded
    }
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .addDeviceAdded:
                return .none
            case .path:
                return .none
            }
        }
        .forEach(\.path, action: /Action.path) {
            Path()
        }
    }
}

struct DevicesView: View {
    let store: StoreOf<DevicesFeature>
    
    var body: some View {
        NavigationStackStore(
            self.store.scope(state: \.path, action: { .path($0) })
        ) {
            WithViewStore(store, observe: { $0 }) { viewStore in
                VStack {
                    List {
                        ForEach(viewStore.state.devices) { device in
                            Text(device.name)
                        }
                    }
                    Button("Add device") {
                        print("add device tapped")
                    }
                    
                }
                .padding()
            }
        } destination: { state in
            switch state {
            case .addDevice:
                CaseLet(
                    /DevicesFeature.Path.State.addDevice,
                     action: DevicesFeature.Path.Action.addDevice,
                     then: AddDeviceView.init(store:)
                )
            }
        }
    }
}

#Preview {
    DevicesView(store: Store(initialState: DevicesFeature.State(
        devices: [
            Device(id: UUID(), name: "Living Room")
        ])) {
            DevicesFeature()
        })
}
