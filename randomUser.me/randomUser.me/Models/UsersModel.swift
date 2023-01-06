//
//  UserModel.swift
//  randomUser.me
//
//  Created by Maximilien Oteifeh--Pfennig on 26/09/2022.
//

import CoreData

struct UsersModel: Codable {
    let results : [User]
}

struct User: Hashable, Codable {
    let uuid = UUID() // to prevent a potential duplication into the DiffableDataSource
    let name: Name
    let email: String

    init(name: User.Name, email: String) {
        self.name = name
        self.email = email
    }

    init(dbUser: DbUser) {
        name = .init(first: dbUser.firstName.orEmpty, last: dbUser.lastName.orEmpty)
        email = dbUser.email.orEmpty
    }

    private enum CodingKeys: String, CodingKey {
        case name
        case email
    }

    struct Name: Hashable, Codable {
        let first: String
        let last: String

        var fullName: String {
            "\(first) \(last)"
        }
    }
}
