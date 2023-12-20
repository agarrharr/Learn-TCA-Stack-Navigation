import ComposableArchitecture
import SwiftUI

struct DevicesView: View {
    @BindableStore var store: StoreOf<DevicesFeature>

    var body: some View {
        NavigationStack(
            path: $store.scope(state: \.path, action: \.path)
        ) {
            VStack {
                List {
                    ForEach(self.store.state.devices) { device in
                        Text(device.name)
                    }
                }
                Button("Add device") {
                    self.store.send(.addDeviceButtonTapped)
                }

            }
            .padding()
            .navigationTitle("Devices")
        } destination: { store in
            switch store.state {
            case .chooseDeviceType:
                if let store = store.scope(state: \.chooseDeviceType, action: \.chooseDeviceType) {
                     ChooseDeviceTypeView(store: store)
                }

            case .addDeviceIntro:
                if let store = store.scope(state: \.addDeviceIntro, action: \.addDeviceIntro) {
                    AddDeviceIntroView(store: store)
                }

            case .onboardDeviceType(_):
                if let store = store.scope(state: \.onboardDeviceType, action: \.onboardDeviceType) {
                    OnboardDeviceTypeView(store: store)
                }
            }
        }
    }
}

#Preview {
    DevicesView(store: Store(initialState: DevicesFeature.State(
        devices: [
            Device(id: UUID(), name: "Living Room", type: .pro)
        ])) {
            DevicesFeature()
        })
}
