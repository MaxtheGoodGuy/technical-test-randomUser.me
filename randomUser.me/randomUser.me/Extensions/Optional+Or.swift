//
//  Optional+Or.swift
//  randomUser.me
//
//  Created by Maximilien Oteifeh--Pfennig on 26/09/2022.
//

extension Optional {
    func or(_ defaultValue: Wrapped) -> Wrapped {
        switch self {
        case .some(let value): return value
        case .none: return defaultValue
        }
    }
}

extension Optional where Wrapped == String {
    var orEmpty: String {
        or("")
    }
}
