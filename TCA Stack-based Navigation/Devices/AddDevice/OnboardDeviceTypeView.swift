import ComposableArchitecture
import SwiftUI

struct OnboardDeviceTypeView: View {
    let store: StoreOf<OnboardDeviceTypeFeature>
    
    var body: some View {
        WithViewStore(store, observe: { $0 }) { viewStore in
            if viewStore.state.devices.isEmpty {
                VStack {
                    Text("Searching for \(viewStore.state.deviceType.description) devices nearby...")
                    ProgressView()
                    Spacer()
                }
            } else {
                List {
                    ForEach(viewStore.state.devices) { device in
                        HStack {
                            Text(device.id.uuidString)
                            Spacer()
                            Text(device.signalStrength.description)
                        }
                    }
                }
            }
        }
        .onAppear {
            store.send(.view(.didAppear))
        }
    }
}

#Preview {
    OnboardDeviceTypeView(
        store: Store(initialState: OnboardDeviceTypeFeature.State(deviceType: .pro)) {
            OnboardDeviceTypeFeature()
        }
    )
}
