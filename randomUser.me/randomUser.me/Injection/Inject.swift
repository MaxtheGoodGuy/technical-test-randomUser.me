//
//  Inject.swift
//  randomUser.me
//
//  Created by Maximilien Oteifeh--Pfennig on 26/09/2022.
//

@propertyWrapper
struct Inject<Dependency> {
    lazy var resolvedValue: Dependency = {
        Container.resolve()
    }()

    var wrappedValue: Dependency {
        mutating get {
            resolvedValue
        }
        set {
            resolvedValue = newValue
        }
    }
}
