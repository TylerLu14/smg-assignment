//
//  AnyPublisherExtension.swift
//  SMGAssignment
//
//  Created by Lữ on 7/6/24.
//

import Combine
import Foundation

extension AnyPublisher {
    struct Subscriber {
        fileprivate let send: (Output) -> Void
        fileprivate let complete: (Subscribers.Completion<Failure>) -> Void

        func send(_ value: Output) { self.send(value) }
        func send(completion: Subscribers.Completion<Failure>) { self.complete(completion) }
    }

    init(queue: DispatchQueue = .main, _ closure: @escaping (Subscriber) -> AnyCancellable) {
        self = Deferred {
            let subject = PassthroughSubject<Output, Failure>()
            var cancellable: AnyCancellable?

            return subject
                .handleEvents(
                    receiveCancel: { cancellable?.cancel() },
                    receiveRequest: { demand in
                        precondition(demand == .unlimited, "AnyPublisher.init only works with unlimited demand")
                        queue.async {
                            cancellable = closure(Subscriber(send: subject.send(_:), complete: subject.send(completion:)))
                        }
                    }
                )
        }
        .eraseToAnyPublisher()
    }
}
