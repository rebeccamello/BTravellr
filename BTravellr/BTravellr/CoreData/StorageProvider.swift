//
//  StorageProvider.swift
//  BTravellr
//
//  Created by Rebecca Mello on 20/07/21.
//

import CoreData
class StorageProvider {
    // load the model file and set up the Core Data store
    let persistentContainer: NSPersistentContainer
    static var shared: StorageProvider = StorageProvider()
    private init() {
        persistentContainer = NSPersistentContainer(name:"BTravellr")
        persistentContainer.loadPersistentStores(completionHandler: { description, error in
        if let error = error {
            fatalError("Core Data store failed to load with error: \(error)") }
        })
    }
}

//extension StorageProvider {
//    @objc func actSave(named name: String){
//        let trip = Trip(context: persistentContainer.viewContext)
//        trip.name = name
//        do {
//            try persistentContainer.viewContext.save()
//            print("Movie saved succesfully")
//        }
//        catch {
//            print("Failed to save movie: \(error)")
//        }
//    }
//}
