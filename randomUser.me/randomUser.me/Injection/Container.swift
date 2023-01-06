//
//  Container.swift
//  randomUser.me
//
//  Created by Maximilien Oteifeh--Pfennig on 26/09/2022.
//

final class Container {
    static private var factories: [String: () -> Any] = [:]

    static func register<T>(_ type: T.Type, _ factory: @autoclosure @escaping () -> T) {
        factories[String(describing: type)] = factory
    }

    static func resolve<T>() -> T {
        let typeDescription = String(describing: T.self)
        guard let resolved = factories[typeDescription]?() as? T else {
            fatalError("Could not resolve `\(typeDescription)`!")
        }
        return resolved
    }

    static func reset() {
        factories = [:]
    }
}
