import ComposableArchitecture
import SwiftUI

struct AddDeviceFeature: Reducer {
    struct State: Equatable {
        
    }
    
    enum Action: Equatable {
        
    }
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            return .none
        }
    }
}

struct AddDeviceView: View {
    var body: some View {
        Text("Add device")
    }
}

#Preview {
    AddDeviceView()
}
