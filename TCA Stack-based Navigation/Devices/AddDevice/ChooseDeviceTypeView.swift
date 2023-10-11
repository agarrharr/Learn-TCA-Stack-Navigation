import ComposableArchitecture
import SwiftUI

struct ChooseDeviceTypeView: View {
    let store: StoreOf<ChooseDeviceTypeFeature>
    
    var body: some View {
        List {
            Button("V1 device") {
                store.send(.deviceTypeTapped(.v1))
            }
            Button("V2 device") {
                store.send(.deviceTypeTapped(.v2))
            }
            Button("Pro device") {
                store.send(.deviceTypeTapped(.pro))
            }
        }
    }
}

#Preview {
    ChooseDeviceTypeView(store: Store(initialState: ChooseDeviceTypeFeature.State(), reducer: {
        ChooseDeviceTypeFeature()
    }))
}
