import ComposableArchitecture
import SwiftUI

struct AddDeviceFeature: Reducer {
    struct State: Equatable {
        
    }
    
    enum Action: Equatable {
        case letsGoButtonTapped
    }
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            return .none
        }
    }
}

struct AddDeviceView: View {
    let store: StoreOf<AddDeviceFeature>
    
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
    AddDeviceView(store: Store(initialState: AddDeviceFeature.State(), reducer: {
        AddDeviceFeature()
    }))
}
