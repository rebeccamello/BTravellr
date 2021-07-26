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
            } catch(let error) {
                print(error)
                throw CoreDataStackError.failedToSave
            }
        } else {
            throw CoreDataStackError.contextHasNoChanges
        }
    }
    
    //MARK: Trip
    func createTrip(name: String, destination: String, dataIda: String, dataVolta: String) throws -> Trip{
        let trip = Trip(context: mainContext)
        trip.name = name
        trip.destination = destination
        trip.dataIda = dataIda
        trip.dataVolta = dataVolta
        try save()
        return trip
    }
    
    func deleteTrip(trip: Trip) throws{
        mainContext.delete(trip)
        try save()
    }
    
    //MARK: Bag Items
    func createBagItem(itemName: String, trip: Trip) throws -> Bag{
        let item = Bag(context: mainContext)
        item.itemName = itemName
        trip.addToTripBagItems(item)
        try save()
        return item
    }
    
    func deleteBagItem(item: Bag) throws{
        mainContext.delete(item)
        try save()
    }
    
    //MARK: Notes
    func createNote(textInput: String, trip: Trip) throws{
        let text = Notes(context: mainContext)
        text.text = textInput
        trip.tripNotes = text
        try save()
    }
    
    func editNote(note: Notes, text: String) throws{
        note.text = text
        try save()
    }
    
    //MARK: Photos
    func saveImage(data: Data, trip: Trip) throws -> Data{
        let imageInstance = Images(context: mainContext)
        imageInstance.img = data
        trip.addToTripPhotos(imageInstance)
        try save()
        return data
    }
    
    //MARK: Cover Image
    func createCoverImage(data: Data, trip: Trip) throws -> Data{
        let coverImage = CoverImage(context: mainContext)
        coverImage.coverName = data
        trip.tripCoverImge = coverImage
        try save()
        return data
    }
    
    func editCoverImage(data: Data, trip: Trip) throws -> Data{
        trip.coverImage = data
        try save()
        return data
    }
}

enum CoreDataStackError: Error {
    case failedToSave
    case contextHasNoChanges
}
