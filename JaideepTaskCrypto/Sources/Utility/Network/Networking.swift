//
//  Networking.swift
//  JaideepTaskCrypto
//
//  Created by Jaideep on 26/01/25.
//

import Combine
import Foundation

class Networking {
    // MARK: - Variables
    static let shared = Networking()
    private var cancellables = Set<AnyCancellable>()
    
    // MARK: - Initialisation
    private init() {
        
    }
    
    // MARK: - Exposed Functions
    func fetchData<T: Codable>(with config: NetworkConfig, decoder: JSONDecoder = JSONDecoder()) -> Future<T, NetworkError> {
        return Future { [weak self] promise in
            guard let `self` = self else {
                promise(.failure(.deinitialisedBeforeHandling))
                return
            }
            
            guard let url = config.url else {
                promise(.failure(.invalidURL))
                return
            }
            
            let request = URLRequest(url: url)
            URLSession.shared.dataTaskPublisher(for: request)
                .map { data, resposne in
                    return data
                }
                .decode(type: T.self, decoder: decoder)
                .receive(on: RunLoop.main)
                .sink { failure in
                    print(failure)
                    promise(.failure(.somethingWentWrong))
                } receiveValue: { model in
                    promise(.success(model))
                }
                .store(in: &cancellables)
        }
    }
}
