//
//  StorageUtility.swift
//  JaideepTaskCrypto
//
//  Created by Jaideep on 26/01/25.
//

import Foundation

extension CodingUserInfoKey {
  static let managedObjectContext = CodingUserInfoKey(rawValue: "managedObjectContext")!
}

enum DecoderConfigurationError: Error {
    case missingManagedObjectContext
}

