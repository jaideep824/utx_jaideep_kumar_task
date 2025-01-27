//
//  CryptoListViewModel.swift
//  JaideepTaskCrypto
//
//  Created by Jaideep on 26/01/25.
//

import Combine
import Foundation

class CryptoListViewModel {
    // MARK: - Variables
    private let storageService: any LocalStorage
    private var securedCryptoListCopy: [Crypto] = []
    private(set) var filteredCryptoList: [Crypto] = []
    private var cancellables = Set<AnyCancellable>()
    private(set) var cryptoListUpdated = PassthroughSubject<Void, Never>()
    private(set) var filterSelectedState: [FilterOption: Bool] = [:]
   
    init(storageService: any LocalStorage) {
        self.storageService = storageService
    }
    
    // MARK: - Exposed Apis
    func search(text: String) {
        // TODO: add debounce logic for search
        
        if text.isEmpty {
            filteredCryptoList = securedCryptoListCopy
            return
        }
        
        filteredCryptoList.removeAll()
        for cryto in securedCryptoListCopy {
            if (cryto.name?.localizedCaseInsensitiveContains(text) ?? false)  || (cryto.symbol?.localizedCaseInsensitiveContains(text) ?? false) {
                filteredCryptoList.append(cryto)
            }
        }
    }
    
    @discardableResult
    func filterCryptos(_ filters: [FilterOption], selectedState: [FilterOption: Bool]) -> [Crypto] {
        filterSelectedState = selectedState
        var predicates: [NSPredicate] = []
        
        if selectedState[.activeCoins] != nil {
            let predicate = NSPredicate(format: "isActive == YES")
            predicates.append(predicate)
        }
        
        if selectedState[.inactiveCoins] != nil {
            let predicate = NSPredicate(format: "isActive == NO")
            predicates.append(predicate)
        }
        
        if selectedState[.onlyToken] != nil {
            let predicate = NSPredicate(format: "type == %@", CryptoType.token.rawValue)
            predicates.append(predicate)
        }
        
        if selectedState[.onlyCoins] != nil {
            let predicate = NSPredicate(format: "type == %@", CryptoType.coin.rawValue)
            predicates.append(predicate)
        }
        
        if selectedState[.newCoins] != nil {
            let predicate = NSPredicate(format: "isNew == YES")
            predicates.append(predicate)
        }
        
        let compoundPredicate = NSCompoundPredicate(andPredicateWithSubpredicates: predicates)
        if let savedCryptos = try? Crypto.fetchSavedCrypto(predicate: compoundPredicate) {
            self.securedCryptoListCopy = savedCryptos
            self.filteredCryptoList = savedCryptos
            self.cryptoListUpdated.send()
        }
    
        return filteredCryptoList
    }
    
    
    // MARK: - Webservices
    func fetchCyptoList(refreshFromRemote: Bool = false) {
        if let savedCryptos = try? Crypto.fetchSavedCrypto(), !savedCryptos.isEmpty {
            self.securedCryptoListCopy = savedCryptos
            self.filteredCryptoList = savedCryptos
            self.cryptoListUpdated.send()
            
            if refreshFromRemote {
                fetchCryptoListFromRemote()
            }
        } else {
            fetchCryptoListFromRemote()
        }
    }
}

private extension CryptoListViewModel {
    func fetchCryptoListFromRemote() {
        let config = NetworkConfig(endPoint: nil)
        let response: Future<[Crypto], NetworkError> = Networking.shared.fetchData(with: config,
                                                                                   decoder: storageService.decoder)
        response
            .receive(on: RunLoop.main)
            .sink {[weak self] completion in
                switch completion {
                case .failure(let error):
                    self?.securedCryptoListCopy = []
                    debugPrint(error.localizedDescription)
                case .finished:
                    debugPrint("Finished successfully.")
                }
            } receiveValue: {[weak self] cryptoList in
                self?.securedCryptoListCopy = cryptoList
                self?.filteredCryptoList = cryptoList
                self?.saveCrypto()
                self?.cryptoListUpdated.send()
            }
            .store(in: &cancellables)
    }
    
    func saveCrypto() {
        storageService.saveContext()
    }
}
