import ComposableArchitecture
import SwiftUI

struct ChooseDeviceTypeView: View {
    let store: StoreOf<ChooseDeviceTypeFeature>
    
    var body: some View {
        List {
            Button("V1 device") {
                print("v1")
            }
            Button("V2 device") {
                print("v2")
            }
            Button("Pro device") {
                print("Pro")
            }
        }
    }
}

#Preview {
    ChooseDeviceTypeView(store: Store(initialState: ChooseDeviceTypeFeature.State(), reducer: {
        ChooseDeviceTypeFeature()
    }))
}
