//
//  Card.swift
//  SafeBolt
//
//  Created by mac on 11/11/25.
//
import SwiftUI

struct Card: Identifiable, Codable, Equatable {
    var id = UUID()
    var cardholderName: String
    var cardNumber: String
    var expiryDate: String
    var cvv: String
    var purpose: CardPurpose
    var cardType: CardType
    var gradientIndex: Int = 0
    var balance: Double = 0.0
    
    var gradient: LinearGradient {
        cardGradients[gradientIndex % cardGradients.count]
    }
}

enum CardPurpose : String, Codable, CaseIterable, Identifiable {
    case personal = "Personal"
    case business = "Business"
    case savings = "Savings"
    var id: String { self.rawValue }
}

enum CardType: String, Codable, CaseIterable, Identifiable {
    case visa = "Visa"
    case mastercard = "MasterCard"
    case amex = "American Express"
    var id: String { self.rawValue }
}

extension Card {
    static func generateCardNumber(for type: CardType) -> String {
        switch type {
        case .visa:
            let prefix = "4" + String(format: "%03d", Int.random(in: 0...999))
            let group2 = String(format: "%04d", Int.random(in: 0...9999))
            let group3 = String(format: "%04d", Int.random(in: 0...9999))
            let group4 = String(format: "%04d", Int.random(in: 0...9999))
            return [prefix, group2, group3, group4].joined(separator: " ")
            
        case .mastercard:
            let randomDigit = String(Int.random(in: 1...5))
            let prefix = "5" + randomDigit + String(format: "%02d", Int.random(in: 0...99))
            let group2 = String(format: "%04d", Int.random(in: 0...9999))
            let group3 = String(format: "%04d", Int.random(in: 0...9999))
            let group4 = String(format: "%04d", Int.random(in: 0...9999))
            return [prefix, group2, group3, group4].joined(separator: " ")
            
        case .amex:
            let prefix = "3" + (Bool.random() ? "4" : "7") + String(format: "%02d", Int.random(in: 0...99))
            let group2 = String(format: "%06d", Int.random(in: 0...999999))
            let group3 = String(format: "%05d", Int.random(in: 0...99999))
            return [prefix, group2, group3].joined(separator: " ")
        }
    }
    
    static func generateExpiryDate() -> String {
        let futureDate = Calendar.current.date(byAdding: .year, value: Int.random(in: 3...5), to: Date())!
        let month = Calendar.current.component(.month, from: futureDate)
        let year = Calendar.current.component(.year, from: futureDate) % 100
        return String(format: "%02d/%02d", month, year)
    }
    
    static func generateCVV(for type: CardType) -> String {
        if type == .amex {
            return String(format: "%04d", Int.random(in: 0...9999))
        } else {
            return String(format: "%03d", Int.random(in: 0...999))
        }
    }
}
