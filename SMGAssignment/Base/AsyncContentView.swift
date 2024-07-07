//
//  AsyncContentView.swift
//  SMGAssignment
//
//  Created by Lữ on 7/6/24.
//

import SwiftUI
import Combine

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
protocol LoadableObject {
    associatedtype Output
    /// Current state of the object
    var state: LoadingState<Output> { get }
    /// The loading function
    func load()
}

/// The view that can be loaded asynchronously
struct AsyncContentView<Source: LoadableObject, InitialView: View, LoadingView: View, Content: View, ErrorView: View>: View {
    /// The source of truth
    var source: Source
    /// The view that is used to display the loading status
    var initialView: () -> InitialView
    /// The view that is used to display the loading status
    var loadingView: () -> LoadingView
    /// The view that is used to display the loading status
    var errorView: (Error) -> ErrorView
    /// The content which is shown
    var content: (Source.Output) -> Content

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
        @ViewBuilder initialView: @escaping () -> InitialView = { Color.clear },
        @ViewBuilder loadingView: @escaping () -> LoadingView = { Color.clear },
        @ViewBuilder errorView: @escaping (Error) -> ErrorView = { _ in Color.clear },
        @ViewBuilder content: @escaping (Source.Output) -> Content
    ) {
        self.source = source
        self.initialView = initialView
        self.loadingView = loadingView
        self.errorView = errorView
        self.content = content
    }
}

/// An object can can boradcast its loading status
@Observable class PublishedObject<Wrapped: Publisher>: LoadableObject {
    private(set) var state = LoadingState<Wrapped.Output>.idle

    @ObservationIgnored
    private let publisher: Wrapped
    
    @ObservationIgnored
    private var cancellables = Set<AnyCancellable>()

    init(publisher: Wrapped) {
        self.publisher = publisher
    }
    /// Start the loading process of the object and broadcast its status
    func load() {
        state = .loading

        publisher
            .map(LoadingState.loaded)
            .catch { error in
                Just(LoadingState.failed(error))
            }
            .receive(on: RunLoop.main)
            .sink(receiveValue: { value in
                self.state = value
            })
            .store(in: &cancellables)
    }
}

extension AsyncContentView {
    init<P: Publisher>(
        publisher: P,
        @ViewBuilder initialView: @escaping () -> InitialView,
        @ViewBuilder loadingView: @escaping () -> LoadingView,
        @ViewBuilder errorView: @escaping (Error) -> ErrorView,
        @ViewBuilder content: @escaping (Source.Output) -> Content
    ) where Source == PublishedObject<P> {
        self.init(
            source: PublishedObject(publisher: publisher),
            initialView: initialView,
            loadingView: loadingView,
            errorView: errorView,
            content: content
        )
    }
}

