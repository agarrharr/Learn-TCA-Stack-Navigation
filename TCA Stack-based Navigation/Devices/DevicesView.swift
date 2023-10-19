import ComposableArchitecture
import SwiftUI

struct DevicesView: View {
    let store: StoreOf<DevicesFeature>
    
    var body: some View {
        NavigationStackStoreBP(
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
                        viewStore.send(.addDeviceButtonTapped)
                    }
                    
                }
                .padding()
                .navigationTitle("Devices")
            }
        } destination: { state in
            switch state {
            case .chooseDeviceType:
                CaseLet(
                    /DevicesFeature.Path.State.chooseDeviceType,
                     action: DevicesFeature.Path.Action.chooseDeviceType,
                     then: ChooseDeviceTypeView.init(store:)
                )

            case .addDeviceIntro:
                CaseLet(
                    /DevicesFeature.Path.State.addDeviceIntro,
                     action: DevicesFeature.Path.Action.addDeviceIntro,
                     then: AddDeviceIntroView.init(store:)
                )
            case .onboardDeviceType(_):
                CaseLet(
                    /DevicesFeature.Path.State.onboardDeviceType,
                     action: DevicesFeature.Path.Action.onboardDeviceType,
                     then: OnboardDeviceTypeView.init(store:)
                )
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
