//
//  NetworkUtility.swift
//  JaideepTaskCrypto
//
//  Created by Jaideep on 26/01/25.
//

import Foundation

enum ServerType {
    case mockbin
    
    var baseURL: String {
        switch self {
        case .mockbin:
            return "https://37656be98b8f42ae8348e4da3ee3193f.api.mockbin.io"
        }
    }
}

enum EndPoint: String {
    case demo
}

enum NetworkError: Error {
    case invalidURL
    case invalidData
    case parsingError
    case deinitialisedBeforeHandling
    case somethingWentWrong
}

enum RequestType: String {
    case GET, POST
}
