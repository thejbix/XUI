//
//  ErasedObservableObject.swift
//  XUI
//
//  Created by Paul Kraft on 01.03.21.
//  Copyright © 2021 QuickBird Studios. All rights reserved.
//

class ErasedObservableObject: ObservableObject {

    let objectWillChange: AnyPublisher<Void, Never>

    init(objectWillChange: AnyPublisher<Void, Never>) {
        self.objectWillChange = objectWillChange
    }

    static func empty() -> ErasedObservableObject {
        .init(objectWillChange: Empty().eraseToAnyPublisher())
    }
}


class ErasedObservableObjectArray: ObservableObject {

    let objectWillChangeList: [AnyPublisher<Void, Never>]

    init(objectWillChangeList: [AnyPublisher<Void, Never>]) {
        self.objectWillChangeList = objectWillChangeList
    }

    static func empty() -> ErasedObservableObjectArray {
        .init(objectWillChangeList: [Empty().eraseToAnyPublisher()])
    }
}
