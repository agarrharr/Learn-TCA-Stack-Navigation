import ComposableArchitecture
import SwiftUI

struct OnboardDeviceTypeView: View {
    let store: StoreOf<OnboardDeviceTypeFeature>
    
    var body: some View {
        WithViewStore(store, observe: { $0 }) { viewStore in
            Text("Onboard \(viewStore.state.deviceType.description)")
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
