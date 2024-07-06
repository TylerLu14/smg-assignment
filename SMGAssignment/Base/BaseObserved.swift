//
//  BaseObservedObject.swift
//  SMGAssignment
//
//  Created by Lữ on 7/6/24.
//

import SwiftUI

/// The base view model which all other view models need to inherite from
@Observable
class BaseObserved<Output>: LoadableObject {
    
    typealias State = LoadingState<Output>

    var state: LoadingState<Output> = .idle

    func load() { }
}
