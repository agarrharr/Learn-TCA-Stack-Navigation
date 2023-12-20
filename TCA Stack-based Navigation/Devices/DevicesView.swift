import ComposableArchitecture
import NavigationStackBackport
import SwiftUI

@available(iOS 16, macOS 13, tvOS 16, watchOS 9, *)
extension NavigationStackBackport.NavigationStack {
    /// Drives a navigation stack with a store.
    ///
    /// See the dedicated article on <doc:Navigation> for more information on the library's navigation
    /// tools, and in particular see <doc:StackBasedNavigation> for information on using this view.
    public init<State, Action, Destination: View, R>(
        path: Binding<Store<StackState<State>, StackAction<State, Action>>>,
        root: () -> R,
        @ViewBuilder destination: @escaping (Store<State, Action>) -> Destination
    )
    where
    Data == StackState<State>.PathView,
    Root == ModifiedContent<R, _NavigationDestinationViewModifier<State, Action, Destination>>
    {
        self.init(
            path: Binding(
                get: { path.wrappedValue.observableState.path },
                set: { pathView, transaction in
                    if pathView.count > path.wrappedValue.withState({ $0 }).count,
                       let component = pathView.last
                    {
                        path.transaction(transaction).wrappedValue.send(
                            .push(id: component.id, state: component.element)
                        )
                    } else {
                        path.transaction(transaction).wrappedValue.send(
                            .popFrom(id: path.wrappedValue.withState { $0 }.ids[pathView.count])
                        )
                    }
                }
            )
        ) {
            root()
                .modifier(
                    _NavigationDestinationViewModifier(store: path.wrappedValue, destination: destination)
                )
        }
    }
}

//@available(iOS 16, macOS 13, tvOS 16, watchOS 9, *)
//public struct _NavigationDestinationViewModifier<
//    State: ObservableState, Action, Destination: View
//>:
//    ViewModifier
//{
//    @SwiftUI.State var store: Store<StackState<State>, StackAction<State, Action>>
//    fileprivate let destination: (Store<State, Action>) -> Destination
//
//    public func body(content: Content) -> some View {
//        content
//            .environment(\.navigationDestinationType, State.self)
//            .navigationDestination(for: StackState<State>.Component.self) { component in
//                self
//                    .destination(
//                        self.store.scope(
//                            state: { $0[id: component.id]! },
//                            id: self.store.id(state: \.[id: component.id], action: \.[id: component.id]),
//                            action: { .element(id: component.id, action: $0) },
//                            isInvalid: { !$0.ids.contains(component.id) },
//                            removeDuplicates: nil
//                        )
//                    )
//                    .environment(\.navigationDestinationType, State.self)
//            }
//    }
//}
//
//private struct NavigationDestinationTypeKey: EnvironmentKey {
//    static var defaultValue: Any.Type? { nil }
//}
//
//extension EnvironmentValues {
//    var navigationDestinationType: Any.Type? {
//        get { self[NavigationDestinationTypeKey.self] }
//        set { self[NavigationDestinationTypeKey.self] = newValue }
//    }
//}


struct DevicesView: View {
    @BindableStore var store: StoreOf<DevicesFeature>

    var body: some View {
        NavigationStack(
            path: $store.scope(state: \.path, action: \.path)
        ) {
            VStack {
                List {
                    ForEach(self.store.state.devices) { device in
                        Text(device.name)
                    }
                }
                Button("Add device") {
                    self.store.send(.addDeviceButtonTapped)
                }

            }
            .padding()
            .navigationTitle("Devices")
        } destination: { store in
            switch store.state {
            case .chooseDeviceType:
                if let store = store.scope(state: \.chooseDeviceType, action: \.chooseDeviceType) {
                     ChooseDeviceTypeView(store: store)
                }

            case .addDeviceIntro:
                if let store = store.scope(state: \.addDeviceIntro, action: \.addDeviceIntro) {
                    AddDeviceIntroView(store: store)
                }

            case .onboardDeviceType(_):
                if let store = store.scope(state: \.onboardDeviceType, action: \.onboardDeviceType) {
                    OnboardDeviceTypeView(store: store)
                }
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
