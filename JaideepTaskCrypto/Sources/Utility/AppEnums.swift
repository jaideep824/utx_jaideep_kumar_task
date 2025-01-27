//
//  AppEnums.swift
//  JaideepTaskCrypto
//
//  Created by Jaideep on 26/01/25.
//

import Foundation

@frozen
enum CryptoType: String, Codable {
    case coin
    case token
}

@frozen
enum FilterOption: String, CaseIterable {
    case activeCoins = "Active Coins"
    case onlyToken = "Only Tokens"
    case onlyCoins = "Only Coins"
    case newCoins = "New Coins"
    case inactiveCoins = "Inactive Coins"
    
    var contradictoryCases: [FilterOption] {
        switch self {
        case .activeCoins:
            return [.inactiveCoins]
        case .onlyToken:
            return [.onlyCoins]
        case .onlyCoins:
            return [.onlyToken]
        case .inactiveCoins:
            return [.activeCoins]
        default:
            return []
        }
    }
}
