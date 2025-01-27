//
//  Crypto.swift
//  JaideepTaskCrypto
//
//  Created by Jaideep on 26/01/25.
//

import CoreData
import Foundation

@objc(Crypto)
class Crypto: NSManagedObject, Codable {
    // MARK: - Variables
    static let entityName = "Crypto"
    var cryptoType: CryptoType? {
        return CryptoType(rawValue: type ?? "")
    }
    
    // MARK: - Types
    enum CodingKeys: String, CodingKey {
        case id, name, symbol, type
        case isActive = "is_active"
        case isNew = "is_new"
    }
    
    // MARK: - Initialisation
    required convenience init(from decoder: any Decoder) throws {
        guard let context = decoder.userInfo[CodingUserInfoKey.managedObjectContext] as? NSManagedObjectContext else {
            throw DecoderConfigurationError.missingManagedObjectContext
        }
        
        self.init(context: context)
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try container.decodeIfPresent(String.self, forKey: .name)
        symbol = try container.decodeIfPresent(String.self, forKey: .symbol)
        type = try container.decodeIfPresent(String.self, forKey: .type)
        isActive = try container.decodeIfPresent(Bool.self, forKey: .isActive) ?? false
        isNew = try container.decodeIfPresent(Bool.self, forKey: .isNew) ?? false
        id = ((name ?? "") + (symbol ?? "") + (type ?? "")).lowercased()
    }
    
    func encode(to encoder: any Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
        try container.encode(symbol, forKey: .symbol)
        try container.encode(type, forKey: .type)
        try container.encode(isActive, forKey: .isActive)
        try container.encode(isNew, forKey: .isNew)
    }
}

// MARK: - Storage Utility
extension Crypto {
    static func fetchSavedCrypto(predicate: NSPredicate? = nil,
                                 in context: NSManagedObjectContext = CoreDataStorage.shared.persistentContainer.viewContext) throws -> [Crypto] {
        let request: NSFetchRequest<Crypto> = Crypto.fetchRequest()
        request.predicate = predicate
        request.sortDescriptors = [NSSortDescriptor(key: "name", ascending: true)]
        return try context.fetch(request)
    }
}
