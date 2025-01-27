//
//  LocalStorage.swift
//  JaideepTaskCrypto
//
//  Created by Jaideep on 26/01/25.
//

import Foundation

protocol LocalStorage {
    associatedtype ServiceType
    static var shared: ServiceType { get }
    var decoder: JSONDecoder { get }
    func saveContext()
}
