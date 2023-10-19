import ComposableArchitecture
import SwiftUI

struct ContentView: View {
    var body: some View {
        DevicesView(store: Store(initialState: DevicesFeature.State(devices: [])) {
            DevicesFeature()._printChanges()
        })
    }
}

#Preview {
    ContentView()
}
