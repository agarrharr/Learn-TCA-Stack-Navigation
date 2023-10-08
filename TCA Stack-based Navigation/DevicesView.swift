import ComposableArchitecture
import SwiftUI

struct Device: Equatable, Identifiable {
  let id: UUID
  var name: String
}

struct DevicesFeature: Reducer {
    struct State: Equatable {
        var devices: IdentifiedArrayOf<Device>
    }
    
    enum Action {
        case addDeviceAdded
    }
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .addDeviceAdded:
                return .none
            }
        }
    }
}

struct DevicesView: View {
    let store: StoreOf<DevicesFeature>
    
    var body: some View {
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
