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
    var cardNumber: String = Card.generateCardNumber()
    var expiryDate: String = Card.generateExpiryDate()
    var cvv: String = Card.generateCVV()
    var purpose: CardPurpose
    var gradientIndex: Int = 0
    
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

extension Card {
    static func generateCardNumber() -> String {
        (1...4).map { _ in
            String(format: "%04d", Int.random(in: 0...9999))
        }.joined(separator: " ")
    }
    
    static func generateExpiryDate() -> String {
        let futureDate = Calendar.current.date(byAdding: .year, value: Int.random(in: 3...5), to: Date())!
        let month = Calendar.current.component(.month, from: futureDate)
        let year = Calendar.current.component(.year, from: futureDate) % 100
        return String(format: "%02d/%02d", month, year)
    }
    
    static func generateCVV() -> String {
        String(format: "%03d", Int.random(in: 0...999))
    }
}
