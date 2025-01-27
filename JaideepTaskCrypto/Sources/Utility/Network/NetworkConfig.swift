//
//  NetworkConfig.swift
//  JaideepTaskCrypto
//
//  Created by Jaideep on 26/01/25.
//

import Foundation

struct NetworkConfig {
    // MARK: - Variables
    let server: ServerType
    let requestType: RequestType
    let endPoint: EndPoint?
    var keyCodingStrategy: JSONDecoder.KeyDecodingStrategy = .convertFromSnakeCase
    
    // MARK: - Initialisation
    init(server: ServerType = .mockbin, requestType: RequestType = .GET, endPoint: EndPoint?) {
        self.server = server
        self.requestType = requestType
        self.endPoint = endPoint
    }
    
    // MARK: - Exposed
    var url: URL? {
        guard let endPoint else {
            return URL(string: server.baseURL)
        }
        let urlString = "\(server.baseURL)/\(endPoint.rawValue)"
        return URL(string: urlString)
    }
}
