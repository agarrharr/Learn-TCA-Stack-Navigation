import ComposableArchitecture
import SwiftUI

struct AddDeviceIntroView: View {
    let store: StoreOf<AddDeviceIntroFeature>
    
    var body: some View {
        VStack {
            Text("Hey kid!")
            Text("Let's get you set up with a new device!")
            Spacer()
            Button("Let's go!") {
                store.send(.letsGoButtonTapped)
            }
        }
    }
}

#Preview {
    AddDeviceIntroView(store: Store(initialState: AddDeviceIntroFeature.State(), reducer: {
        AddDeviceIntroFeature()
    }))
}
