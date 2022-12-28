//
//  Store.swift
//  XUI
//
//  Created by Paul Kraft on 01.03.21.
//  Copyright © 2021 QuickBird Studios. All rights reserved.
//

@propertyWrapper
public struct StoreArray<Model>: DynamicProperty {

    // MARK: Nested types

    @dynamicMemberLookup
    public struct Wrapper {

        fileprivate var store: StoreArray

        public subscript<Value>(dynamicMember keyPath: ReferenceWritableKeyPath<Model, Value>) -> Binding<Value> {
            Binding(get: { self.store.wrappedValue[keyPath: keyPath] },
                    set: { self.store.wrappedValue[keyPath: keyPath] = $0 })
        }

    }

    // MARK: Stored properties

    public let wrappedValue: Model

    @ObservedObject
    private var observableObjectArray: ErasedObservableObjectArray

    // MARK: Computed Properties

    public var projectedValue: Wrapper {
        Wrapper(store: self)
    }

    // MARK: Initialization

    public init(wrappedValue: Model) {
        self.wrappedValue = wrappedValue

        if let wrappedArray = (wrappedValue as? [AnyObservableObject]) {
            let objectWillChangeList = wrappedArray.map{ $0.objectWillChange.eraseToAnyPublisher() }
            self.observableObjectArray = .init(objectWillChangeList: objectWillChangeList)
        } else {
            assertionFailure("Only use the `StoreArray` property wrapper with instances conforming to `[AnyObservableObject]`.")
            self.observableObjectArray = .empty()
        }
    }

    // MARK: Methods
    public mutating func update() {
        _observableObjectArray.update()
    }

}
