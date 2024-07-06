//
//  AsyncContentView.swift
//  SMGAssignment
//
//  Created by Lữ on 7/6/24.
//

import SwiftUI
import Combine


extension LoadingState: ReflectiveEquatable { }

/// Define loading state of a view
enum LoadingState<Value> {
    /// Do nothing state or normal state
    case idle
    /// Loading state, usually being used when in data loading
    case loading
    /// State of failure
    case failed(Error)
    /// State of loading successfully
    case loaded(Value)
}

/// An observable object whom its loading state can be tracked
protocol LoadableObject: ObservableObject {
    associatedtype Output
    /// Current state of the object
    var state: LoadingState<Output> { get }
    /// The loading function
    func load()
}

/// The view that can be loaded asynchronously
struct AsyncContentView<Source: LoadableObject, InitialView: View, LoadingView: View, Content: View, ErrorView: View>: View {
    /// The source of truth
    @ObservedObject var source: Source
    /// The view that is used to display the loading status
    var initialView: () -> InitialView
    /// The view that is used to display the loading status
    var loadingView: () -> LoadingView
    /// The view that is used to display the loading status
    var errorView: (Error) -> ErrorView
    /// The content which is shown
    var content: (Source.Output) -> Content

    @State private var isLoadingPresented = false

    var body: some View {
        switch source.state {
        case .idle:
            initialView().onAppear(perform: source.load)
        case .loading:
            loadingView()
        case .failed(let error):
            errorView(error)
        case .loaded(let output):
            content(output)
        }
    }

    init(
        source: Source,
        @ViewBuilder initialView: @escaping () -> InitialView,
        @ViewBuilder loadingView: @escaping () -> LoadingView,
        @ViewBuilder errorView: @escaping (Error) -> ErrorView,
        @ViewBuilder content: @escaping (Source.Output) -> Content
    ) {
        self.source = source
        self.initialView = initialView
        self.loadingView = loadingView
        self.errorView = errorView
        self.content = content
    }
}
