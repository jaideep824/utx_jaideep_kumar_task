//
//  CryptoListViewModelTests.swift
//  JaideepTaskCryptoTests
//
//  Created by Jaideep on 27/01/25.
//

import XCTest
@testable import JaideepTaskCrypto

final class CryptoListViewModelTests: XCTestCase {
    var sut: CryptoListViewModel!
    
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        
        let mockStorageService = MockLocalStorage()
        sut = CryptoListViewModel(storageService: mockStorageService)
    }

    override func tearDownWithError() throws {
        sut = nil
        try super.tearDownWithError()
    }
    
    // TODO: add unit tests 
}
