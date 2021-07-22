//
//  StorageProvider.swift
//  BTravellr
//
//  Created by Rebecca Mello on 20/07/21.
//

import CoreData
class CoreDataStack {
    
    // load the model file and set up the Core Data store
    static var shared = CoreDataStack()
    
    private let model: String

    private lazy var container: NSPersistentContainer = {
        let container = NSPersistentContainer(name: self.model)
        let defaultURL = NSPersistentContainer.defaultDirectoryURL()
        let sqliteURL = defaultURL.appendingPathComponent("\(self.model).sqlite")

        container.loadPersistentStores { (_, error) in
            if let error = error {
                fatalError("Failed to load persistent store: \(error.localizedDescription)")
            }
        }

        return container
    }()

    var mainContext: NSManagedObjectContext {
        return container.viewContext
    }

    private init(model: String = "Model") {
        self.model = model
    }

    func save() throws {
        if mainContext.hasChanges {
            do {
                try mainContext.save()
            } catch {
                throw CoreDataStackError.failedToSave
            }
        } else {
            throw CoreDataStackError.contextHasNoChanges
        }
    }
    
    func createTrip(name: String, destination: String, dataIda: String, dataVolta: String) throws -> Trip{
        let trip = Trip(context: mainContext)
        trip.name = name
        trip.destination = destination
        trip.dataIda = dataIda
        trip.dataVolta = dataVolta
        try save()
        return trip
    }
}

enum CoreDataStackError: Error {
    case failedToSave
    case contextHasNoChanges
}
