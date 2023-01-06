//
//  CoreDataManagerProtocol.swift
//  randomUser.me
//
//  Created by Maximilien Oteifeh--Pfennig on 26/09/2022.
//

protocol CoreDataManagerProtocol: AnyObject {
    func saveUsers(users: [User])
    func loadUsers() -> [User]
}
