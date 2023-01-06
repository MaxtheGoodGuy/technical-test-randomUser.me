//
//  CoreDataManager.swift
//  randomUser.me
//
//  Created by Maximilien Oteifeh--Pfennig on 26/09/2022.
//

import CoreData

final class CoreDataManager: CoreDataManagerProtocol {
    static let shared: CoreDataManager = .create()

    private static func create() -> CoreDataManager {
        let container = NSPersistentContainer(name: "randomUser_me")

        container.loadPersistentStores { _, error in
            if let error = error {
                fatalError("Unable to load from randomUserDB: \(error)")
            }
        }
        container.viewContext.automaticallyMergesChangesFromParent = true

        return CoreDataManager(container: container)
    }

    private let viewContext: NSManagedObjectContext
    private let container: NSPersistentContainer

    private init(container: NSPersistentContainer) {
        self.container = container
        self.viewContext = container.viewContext
    }

    // MARK: CoreDataManagerProtocol
    func saveUsers(users: [User]) {
        eraseUsers()
        users
            .enumerated()
            .forEach { index, user in
                let newUser = DbUser(context: viewContext)
                newUser.firstName = user.name.first
                newUser.lastName = user.name.last
                newUser.email = user.email
            }

        do {
            try viewContext.save()
        }
        catch {
            print("Could not save users: \(error)")
        }
    }

    func loadUsers() -> [User] {
        var loadedUsers: [User] = []
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "DbUser")
        do {
            let dbUsers: [DbUser] = try (viewContext.fetch(fetchRequest) as! [DbUser])
            dbUsers.forEach { dbUser in
                let user = User(dbUser: dbUser)
                loadedUsers.append(user)
            }
        } catch let error as NSError {
            print("Could not load users: \(error)")
        }
        return loadedUsers
    }

    // MARK: Private
    private func eraseUsers() {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "DbUser")
        let batchDelete = try? viewContext.execute(NSBatchDeleteRequest(fetchRequest: fetchRequest)) as? NSBatchDeleteResult

        guard let deleteResult = batchDelete?.result as? [NSManagedObjectID] else { return }

        NSManagedObjectContext.mergeChanges(
            fromRemoteContextSave: [NSDeletedObjectsKey: deleteResult],
            into: [viewContext]
        )
    }
}
