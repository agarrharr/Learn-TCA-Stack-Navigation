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
                VStack {
                    List {
                        ForEach(viewStore.state.devices) { device in
                            HStack {
                                Text(device.id.uuidString)
                                Spacer()
                                Text(device.signalStrength.description)
                            }
                        }
                    }
                    Button("Exit") {
                        store.send(.view(.exitButtonTapped))
                    }
                }
            }
        }
        .onAppear {
            store.send(.view(.didAppear))
        }
        .navigationTitle("Searching")
    }
}

#Preview {
    OnboardDeviceTypeView(
        store: Store(initialState: OnboardDeviceTypeFeature.State(deviceType: .pro)) {
            OnboardDeviceTypeFeature()
        }
    )
}
