//
//  MockLocalStorage.swift
//  JaideepTaskCryptoTests
//
//  Created by Jaideep on 27/01/25.
//

import Foundation
@testable import JaideepTaskCrypto

class MockLocalStorage: LocalStorage {
    typealias ServiceType = MockLocalStorage
    
    // MARK: - Variables
    static let shared = MockLocalStorage()
    var decoder: JSONDecoder
    
    // MARK: - Initialisation
    init() {
        decoder = JSONDecoder()
    }
    
    // MARK: - Functions
    func saveContext() {
        
    }
}
