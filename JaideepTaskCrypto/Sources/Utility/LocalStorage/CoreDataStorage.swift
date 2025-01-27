//
//  CoreDataStorage.swift
//  JaideepTaskCrypto
//
//  Created by Jaideep on 26/01/25.
//

import CoreData
import Foundation

class CoreDataStorage: LocalStorage {
    typealias ServiceType = CoreDataStorage
    
    // MARK: - Variables
    static let shared = CoreDataStorage()
    static let modelName = "JaideepTaskCrypto"
    var decoder: JSONDecoder
    
    // MARK: Lazy
    lazy var persistentContainer: NSPersistentContainer = {
        let persistentContainer = NSPersistentContainer(name: Self.modelName)
        if let description = persistentContainer.persistentStoreDescriptions.first {
            description.shouldMigrateStoreAutomatically = true
            description.shouldInferMappingModelAutomatically = true
        }
        
        persistentContainer.loadPersistentStores { storeDescription, error in
            if let error = error as? NSError {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
        return persistentContainer
    }()
    
    // MARK: - Initialisation
    init() {
        decoder = JSONDecoder()
        decoder.userInfo[CodingUserInfoKey.managedObjectContext] = persistentContainer.viewContext
    }
    
    // MARK: - Functions
    func saveContext() {
        let context = persistentContainer.viewContext
        
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                if nserror.code == NSManagedObjectConstraintMergeError {
                    debugPrint("Conflict error: \(error.localizedDescription)")
                } else {
                    fatalError("Unresolved error \(error), \(nserror.userInfo)")
                }
            }
        }
    }
}
